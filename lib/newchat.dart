import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class NewChat extends StatefulWidget {
  const NewChat({super.key});

  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  final TextEditingController _nameController = TextEditingController();
  String? _imageBase64;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      File imageFile = File(result.files.single.path!);
      List<int> imageBytes = await imageFile.readAsBytes();
      setState(() {
        _imageBase64 = base64Encode(imageBytes);
      });
    }
  }
Future<void> _saveToJson() async {
  String name = _nameController.text;
  if (name.isEmpty || _imageBase64 == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter a name and select an image.")),
    );
    return;
  }

  // Create JSON object for new data
  Map<String, dynamic> newChatData = {
    'name': name,
    'pfp': _imageBase64, // Change this from 'image' to 'pfp'
  };

  // Get the directory to save the file
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String filePath = '${appDocDir.path}/chat.json';
  File file = File(filePath);

  // Initialize the list to hold the data
  List<dynamic> chatList = [];

  // Check if the file exists
  if (await file.exists()) {
    // Read existing data
    String jsonString = await file.readAsString();
    dynamic jsonData = jsonDecode(jsonString);

    // Check if jsonData is a Map or List
    if (jsonData is List) {
      chatList = jsonData;
    } else if (jsonData is Map) {
      // If the existing JSON is a single object, convert it into a list
      chatList.add(jsonData);
    }
  }

  // Add new data to the list
  chatList.add(newChatData);

  // Convert the list back to JSON string
  String updatedJsonString = jsonEncode(chatList);

  // Write updated JSON to file
  await file.writeAsString(updatedJsonString);
  setState(() {});

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Data saved to chat.json")),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 26, 1),
      appBar: AppBar(
        title: const Text(
          "Add a New Chat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(38, 38, 44, 1),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name:",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter your chat recipient's name",
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color.fromRGBO(38, 38, 44, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Picture'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(38, 38, 44, 1),
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveToJson,
              child: const Text("Save to JSON"),
            ),
          ],
        ),
      ),
    );
  }
}
