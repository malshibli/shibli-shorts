import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class UploadShort extends StatefulWidget {
  const UploadShort({super.key});

  @override
  State<UploadShort> createState() => _UploadShortState();
}

class _UploadShortState extends State<UploadShort> {
  bool isUploading = false;
  String? statusMessage;

  Future<void> uploadVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      setState(() {
        isUploading = true;
        statusMessage = "Uploading...";
      });

      final file = File(result.files.single.path!);
      final fileName = result.files.single.name;
      final ref = FirebaseStorage.instance.ref().child("shorts/$fileName");

      try {
        await ref.putFile(file);
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection("shorts").add({
          "url": url,
          "timestamp": FieldValue.serverTimestamp(),
        });

        setState(() {
          isUploading = false;
          statusMessage = "✅ Upload successful!";
        });
      } catch (e) {
        setState(() {
          isUploading = false;
          statusMessage = "❌ Upload failed: \$e";
        });
      }
    } else {
      setState(() {
        statusMessage = "No file selected.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Short")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: isUploading ? null : uploadVideo,
                icon: const Icon(Icons.upload),
                label: const Text("Upload Video"),
              ),
              const SizedBox(height: 20),
              if (statusMessage != null)
                Text(statusMessage!,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
