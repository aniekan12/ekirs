import 'package:connectivity/connectivity.dart';
import 'package:data_collection/models/demand_model.dart';
import 'package:data_collection/models/enumeration_model.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'db_helper.dart';

class SyncronizationData {
  static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
        print("Mobile data detected & internet connection confirmed.");
        return true;
      } else {
        print('No internet :( Reason:');
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await DataConnectionChecker().hasConnection) {
        print("wifi data detected & internet connection confirmed.");
        return true;
      } else {
        print('No internet :( Reason:');
        return false;
      }
    } else {
      print(
          "Neither mobile data or WIFI detected, no internet connection found.");
      return false;
    }
  }

  Future saveToApIWith(List<EnumerationModel> enumerationList) async {
    for (var i = 0; i < enumerationList.length; i++) {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            'https://www.ggcom.com.ng/luc/api/enumeration_api.php',
          ));
      request.fields['id'] = enumerationList[i].id.toString();
      request.fields['title'] = enumerationList[i].title.toString();
      request.fields["first_name"] = enumerationList[i].firstname.toString();
      request.fields["middle_name"] = enumerationList[i].middlename.toString();
      request.fields["last_name"] = enumerationList[i].lastname.toString();
      request.fields["gender"] = enumerationList[i].gender.toString();
      request.fields["email"] = enumerationList[i].email.toString();
      request.fields["phone_number"] =
          enumerationList[i].phone_number.toString();
      request.fields["occupation"] = enumerationList[i].occupation.toString();
      request.fields["property_id"] = enumerationList[i].property_id.toString();
      request.fields["house_number"] =
          enumerationList[i].house_number.toString();
      request.fields["street"] = enumerationList[i].street.toString();
      request.fields["area"] = enumerationList[i].area.toString();
      request.fields["landmark"] = enumerationList[i].landmark.toString();
      request.fields["property_name"] =
          enumerationList[i].property_name.toString();
      request.fields["area_size"] = enumerationList[i].area_size.toString();
      request.fields["building_type"] =
          enumerationList[i].building_type.toString();
      request.fields["building_purpose"] =
          enumerationList[i].building_purpose.toString();
      request.fields["category"] = enumerationList[i].category.toString();
      request.fields["area_class"] = enumerationList[i].area_class.toString();
      request.fields["lga"] = enumerationList[i].lga.toString();
      request.fields["zone"] = enumerationList[i].zone.toString();
      request.fields["agent_id"] = enumerationList[i].email.toString();
      request.fields["mac_address"] = enumerationList[i].mac_address.toString();
      request.fields["latitude"] = enumerationList[i].latitude.toString();
      request.fields["longitude"] = enumerationList[i].longitude.toString();
      request.files.add(await http.MultipartFile.fromPath(
          'image', enumerationList[i].image.toString()));

      var res = await request.send();
      final response = await http.Response.fromStream(res);
      print(response.body);
      //var res = response.body;
      print("response: $res");
      if (response.statusCode == 200) {
        print("Saving Data ");
        print(response.body);
      } else {
        print(response.statusCode);
      }
    }
  }

  Future saveToApIDemandWith(List<DemandNoticeModel> demandList) async {
    for (var i = 0; i < demandList.length; i++) {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            'https://www.ggcom.com.ng/luc/api/demand_notice_api.php',
          ));
      request.fields['id'] = demandList[i].id.toString();
      request.fields['property_id'] = demandList[i].propertyId.toString();
      request.files.add(await http.MultipartFile.fromPath(
          'image', demandList[i].image.toString()));

      var res = await request.send();
      final response = await http.Response.fromStream(res);
      print(response.body);
      //var res = response.body;
      print("response: $res");
      if (response.statusCode == 200) {
        print("Saving Data ");
        print(response.body);
      } else {
        print(response.statusCode);
      }
    }
  }

  final conn = SqfliteDatabaseHelper.instance;

  Future<List> fetchAllDemands() async {
    final dbClient = await conn.db;
    List<DemandNoticeModel> demandList = [];
    try {
      final maps = await dbClient
          .query(SqfliteDatabaseHelper.instance.demandNoticeTable);
      for (var item in maps) {
        demandList.add(DemandNoticeModel.fromJson(item));
        print(demandList);
      }
    } catch (e) {
      print(e.toString());
    }
    return demandList;
  }

  Future<List> fetchAllInfo() async {
    final dbClient = await conn.db;
    List<EnumerationModel> enumerationList = [];
    try {
      final maps =
          await dbClient.query(SqfliteDatabaseHelper.instance.enumerationTable);
      for (var item in maps) {
        enumerationList.add(EnumerationModel.fromJson(item));
        print(enumerationList);
      }
    } catch (e) {
      print(e.toString());
    }
    return enumerationList;
  }
}
