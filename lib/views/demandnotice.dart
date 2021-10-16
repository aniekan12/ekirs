import 'dart:io';

import 'package:data_collection/local_db/db_helper.dart';
import 'package:data_collection/local_db/syncronize.dart';
import 'package:data_collection/models/demand_model.dart';
import 'package:data_collection/models/enumeration_model.dart';
import 'package:data_collection/util/colors.dart';
import 'package:data_collection/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'dashboard.dart';

class DemandNotice extends StatefulWidget {
  const DemandNotice({Key key}) : super(key: key);

  @override
  _DemandNoticeState createState() => _DemandNoticeState();
}

class _DemandNoticeState extends State<DemandNotice> {
  @override
  void initState() {
    super.initState();
    demandNoticeList();
    isInteret();
  }

  final formKey = new GlobalKey<FormState>();
  // // Image variable
  File _image;
  final picker = ImagePicker();
  File savedImg;
  File pickedImg;
  ImagePicker selectImg = ImagePicker();

  // Text size
  double _textSize = 14;

  // Text field container height
  double _textFieldHeight = 48;

  // Text field box shadow
  Color _textFieldShadow = Color.fromRGBO(0, 0, 0, 0.5);

  TextEditingController _propertyIdController = TextEditingController();

  // variable to check if file was uploaded
  bool _isFileUploaded = false;

  // Method to get image from user
  Future getImage() async {
    final pickedFile = dropdownValue == 'Camera'
        // ignore: deprecated_member_use
        ? await picker.getImage(source: ImageSource.camera)
        // ignore: deprecated_member_use
        : await picker.getImage(source: ImageSource.gallery);
    // if (pickedFile == null) return null;

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isFileUploaded = true;
      } else {
        print('No image selected.');
      }
    });
    try {
      final directory = await getApplicationDocumentsDirectory();
      if (directory != null) {
        for (int count = 1; count >= 1000000000000000000; count++) {
          savedImg = await _image.copy('${directory.path}/filename$count.jpg');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String dropdownValue = 'One';

  // Thickness of Text fields
  double _textFieldBorderWidth = 1;

  double heightValue = 120;
  String imgString;

  List list;
  bool loading = true;
  Future demandNoticeList() async {
    list = await SqfliteDatabaseHelper.instance.readAllDemands();
    setState(() {
      loading = false;
    });
    print(list);
  }

  Future isInteret() async {
    await SyncronizationData.isInternet().then((connection) {
      if (connection) {
        print("Internet connection availale");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: buttonColorTwo,
            content: Text("Internet connection available"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("No Internet available")));
      }
    });
  }

  Future syncToMysql() async {
    await SyncronizationData().fetchAllDemands().then((userList) async {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Don't close app. we are syncing!")));
      print(userList.length);
      await SyncronizationData().saveToApIDemandWith(userList);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Saved succesfully!")));
    });
  }

  _buildCameraOrFileChooser(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0.0, 24.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                  elevation: 16,
                                  focusColor: buttonColorOne,
                                  style: TextStyle(color: buttonColorTwo),
                                  /*underline: Container(
                            height: 2,
                            color: Colors.blackAccent,
                            ),*/
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                    getImage();
                                  },
                                  items: <String>['Camera', 'Upload Picture']
                                      .map<DropdownMenuItem<String>>(
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
                                // selectImg = _image;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColorOne,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh_sharp),
              onPressed: () async {
                await SyncronizationData.isInternet().then((connection) {
                  if (connection) {
                    syncToMysql();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: buttonColorTwo,
                        content:
                            Text("Internet connection available, Syncing!")));
                    print("Internet connection availale");
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("No Internet")));
                  }
                });
              })
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Form(
              child: _buildDemandNotice(context),
              key: formKey,
            ),
          ],
        ),
      ),
    );
  }

  _buildDemandNotice(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.fromLTRB(24.0, 24, 24.0, 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.0),
          Text(
            'Demand Notice',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Divider(
            height: 20,
            endIndent: 140,
            thickness: 5,
            color: buttonColorOne,
          ),
          SizedBox(height: 40.0),
          textHeaders('Property Id'),
          textSection('', _propertyIdController, 'Property Id'),
          SizedBox(height: 20.0),

          //Image.file(pickedImg),
          _buildCameraOrFileChooser(context),
          GestureDetector(
              onTap: () async {
                DemandNoticeModel demandNoticeModel = DemandNoticeModel(
                  propertyId: _propertyIdController.text.toString(),
                  image: _image.path,
                );
                print(demandNoticeModel.image);
                await SqfliteDatabaseHelper.instance
                    .addDemand(demandNoticeModel)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Saved succesfully!")));
                  print(value);
                  demandNoticeList();

                  print("success");
                  // enumerationList();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Save not succesful!")));
                  print("failed");
                });
              },
              child: signButton(
                  _textFieldHeight, _textFieldShadow, _textSize, 'SEND')),
        ],
      ),
    ));
  }

// Component for header of respective fields
  Padding textHeaders(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500)),
    );
  }

  Container textSection(
      String hintText, TextEditingController controller, String title) {
    return Container(
        decoration: boxDecoration(),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: buttonColorOne),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: buildDecorations(buttonColorOne,
                  _textFieldBorderWidth, _textSize, hintText, false),
              validator: (value) =>
                  value.isNotEmpty && value.contains(new RegExp(r'^[a-zA-Z]+$'))
                      ? null
                      : '$title is required',
              /*value.isEmpty ? 'Name is required' : value.contains(
                  new RegExp(r'^[a-zA-Z\-\s]+$')) ? null : "Enter a valid name",*/
              textAlign: TextAlign.start,
              maxLines: 1,
              maxLength: 20,
              // controller: _locationNameTextController,
            ),
          ),
        ));
  }
}
