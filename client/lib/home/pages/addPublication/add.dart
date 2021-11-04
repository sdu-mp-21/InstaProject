import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import './file.dart';
import 'package:storage_path/storage_path.dart';


// class Add extends StatelessWidget {
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
// }

class Add extends StatefulWidget {
  Add( this.title);

  final String title;

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
   late List<FileModel> files;
   late FileModel selectedModel;
   late String image;
  @override
  void initState() {
    super.initState();
    getImagesPath();
  }

  getImagesPath() async {
    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (files != null && files.length > 0)
      setState(() {
        selectedModel = files[0];
        image = files[0].files[0];
      });
  }

  List<DropdownMenuItem> getItem() {
    return files
            .map((e) => DropdownMenuItem(
                  child: Text(
                    e.folder,
                    style: TextStyle(color: Colors.black),
                  ),
                  value: e,
                ))
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.clear),
                    SizedBox(width: 10),
                    DropdownButtonHideUnderline(
                        child: DropdownButton<FileModel>(
                      items: getItem(),
                      onChanged: (FileModel d) {
                        assert(d.files.length > 0);
                        image = d.files[0];
                        setState(() {
                          selectedModel = d;
                        });
                      },
                      value: selectedModel,
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
            Divider(),
            Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: image != null
                    ? Image.file(File(image),
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width)
                    : Container()),
            Divider(),
            selectedModel == null && selectedModel.files.length < 1
                ? Container()
                : Container(
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4),
                        itemBuilder: (_, i) {
                          var file = selectedModel.files[i];
                          return GestureDetector(
                            child: Image.file(
                              File(file),
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              setState(() {
                                image = file;
                              });
                            },
                          );
                        },
                        itemCount: selectedModel.files.length),
                  )
          ],
        ),
      ),
    );
  }

  
}
