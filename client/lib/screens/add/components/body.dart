import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ImagePicker picker = ImagePicker();
  String path = '';
  late var bytes;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                try {
                  final chooseFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  bytes = await chooseFile!.readAsBytes();

                  setState(() {
                    path = chooseFile.path;
                  });
                } catch (_) {}
              },
              child: const Text(
                'Choose publication',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (path != '') Image.network(path),
          if (path != '')
            const SizedBox(
              height: 20,
            ),
          if (path != '')
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              controller: descriptionController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 3),
                ),
              ),
            ),
          if (path != '')
            const SizedBox(
              height: 20,
            ),
          if (path != '')
            FittedBox(
              child: TextButton(
                onPressed: () async {
                  showDialog<String>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return showDialogLoading();
                      });

                  SharedPreferences sharedPrefs =
                      await SharedPreferences.getInstance();

                  Map data = {
                    'image': bytes,
                    'token': sharedPrefs.getString('token'),
                    'description': descriptionController.text
                  };
                  var body = json.encode(data);

                  var response = await http.post(
                    Uri.parse('http://localhost:5000/upload/publication'),
                    body: body,
                    headers: {
                      'Content-Type': 'application/json',
                    },
                  );
                  Navigator.pop(context);

                  if (response.statusCode == 201) {
                    setState(() {
                      path = '';
                    });

                    Fluttertoast.showToast(
                        msg: 'Publication uploaded successfully',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM_LEFT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: const Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          const Spacer()
        ],
      ),
    );
  }

  Widget showDialogLoading() {
    return const AlertDialog(
      title: Text("Uploading..."),
      content: SizedBox(
        width: 60,
        height: 60,
        child: SpinKitRing(
          color: Colors.blueAccent,
          size: 50.0,
        ),
      ),
    );
  }
}

// class Add extends StatelessWidget {
//   get http => null;

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () async {
//         FilePickerResult? result = await FilePicker.platform.pickFiles(
//           type: FileType.custom,
//           allowedExtensions: ['jpg', 'png', 'jpeg'],
//         );

//         if (result != null) {
//           Uint8List? fileBytes = result.files.first.bytes;

//           SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

//           Map data = {
//             'image': fileBytes,
//             'token': sharedPrefs.getString('token')
//           };
//           //encode Map to JSON
//           var body = json.encode(data);

//           var response = await http.post(
//             Uri.parse('http://localhost:5000/upload/publication'),
//             body: body,
//             headers: {
//               'Content-Type': 'application/json',
//             },
//           );
//         }
//       },
//       child: const Text(
//         'Upload photo',
//         style: TextStyle(color: Colors.white),
//       ),
//     );
    
//   }
//   class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }


// class _HomePageState extends State<HomePage> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? image;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Stack(
//         children: [

//       //SizedBox(
//       image == null ? Text("No Image Selected") : Image.file(File(image!.path), height: 800,), //width: 400, height: 800,
//     //),
//           Positioned(

//             right: MediaQuery.of(context).size.width/2.3,
//             bottom: MediaQuery.of(context).size.width/10,
//             child: FloatingActionButton(
//               backgroundColor: Colors.blue,
//               onPressed: () {
//                 filePicker();
//               } ,
//               child: Icon(Icons.camera_alt,),
//             ),
//           ),
//           Positioned(
//             width: 36,
//             height:36,
//             top: 10,
//             left: 8,
//             child: FloatingActionButton(
//               backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
//               onPressed: (){},
//               child: Icon(Icons.arrow_back_rounded),
//             ),

//           ),


//         ],
//       ));
//   }

//   void filePicker() async {
//     final XFile? selectedImage = await _picker.pickImage(source: ImageSource.camera);
//     print(selectedImage!.path);
//     setState(() {
//       image = selectedImage;
//     });
//   }
// }
