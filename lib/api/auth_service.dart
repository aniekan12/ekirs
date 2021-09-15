import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:data_collection/util/appException.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<String> sendEnumerationData(
    String title,
    String middlename,
    String gender,
    String phoneNumber,
    String propertyID,
    String street,
    String landmark,
    String propertyType,
    String buildingType,
    String category,
    String lga,
    String zone,
    String macAddress,
    String latitude,
    String firstname,
    String lastname,
    String email,
    String occupation,
    String houseNumber,
    String area,
    String propertyName,
    String areaSize,
    String buildingPurpose,
    String areaClass,
    String agentId,
    String longitude,
    String image,
  ) async {
    try {
      //String fileName = image.path.split('/').last;
      Map data = {
        'title': title.toString(),
        "first_name": firstname.toString(),
        "middle_name": middlename.toString(),
        "last_name": lastname.toString(),
        "gender": gender.toString(),
        "email": email.toString(),
        "phone_number": phoneNumber.toString(),
        "occupation": occupation.toString(),
        "property_id": propertyID.toString(),
        "house_number": houseNumber.toString(),
        "street": street.toString(),
        "area": area.toString(),
        "landmark": landmark.toString(),
        "property_name": propertyName.toString(),
        "property_type": propertyType.toString(),
        "area_size": areaSize.toString(),
        "building_type": buildingType.toString(),
        "building_purpose": buildingPurpose.toString(),
        "category": category.toString(),
        "area_class": areaClass.toString(),
        "lga": lga.toString(),
        "zone": zone.toString(),
        "agent_id": agentId.toString(),
        "mac_address": macAddress.toString(),
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        'image': image.toString(),
      };
      var response = await http
          .post(
              Uri.parse('https://www.ggcom.com.ng/luc/api/enumeration_api.php'),
              body: data)
          .timeout(Duration(seconds: 60));

      var res = response.body;
      print("response: $res");
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on TimeoutException {
      throw TimeException();
    }
  }

  Future<String> login(String email, String password) async {
    try {
      Map data = {
        "email": email.toString(),
        "password": password.toString(),
      };
      var response = await http
          .post(Uri.parse('http://ggcom.com.ng/luc/api/user_login_api.php'),
              body: data)
          .timeout(Duration(seconds: 60));
      var res = response.body;
      print('ddasd; $res');
      //return response?.body;
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw TimeException();
    }
  }

  dynamic _returnResponse(http.Response response) {
    //var result;
    var res = json.decode(json.encode(response.body.toString()));
    switch (response.statusCode) {
      case 200:
        // If the server did return a 200 CREATED response,
        // then parse the JSON.
        String jsonsDataString = response.body;
        res = jsonDecode(json.encode(jsonsDataString));
        print('api.dart:  $res');
        return res;
      case 400:
        throw BadRequestException(response.body.toString());

      case 401:
      case 403:
        throw UnauthorisedException(res['err']);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.reasonPhrase}');
    }
  }

//   /// Get User data
//   Future<dynamic> getPatients(token) async {
//     try {
//       var response = await http.get(
//           Uri.parse(
//               'https://harvest-rigorous-bambiraptor.glitch.me/api/v1/patient/get-patient/single'),
//           headers: {
//             'Authorization': 'Bearer $token',
//           }).timeout(Duration(seconds: 60));
//       var res = response.body;
//       print('api: $res');
//       return _returnResponse(response);
//     } on SocketException {
//       throw FetchDataException('No Internet connection');
//     } on TimeoutException {
//       throw TimeException();
//     }
//   }
// }
}
