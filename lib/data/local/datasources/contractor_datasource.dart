import 'package:sellandsign/data/local/constants/db_constants.dart';
import 'package:sellandsign/models/contractor/contractor.dart';

import '../app_database.dart';

class ContractorDataSources {

  static final ContractorDataSources _singleton = ContractorDataSources._internal();

  ContractorDataSources._internal();

  factory ContractorDataSources() {
    return _singleton;
  }
  //insert:--------------------------------------------------------
  Future<Contractor?> addContractor(Contractor contractor) async {
    //check if current contractor doesn't already exist
    if (await getContractorById(contractor.id) != null) return null;
    //get database instance
    final _db = await AppDatabase().database;

    await _db!.rawInsert(
        "INSERT Into ${DBConstants.CONTRACTOR_TABLE} ("
        "${DBConstants.ID},"
        "${DBConstants.CIVILITY},"
        "${DBConstants.FIRSTNAME},"
        "${DBConstants.LASTNAME},"
        "${DBConstants.ADDRESS_1},"
        "${DBConstants.ADDRESS_2},"
        "${DBConstants.POSTAL_CODE},"
        "${DBConstants.CITY},"
        "${DBConstants.CELL_PHONE},"
        "${DBConstants.EMAIL})"
        " VALUES (?,?,?,?,?,?,?,?,?,?)",
        [
          contractor.id,
          contractor.civility,
          contractor.firstname,
          contractor.lastname,
          contractor.address_1,
          contractor.address_2,
          contractor.postal_code,
          contractor.city,
          contractor.cell_phone,
          contractor.email,
        ]);
    return contractor;
  }


  //select:--------------------------------------------------------
  Future<Contractor?> getContractorById(int? id) async {
    final _db = await AppDatabase().database;
    var res = await _db!.query(DBConstants.CONTRACTOR_TABLE,
        where: "${DBConstants.ID} = ?", whereArgs: [id]);
    return res.isNotEmpty ? Contractor.fromJson(res.first) : null;
  }
  Future<List<Contractor>> getContractorsByName(String str) async {
    final _db = await AppDatabase().database;
    var res = await _db!.rawQuery("SELECT * FROM ${DBConstants.CONTRACTOR_TABLE} "
        "WHERE ${DBConstants.FIRSTNAME} LIKE '%$str%' "
        "OR "
        "${DBConstants.LASTNAME} LIKE '%$str%'");
    List<Contractor> list =
    res.isNotEmpty ? res.map((c) => Contractor.fromJson(c)).toList() : [];
    return list.reversed.toList();
  }
  Future<List<Contractor>> getAllContractors() async {
    final _db = await AppDatabase().database;
    var res = await _db!.query(DBConstants.CONTRACTOR_TABLE);
    List<Contractor> list =
        res.isNotEmpty ? res.map((c) => Contractor.fromJson(c)).toList() : [];
    return list.reversed.toList();
  }


  //delete:--------------------------------------------------------
  deleteAllContractors() async {
    final _db = await AppDatabase().database;
    _db!.rawDelete("Delete from ${DBConstants.CONTRACTOR_TABLE}");
  }
}
