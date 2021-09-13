import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellandsign/data/repository.dart';
import 'package:sellandsign/models/contractor/contractor.dart';
import 'package:sellandsign/ui/newcontractor/new_contractor.dart';
import 'package:sellandsign/utils/toast.dart';
import 'package:sellandsign/widgets/contractor_card_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchControl = new TextEditingController();
  var contractors = <Contractor>[];

  @override
  void initState() {
    _searchControl.addListener(_onSearchTextChanged);

    //Prepare contractors list
    _getContractors();

    super.initState();
  }

  @override
  void dispose() {
    _searchControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        //Used to hide keyboard when losing focus on Fields
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: _buildBody(),
        ));
  }

  //AppBar methods:-------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      actions: <Widget>[
        AnimSearchBar(
          color: Colors.black,
          width: MediaQuery.of(context).size.width - 60,
          rtl: true,
          style: TextStyle(color: Colors.white),
          autoFocus: false,
          closeSearchOnSuffixTap: true,
          helpText: "Search",
          textController: _searchControl,
          onSuffixTap: () {
            setState(() {
              _searchControl.clear();
            });
          },
        ),
        IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewContractor(
                            callback: (value) {
                              _addContractorCallback(value);
                            },
                          )),
                );
              });
            })
      ],
    );
  }

  //body methods:---------------------------------------
  Widget _buildBody() {
    return Container(
        margin: new EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contractors",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold),
              ),
              _buildContractors(),
            ],
          ),
        ));
  }

  Widget _buildContractors() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: contractors.length,
        itemBuilder: (context, index) {
          return ContractorCard(
            contractor: contractors[index],
          );
        });
  }

  //api methods:--------------------------------------
  Future<List<Contractor>> _getContractors() async {
    MyToast.showToast("fetching contractors...");
    await Repository().getAndSaveContractors().then((value){
        if(value.isEmpty){
          MyToast.showToast("network error, fetching data locally..");
          Repository().getContractors().then((value) {
            setState(() {
              contractors = value;
            });
          });
           return;
        }
        setState(() {
          contractors = value;
        });
    });
    return contractors;
  }

  //Other Methods:--------------------------------------
  void _onSearchTextChanged() async {
    await Repository().getContractorsByName(_searchControl.text).then((value) {
      //Update contractors state
      setState(() {
        contractors = value;
      });
    });
  }

  void _addContractorCallback(Contractor? contractor) {
    if (contractor == null) {
      MyToast.showToast("error occurred");
      return;
    }
    //adding the new value at the top of the list, will be reorganized after the first event made on "contrators"
    setState(() {
      contractors.insert(0, contractor);
    });
  }
}
