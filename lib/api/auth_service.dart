import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:data_collection/util/appException.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<String> sendEnumerationData(
    String title,
    String firstname,
    String middlename,
    String lastname,
    String gender,
    String email,
    String phoneNumber,
    String occupation,
    String propertyID,
    String houseNumber,
    String street,
    String area,
    String propertyName,
    String propertyType,
    String areaSize,
    String buildingType,
    String buildingPurpose,
    String category,
    String areaClass,
    String lga,
    String zone,
    String agentId,
    String macAddress,
    String latitude,
    String landmark,
    String longitude,
    var image,
  ) async {
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            'https://www.ggcom.com.ng/luc/api/enumeration_api.php',
          ));
      request.fields['title'] = title.toString();
      request.fields["first_name"] = firstname.toString();
      request.fields["middle_name"] = middlename.toString();
      request.fields["last_name"] = lastname.toString();
      request.fields["gender"] = gender.toString();
      request.fields["email"] = email.toString();
      request.fields["phone_number"] = phoneNumber.toString();
      request.fields["occupation"] = occupation.toString();
      request.fields["property_id"] = propertyID.toString();
      request.fields["house_number"] = houseNumber.toString();
      request.fields["street"] = street.toString();
      request.fields["area"] = area.toString();
      request.fields["landmark"] = landmark.toString();
      request.fields["property_name"] = propertyName.toString();
      request.fields["area_size"] = areaSize.toString();
      request.fields["building_type"] = buildingType.toString();
      request.fields["building_purpose"] = buildingPurpose.toString();
      request.fields["category"] = category.toString();
      request.fields["area_class"] = areaClass.toString();
      request.fields["lga"] = lga.toString();
      request.fields["zone"] = zone.toString();
      request.fields["agent_id"] = agentId.toString();
      request.fields["mac_address"] = macAddress.toString();
      request.fields["latitude"] = latitude.toString();
      request.fields["longitude"] = longitude.toString();
      request.files.add(await http.MultipartFile.fromPath('image', image));

      var res = await request.send();
      final response = await http.Response.fromStream(res);
      print(response.body);
      //var res = response.body;
      print("response: $res");
      return returnResponse(response);
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
      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw TimeException();
    }
  }

  dynamic returnResponse(http.Response response) {
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
