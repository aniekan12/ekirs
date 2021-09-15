import 'dart:io';

import 'package:data_collection/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DemandNotice extends StatefulWidget {
  const DemandNotice({Key key}) : super(key: key);

  @override
  _DemandNoticeState createState() => _DemandNoticeState();
}

class _DemandNoticeState extends State<DemandNotice> {
  final formKey = new GlobalKey<FormState>();
  // // Image variable
  File _image;
  final picker = ImagePicker();

  // variable to check if file was uploaded
  bool _isFileUploaded = false;

  // Method to get image from user
  Future getImage() async {
    final pickedFile = dropdownValue == 'Camera'
        // ignore: deprecated_member_use
        ? await picker.getImage(source: ImageSource.camera)
        : await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isFileUploaded = true;
      } else {
        print('No image selected.');
      }
    });
  }

  String dropdownValue = 'One';

  // Text field container height
  double _textFieldHeight = 48;

  // Thickness of Text fields
  double _textFieldBorderWidth = 1;

  // Text size
  double _textSize = 14;

  // Text field box shadow
  Color _textFieldShadow = Color.fromRGBO(0, 0, 0, 0.5);

  // variable to store if password is visible or not
  bool _obscureText = true;
  double heightValue = 120;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Form(
              child: _buildCameraOrFileChooser(context),
              key: formKey,
            ),
          ],
        ),
      ),
    );
  }

  _buildCameraOrFileChooser(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Text(
                'Upload a Photo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(
                height: 20,
                endIndent: 140,
                thickness: 5,
                color: buttonColorOne,
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add an Image',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: _isFileUploaded
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                topRight: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                                bottomRight: Radius.circular(4),
                                              ),
                                              color: Color.fromRGBO(
                                                  206, 205, 205, 1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Change Photo',
                                                //textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        23, 43, 77, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    letterSpacing:
                                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1)),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                topRight: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                                bottomRight: Radius.circular(4),
                                              ),
                                              color: Color.fromRGBO(
                                                  206, 205, 205, 1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Choose a photo',
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      23, 43, 77, 1),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1),
                                            ),
                                          ),
                                        ),
                                  iconSize: 0,
                                  isExpanded: true,
                                  elevation: 16,
                                  focusColor: buttonColorOne,
                                  style: TextStyle(color: buttonColorTwo),
                                  /*underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                            ),*/
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                    getImage();
                                  },
                                  items: <String>[
                                    'Camera',
                                    'Upload Picture',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Visibility(
                          visible: _isFileUploaded ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _image = null;
                                _isFileUploaded = false;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Delete',
                                  //textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  _isFileUploaded
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            backgroundImage: FileImage(_image),
                            backgroundColor: Colors.transparent,
                            radius: 64,
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        )
                ],
              ),
              SizedBox(height: _isFileUploaded ? 30.0 : 48.0),
            ],
          )),
    );
  }
}
