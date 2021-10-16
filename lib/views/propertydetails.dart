import 'dart:io';
import 'dart:async';
import 'package:data_collection/api/ip_info_api.dart';
import 'package:data_collection/local_db/db_helper.dart';
import 'package:data_collection/local_db/syncronize.dart';
import 'package:data_collection/models/enumeration_model.dart';
import 'package:data_collection/views/dashboard.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:data_collection/api/auth_service.dart';
import 'package:data_collection/util/colors.dart';
import 'package:data_collection/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({Key key}) : super(key: key);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  /// This is your where you get your values
  String propertyTypeValue;
  String buildingTypeValue;
  String propertyZoneValue;
  String buildingPurposeValue;
  String lgaValue;
  String categoryValue;
  String lgaCode = "";

  // // Image variable

  File _image;
  File savedImg;
  final picker = ImagePicker();

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
        savedImg = await _image.copy('${directory.path}/filename.jpg');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String dropdownValue = 'One';

  /// All these are sample u will create your own
  var propertyType = [
    {"id": 1, "name": "Residential Building"},
    {"id": 2, "name": "Hotel"},
    {"id": 3, "name": "School"},
    {"id": 4, "name": "Petrol Station"},
    {"id": 5, "name": "Telecom Base Station"},
    {"id": 6, "name": "Power substation"},
    {"id": 7, "name": "Banks"},
    {"id": 8, "name": "Microfinance bank"},
    {"id": 9, "name": "Finance house"},
    {"id": 10, "name": "Insurance Companies"},
    {"id": 11, "name": "Industrial Properties"},
    {"id": 12, "name": "Hospitals"},
    {"id": 13, "name": "Office Complex/Business Premises"}
  ];

  var category = [
    {"id": 1, "name": "A"},
  ];

  static const categorymasters = [
    {"id": 1, "name": "A", "ParentId": 1},
    {"id": 2, "name": "", "ParentId": 2},
    {"id": 3, "name": "", "ParentId": 3},
    {"id": 4, "name": "", "ParentId": 4},
    {"id": 5, "name": "", "ParentId": 5},
    {"id": 6, "name": "", "ParentId": 6},
    {"id": 7, "name": "", "ParentId": 7},
    {"id": 8, "name": "", "ParentId": 8},
    {"id": 9, "name": "", "ParentId": 9},
    {"id": 10, "name": "", "ParentId": 10},
    {"id": 11, "name": "", "ParentId": 11},
    {"id": 12, "name": "", "ParentId": 12},
    {"id": 13, "name": "", "ParentId": 13},
    {"id": 14, "name": "", "ParentId": 14},
    {"id": 15, "name": "", "ParentId": 15},
    {"id": 16, "name": "", "ParentId": 16},
  ];

  var lga = [
    {"id": 1, "name": "Ado Ekiti"},
    {"id": 2, "name": "Ikere Ekiti"},
    {"id": 3, "name": "Ekiti East"},
    {"id": 4, "name": "Ekiti South West"},
    {"id": 5, "name": "Ekiti West"},
    {"id": 6, "name": "Ido/Osi"},
    {"id": 7, "name": "Irepodun/Ifelodun"},
    {"id": 8, "name": "Oye"},
    {"id": 9, "name": "Ikole"},
    {"id": 10, "name": "Ijero"},
    {"id": 11, "name": "Moba"},
    {"id": 12, "name": "Ise/Orun"},
    {"id": 13, "name": "Ilejemeje"},
    {"id": 14, "name": "Gboyin"},
    {"id": 15, "name": "Emure"},
    {"id": 16, "name": "Efon"},
  ];

  static const buildingPurposemasters = [
    {"id": 1, "name": "Fully Business", "ParentId": 1},
    {"id": 2, "name": "Mixed", "ParentId": 1},
    {"id": 3, "name": "Owner Occupier", "ParentId": 1},
    {"id": 4, "name": "Business", "ParentId": 2},
    {"id": 5, "name": "Private Secondary School (A)", "ParentId": 3},
    {"id": 6, "name": "Private Secondary School (B)", "ParentId": 3},
    {"id": 7, "name": "Private Primary School (A)", "ParentId": 3},
    {"id": 8, "name": "Private Primary School (B)", "ParentId": 3},
    {"id": 9, "name": "Business", "ParentId": 4},
    {"id": 10, "name": "Business", "ParentId": 5},
    {"id": 11, "name": "Business", "ParentId": 6},
    {"id": 12, "name": "Business", "ParentId": 7},
    {"id": 13, "name": "Business", "ParentId": 8},
    {"id": 14, "name": "Business", "ParentId": 9},
    {"id": 15, "name": "Business", "ParentId": 10},
    {"id": 16, "name": "Business", "ParentId": 11},
    {"id": 17, "name": "Business", "ParentId": 12},
    {"id": 18, "name": "Business", "ParentId": 13},
    // {"id": 3, "name": "Business", "ParentId": 13},
  ];

  static const buildingTypemasters = [
    {"id": 1, "name": "Bungalow", "ParentId": 1},
    {"id": 2, "name": "Duplex", "ParentId": 1},
    {"id": 3, "name": "Face me i face you", "ParentId": 1},
  ];

  static const propertyZonemasters = [
    {"id": 1, "name": "HVZ", "ParentId": 1},
    {"id": 2, "name": "MVZ", "ParentId": 1},
    {"id": 3, "name": "LVZ", "ParentId": 1},
    {"id": 4, "name": "HVZ", "ParentId": 2},
    {"id": 5, "name": "EDU", "ParentId": 3},
    {"id": 6, "name": "ENC", "ParentId": 4},
    {"id": 7, "name": "ENC", "ParentId": 5},
    {"id": 8, "name": "ENC", "ParentId": 6},
    {"id": 9, "name": "ENC", "ParentId": 7},
    {"id": 10, "name": "ENC", "ParentId": 8},
    {"id": 11, "name": "ENC", "ParentId": 9},
    {"id": 12, "name": "ENC", "ParentId": 10},
    {"id": 13, "name": "ENC", "ParentId": 11},
    {"id": 14, "name": "ENC", "ParentId": 12},
    {"id": 15, "name": "ENC", "ParentId": 13},
  ];

  getBuildingPurpose(propertyType) {
    switch (propertyType) {
      case 'Residential Building':
        return buildingPurposemasters
            .where((element) => element['ParentId'] == 1);
      case 'Hotel':
      case 'Office Complex/Business Premises':
        return buildingPurposemasters
            .where((element) => element['ParentId'] == 2);
      case 'School':
        return buildingPurposemasters
            .where((element) => element['ParentId'] == 3);
      default:
        return buildingPurposemasters
            .where((element) => element['ParentId'] == 4);
    }
  }

  getLga(lgas) {
    switch (lgas) {
      case 'Ado Ekiti':
        return categorymasters.where((element) => element['ParentId'] == 1);
      case 'Ikere Ekiti':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Ekiti South West':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Ekiti West':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Ido/Osi':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Ikrepodun/Ifelodun':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Oye':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Ikole':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Ijero':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Moba':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Ise/Orun':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Ilemeje':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Gboyin':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Emure':
        return categorymasters.where((element) => element['ParentId'] == 2);
      case 'Efon':
        return categorymasters.where((element) => element['ParentId'] == 2);
      default:
        return categorymasters.where((element) => element['ParentId'] == 2);
    }
  }

  getPropertyZone(propertyType) {
    switch (propertyType) {
      case 'Residential Building':
        return propertyZonemasters.where((element) => element['ParentId'] == 1);
      case 'Hotel':
      case 'Office Complex/Business Premises':
        return propertyZonemasters.where((element) => element['ParentId'] == 2);
      case 'School':
        return propertyZonemasters.where((element) => element['ParentId'] == 3);
      default:
        return propertyZonemasters.where((element) => element['ParentId'] == 4);
    }
  }

  final formKey = new GlobalKey<FormState>();
  TextEditingController _userFirstNameController = TextEditingController();
  TextEditingController _userSurnameController = TextEditingController();
  TextEditingController _userTitleController = TextEditingController();
  TextEditingController _userMiddleNameController = TextEditingController();
  TextEditingController _userGenderController = TextEditingController();
  TextEditingController _userOccupationCOntroller = TextEditingController();
  TextEditingController _userPhoneController = TextEditingController();
  TextEditingController _userHouseNumberController = TextEditingController();
  TextEditingController _userLandmarkController = TextEditingController();
  TextEditingController _userAreaController = TextEditingController();
  TextEditingController _userPropertyNameController = TextEditingController();
  TextEditingController _userAreaSizeController = TextEditingController();
  TextEditingController _propertyIdController = TextEditingController();
  TextEditingController _userStreetController = TextEditingController();
  TextEditingController _userAreaClassController = TextEditingController();

  List list;
  bool loading = true;
  Future enumerationList() async {
    list = await SqfliteDatabaseHelper.instance.readAllNotes();
    setState(() {
      loading = false;
    });
    print(list);
  }

  Future syncToMysql() async {
    await SyncronizationData().fetchAllInfo().then((userList) async {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Don't close app. we are syncing!")));
      await SyncronizationData().saveToApIWith(userList);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Saved succesfully!")));
    });
  }

  Future init() async {
    final ipAddress = await IpInfoApi.getIPAddress();

    if (!mounted) return;

    setState(() => map = {
          'IP Address': ipAddress,
        });

    print(_textSelect(map.toString()));
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

  String _lat = "";
  String _long = "";

  String _email = '';

  String validateName(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a Valid Email';
    else
      return null;
  }

  //for formatting ip address
  String _textSelect(String str) {
    str = str.replaceAll('{IP Address:', '');
    str = str.replaceAll('}', '');
    return str;
  }

  // Text field container height
  double _textFieldHeight = 48;

  // Thickness of Text fields
  double _textFieldBorderWidth = 1;

  //map Ip address
  Map<String, dynamic> map = {};

  // Text size
  double _textSize = 14;

  // Text field box shadow
  Color _textFieldShadow = Color.fromRGBO(0, 0, 0, 0.5);

  // variable to store if password is visible or not

  double heightValue = 120;

  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    isInteret();
    init();
    enumerationList();
    _loadCounter();
    getCurrentLocation();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('email') ?? '');
    });
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    setState(() {
      _lat = '${geoposition.latitude}';
      _long = '${geoposition.longitude}';
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
                                // _image = _image;
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
              key: formKey,
              child: _buildPropertyDetails(context),
            )
          ],
        ),
      ),
    );
  }

  _buildPropertyDetails(BuildContext context) {
    // String fileName = _image.path.split('/').last;
    //ensure correct data was entered
    // checkfields() {
    //   final form = formKey.currentState;
    //   if (form.validate()) {
    //     form.save();
    //     return true;
    //   }
    //   //set auto validate to true
    // }

    return GestureDetector(
      onTap: () {
        //this helps hide the keyboard when you click outside the textfield
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 24, 24.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Text(
                'Property Details',
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
              textHeaders('Title'),
              textSection('Mr./Mrs./Miss', _userTitleController, 'Title'),
              SizedBox(height: 25.0),
              textHeaders('First Name'),
              textSection('e.g Amaks', _userFirstNameController, 'First name'),
              SizedBox(height: 25.0),
              textHeaders('Middle Name'),
              textSection(
                  'e.g Amaks', _userMiddleNameController, 'Middle name'),
              SizedBox(height: 25.0),
              textHeaders('Last Name'),
              textSection('e.g Obi', _userSurnameController, 'Surname'),
              SizedBox(height: 25.0),
              textHeaders('Gender'),
              textSection(
                  'e.g male or female', _userGenderController, 'Gender'),
              SizedBox(height: 25.0),
              textHeaders('Occupation'),
              textSection('what work do you do?', _userOccupationCOntroller,
                  'Occupation'),
              SizedBox(height: 25.0),
              textHeaders('property Id'),
              textSection('e.g 2922a7', _propertyIdController, 'Email'),
              SizedBox(height: 25.0),
              textHeaders('Phone Number'),
              textSection(
                  'e.g 08023118289', _userPhoneController, 'Phone Number'),
              SizedBox(height: 25.0),
              textHeaders('House Number'),
              textSection('e.g 20', _userHouseNumberController, 'House Number'),
              SizedBox(height: 25.0),
              textHeaders('Landmark'),
              textSection('e.g Fajuyi', _userLandmarkController, 'Landmark'),
              SizedBox(height: 25.0),
              textHeaders('Street'),
              textSection('e.g ILaro-Gun', _userStreetController, 'Street'),
              SizedBox(height: 25.0),
              textHeaders('L.G.A'),
              Container(
                decoration: BoxDecoration(
                  color: buttonColorTwo,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    key: UniqueKey(),
                    hint: const Text('Select L.G.A'),
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    iconSize: 42,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: buttonColorTwo,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        lgaValue = newValue;
                        categoryValue = null;
                      });
                    },
                    items: lga.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value['name'].toString(),
                        child: Text(value['name'].toString()),
                      );
                    }).toList(),
                    value: lgaValue,
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              textHeaders('Category'),
              Container(
                decoration: BoxDecoration(
                  color: buttonColorTwo,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    key: UniqueKey(),
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    iconSize: 42,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: buttonColorTwo,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        categoryValue = newValue;
                      });
                      print(categoryValue);
                    },
                    items: getLga(lgaValue).map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem<String>(
                        value: e['name'].toString(),
                        child: Text(e['name'].toString()),
                      );
                    }).toList(),
                    value: categoryValue,
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              textHeaders('Area'),
              textSection('e.g Captain Cook', _userAreaController, 'Area'),
              SizedBox(height: 25.0),
              textHeaders('Property Name'),
              textSection(
                  'e.g Tosin House', _userPropertyNameController, 'property'),
              SizedBox(height: 25.0),
              textHeaders('Area Size'),
              textSection('e.g 30sqm', _userAreaSizeController, 'Area size'),
              SizedBox(height: 25.0),
              textHeaders('Area Class'),
              textSection('e.g G.R.A', _userAreaClassController, 'Area class'),
              SizedBox(height: 25.0),
              textHeaders('Property Info'),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: buttonColorTwo,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        key: UniqueKey(),
                        hint: const Text('Select Property Type'),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: buttonColorTwo,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            propertyTypeValue = newValue;
                            buildingTypeValue = null;
                            propertyZoneValue = null;
                            buildingPurposeValue = null;
                          });
                        },
                        items:
                            propertyType.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value['name'].toString(),
                            child: Text(value['name'].toString()),
                          );
                        }).toList(),
                        value: propertyTypeValue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: buttonColorTwo,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: DropdownButton<String>(
                          isExpanded: true,
                          key: UniqueKey(),
                          hint: const Text('Building Type'),
                          value: buildingTypeValue,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.white),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: buttonColorTwo,
                          ),
                          onChanged: propertyTypeValue == 'Residential Building'

                              /// If banks is selected in the first dropdown this one will be disabled
                              ? (String newValue) {
                                  setState(() {
                                    buildingTypeValue = newValue;
                                  });
                                }
                              : null,
                          items: buildingTypemasters
                              .map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem<String>(
                                value: e['name'].toString(),
                                child: Text(e['name'].toString()));
                          }).toList()),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: buttonColorTwo,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: buildingPurposeValue,
                        hint: const Text('Building Purpose'),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: buttonColorTwo,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            buildingPurposeValue = newValue;
                          });
                        },
                        items: getBuildingPurpose(propertyTypeValue)
                            .map<DropdownMenuItem<String>>((e) {
                          return DropdownMenuItem<String>(
                            value: e['name'].toString(),
                            child: Text(e['name'].toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: buttonColorTwo,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: propertyZoneValue,
                        hint: const Text('Property Zone'),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: buttonColorTwo,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            propertyZoneValue = newValue;
                          });
                          print(propertyZoneValue);
                        },
                        items: getPropertyZone(propertyTypeValue)
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value['name'].toString(),
                            child: Text(value['name'].toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              _buildCameraOrFileChooser(context),
              SizedBox(height: 0),
              // _buildSecondCameraOrFileChooser(context),
              GestureDetector(
                  onTap: () async {
                    EnumerationModel enumerationModel = EnumerationModel(
                        title: _userTitleController.text,
                        firstname: _userFirstNameController.text,
                        middlename: _userMiddleNameController.text,
                        lastname: _userSurnameController.text,
                        gender: _userGenderController.text,
                        email: _email,
                        phone_number: _userPhoneController.text,
                        occupation: _userOccupationCOntroller.text,
                        property_id: _propertyIdController.text,
                        house_number: _userHouseNumberController.text,
                        street: _userStreetController.text,
                        area: _userAreaController.text,
                        landmark: _userLandmarkController.text,
                        property_name: _userPropertyNameController.text,
                        property_type: propertyTypeValue,
                        area_size: _userAreaSizeController.text,
                        building_type: buildingTypeValue,
                        agent_id: _email,
                        building_purpose: buildingPurposeValue,
                        category: categoryValue,
                        area_class: _userAreaClassController.text,
                        lga: lgaValue,
                        zone: propertyZoneValue,
                        latitude: _lat,
                        longitude: _long,
                        mac_address: _textSelect(map.toString()),
                        image: savedImg.path);
                    print(enumerationModel.mac_address);
                    await SqfliteDatabaseHelper.instance
                        .addData(enumerationModel)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Saved succesfully!")));
                      print(value);
                      enumerationList();

                      print("success");
                      //enumerationList();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text("Save not succesful!")));
                      //   print("failed");
                      // }
                    });
                  },
                  child: signButton(
                      _textFieldHeight, _textFieldShadow, _textSize, 'SEND')),
            ],
          ),
        ),
      ),
    );
  }

  // Container for patient's full name
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
