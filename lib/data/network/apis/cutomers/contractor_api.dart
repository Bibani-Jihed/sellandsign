import 'dart:convert';

import 'package:sellandsign/data/network/constants/endpoints.dart';
import 'package:sellandsign/data/network/rest_client.dart';
import 'package:sellandsign/models/contractor/contractor.dart';


class ContractorApi {
  //Turn ContractorApi into Singleton, only one instance needed
  static final ContractorApi _singleton = ContractorApi._internal();

  factory ContractorApi() {
    return _singleton;
  }

  ContractorApi._internal();

  // fetch Contractors
  Future<List<Contractor>> getContractors() {
    return RestClient().get(Uri.parse(Endpoints.CONTRACTORS)).then((dynamic res) {
      List<Contractor> list = new List<Contractor>.from((res!=null && res.isNotEmpty) ? res.map((c) => Contractor.fromJson(c)).toList() : []);
      return list;
    });
  }

  // Add new contractor
  Future<Contractor> addContractor(Contractor contractor) {
    var data= contractor.toJson();
    data.remove("id");
    return RestClient().post(Uri.parse(Endpoints.CONTRACTORS),body: jsonEncode(data)).then((dynamic res) {
      return Contractor.fromJson(res);
    });
  }
}
