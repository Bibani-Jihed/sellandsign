import 'package:sellandsign/data/local/datasources/contractor_datasource.dart';
import 'package:sellandsign/data/network/apis/cutomers/contractor_api.dart';
import 'package:sellandsign/models/contractor/contractor.dart';

class Repository {
  //Turn Repository into Singleton, only one instance needed
  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();

  //GET
  Future<List<Contractor>> getAndSaveContractors() async{
    //make a network call to get all Contractors, store them into local database
    return ContractorApi().getContractors().then((list) {
      list.forEach((contractor) async {
        await ContractorDataSources().addContractor(contractor);
      });
      //return an alphabetical order list
      return _sort(list);
    });
  }

  Future<List<Contractor>> getContractors() async {
    //fetch Contractors from local database
    //return an alphabetical order list
    return _sort(await ContractorDataSources().getAllContractors());
  }

  Future<List<Contractor>> getContractorsByName(str) async {
    //Search based on firstname & lastname
    //return an alphabetical order list
    return _sort( await ContractorDataSources().getContractorsByName(str));
  }


  //POST
  Future<Contractor?>addContractor(contractor) async{
    //update server and local database
    return ContractorDataSources().addContractor(await ContractorApi().addContractor(contractor));
  }


  //DELETE
  Future<void> deleteAll() async {
    //delete all contractors
    await ContractorDataSources().deleteAllContractors();
  }


  //Other

  //firstname is used to sort input list
  List<Contractor> _sort(list){
    list.sort((a, b) => a.firstname.toString().toLowerCase().compareTo(b.firstname.toString().toLowerCase()));
    return list;
  }

}
