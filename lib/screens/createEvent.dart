// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateEventScreen extends StatefulWidget {
//   @override
//   _CreateEventScreenState createState() => _CreateEventScreenState();
// }

// class _CreateEventScreenState extends State<CreateEventScreen> {
//   final _titleController = TextEditingController();
//   final _locationController = TextEditingController();
//   final _timeController = TextEditingController();
//   final _detailsController = TextEditingController();
//   XFile? _image;

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = pickedImage;
//     });
//   }

//   Future<void> _submitEvent() async {
//     if (_image == null) return;

//     final imageRef = FirebaseStorage.instance
//         .ref()
//         .child('event_images')
//         .child(DateTime.now().toString() + '.jpg');
//     await imageRef.putFile(File(_image!.path));
//     final imageUrl = await imageRef.getDownloadURL();

//     await FirebaseFirestore.instance.collection('events').add({
//       'title': _titleController.text,
//       'location': _locationController.text,
//       'time': _timeController.text,
//       'details': _detailsController.text,
//       'imageUrl': imageUrl,
//       'interestedCount': 0,
//       'interestedUsers': [],
//     });

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Create Event')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                   controller: _titleController,
//                   decoration: InputDecoration(labelText: 'Title')),
//               TextField(
//                   controller: _locationController,
//                   decoration: InputDecoration(labelText: 'Location')),
//               TextField(
//                   controller: _timeController,
//                   decoration: InputDecoration(labelText: 'Time')),
//               TextField(
//                   controller: _detailsController,
//                   decoration: InputDecoration(labelText: 'Details')),
//               SizedBox(height: 10),
//               _image == null
//                   ? Text('No image selected.')
//                   : Image.file(File(_image!.path)),
//               ElevatedButton(onPressed: _pickImage, child: Text('Pick Image')),
//               ElevatedButton(
//                   onPressed: _submitEvent, child: Text('Submit Event')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _timeController = TextEditingController();
  final _detailsController = TextEditingController();
  XFile? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> _submitEvent() async {
    if (_image == null) return;

    final imageRef = FirebaseStorage.instance
        .ref()
        .child('event_images')
        .child(DateTime.now().toString() + '.jpg');
    await imageRef.putFile(File(_image!.path));
    final imageUrl = await imageRef.getDownloadURL();

    await FirebaseFirestore.instance.collection('events').add({
      'title': _titleController.text,
      'location': _locationController.text,
      'time': _timeController.text,
      'details': _detailsController.text,
      'imageUrl': imageUrl,
      'interestedCount': 0,
      'interestedUsers': [],
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create an event',
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 25.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 221, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_titleController, 'Title'),
              _buildTextField(_locationController, 'Location'),
              _buildTextField(_timeController, 'Time'),
              _buildTextField(_detailsController, 'Details'),
              SizedBox(height: 16),
              _image == null
                  ? Text('No image selected',
                      style: TextStyle(color: Colors.grey))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(File(_image!.path),
                          height: 150, fit: BoxFit.cover),
                    ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text(
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    'Pick Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  // padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitEvent,
                child: Text(
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    'Submit Event'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  // padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}
