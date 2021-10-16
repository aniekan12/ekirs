import 'package:data_collection/models/demand_model.dart';
import 'package:data_collection/models/enumeration_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDatabaseHelper {
  static final SqfliteDatabaseHelper instance = SqfliteDatabaseHelper._init();
  final String enumerationTable = 'enumerationTable';
  final String demandNoticeTable = 'demandNoticeTable';

  SqfliteDatabaseHelper._init();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb('ekirss.db');
    return _db;
  }

  Future<Database> initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print(dbPath);
    var openDb = await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
    );
    return openDb;
  }

  Future _createDb(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL';
    final textType = 'TEXT';
    await db.execute('''
      CREATE TABLE $demandNoticeTable(
        ${DemandFields.id} $idType,
        ${DemandFields.propertyId} $textType,
        ${DemandFields.image} $textType
      )''');
    await db.execute('''
        CREATE TABLE $enumerationTable (
          ${EnumerationFields.id} $idType,
          ${EnumerationFields.title} $textType,
          ${EnumerationFields.firstname} $textType, 
          ${EnumerationFields.middlename} $textType, 
          ${EnumerationFields.lastname} $textType, 
          ${EnumerationFields.gender} $textType, 
          ${EnumerationFields.email} $textType,
          ${EnumerationFields.phoneNumber} $textType,
          ${EnumerationFields.occupation} $textType,
          ${EnumerationFields.propertyId} $textType,
          ${EnumerationFields.houseNumber} $textType,
          ${EnumerationFields.street} $textType,
          ${EnumerationFields.area} $textType,
          ${EnumerationFields.landmark} $textType,
          ${EnumerationFields.propertyName} $textType,
          ${EnumerationFields.propertyType} $textType,
          ${EnumerationFields.areaSize} $textType,
          ${EnumerationFields.buildingType} $textType,
          ${EnumerationFields.buildingPurpose} $textType,
          ${EnumerationFields.category} $textType,
          ${EnumerationFields.areaClass} $textType,
          ${EnumerationFields.lga} $textType,
          ${EnumerationFields.zone} $textType,
          ${EnumerationFields.agentId} $textType,
          ${EnumerationFields.macAddress} $textType,
          ${EnumerationFields.latitude} $textType,
          ${EnumerationFields.longitude} $textType,
          ${EnumerationFields.image} $textType
          )''');
  }

  Future<EnumerationModel> addData(EnumerationModel enumerationModel) async {
    final db = await instance.db;

    final id = await db.insert(enumerationTable, enumerationModel.toJson());
    return enumerationModel.copy(id: id);
  }

  Future<DemandNoticeModel> addDemand(DemandNoticeModel demandNotice) async {
    final db = await instance.db;

    final id = await db.insert(demandNoticeTable, demandNotice.toJson());
    return demandNotice.copy(id: id);
  }

  Future<List<dynamic>> fetchAllDemand() async {
    final db = await instance.db;
    List<dynamic> contactList = [];
    try {
      final maps =
          await db.query(SqfliteDatabaseHelper.instance.demandNoticeTable);
      for (var item in maps) {
        contactList.add(DemandNoticeModel.fromJson(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  Future<List<dynamic>> fetchAllInfo() async {
    final db = await instance.db;
    List<dynamic> contactList = [];
    try {
      final maps =
          await db.query(SqfliteDatabaseHelper.instance.enumerationTable);
      for (var item in maps) {
        contactList.add(EnumerationModel.fromJson(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  Future<List<dynamic>> readAllDemands() async {
    final db = await instance.db;

    List contactList = [];
    try {
      final maps =
          await db.query(SqfliteDatabaseHelper.instance.demandNoticeTable);
      for (var item in maps) {
        contactList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;

    // final orderBy = '${EnumerationFields.id} ASC';

    // final result = await db.query(enumerationTable, orderBy: orderBy);

    // return result.map((json) => EnumerationModel.fromJson(json)).toList();
  }

  Future<List<dynamic>> readAllNotes() async {
    final db = await instance.db;

    List contactList = [];
    try {
      final maps =
          await db.query(SqfliteDatabaseHelper.instance.enumerationTable);
      for (var item in maps) {
        contactList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;

    // final orderBy = '${EnumerationFields.id} ASC';

    // final result = await db.query(enumerationTable, orderBy: orderBy);

    // return result.map((json) => EnumerationModel.fromJson(json)).toList();
  }

  Future close() async {
    final dab = await instance.db;

    dab.close();
  }
}
