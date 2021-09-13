import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellandsign/data/repository.dart';
import 'package:sellandsign/models/contractor/contractor.dart';
import 'package:sellandsign/utils/extensions.dart';
import 'package:sellandsign/utils/toast.dart';

class NewContractor extends StatefulWidget {
  final Function(Contractor) callback;

  NewContractor({required this.callback});

  @override
  State<StatefulWidget> createState() => _NewContractorState();
}

class _NewContractorState extends State<NewContractor> {
  TextEditingController _emailControl = new TextEditingController();
  TextEditingController _firstnameControl = new TextEditingController();
  TextEditingController _lastnameControl = new TextEditingController();
  TextEditingController _address1Control = new TextEditingController();
  TextEditingController _address2Control = new TextEditingController();
  TextEditingController _postalCodeControl = new TextEditingController();
  TextEditingController _cityControl = new TextEditingController();
  TextEditingController _cellPhoneControl = new TextEditingController();

  var _civilityValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
      title: Text("New contractor"),
    );
  }

  //body methods:---------------------------------------
  Widget _buildBody() {
    return Container(
        margin: new EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Wrap(
            runSpacing: 10,
            children: [
              _buildTextField("Firstname", _firstnameControl),
              _buildTextField("Lastname", _lastnameControl),
              _buildDropdownButton(),
              _buildTextField("Email", _emailControl),
              _buildTextField("Phone", _cellPhoneControl),
              _buildTextField("Address", _address1Control),
              _buildTextField("Address Line 2", _address2Control),
              _buildTextField("Postal / Zip Code", _postalCodeControl),
              _buildTextField("City", _cityControl),
              _buildAddButton(),
            ],
          ),
        ));
  }

  //build widgets
  Widget _buildTextField(hint, controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      height: 50.0,
      decoration: _decoration(),
      child: TextField(
        onChanged: (text) {},
        controller: controller,
        keyboardType: (hint == "Phone" || hint == "Postal Code")
            ? TextInputType.phone
            : TextInputType.text,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 30.0),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white30),
        ),
      ),
    );
  }

  Widget _buildDropdownButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 30),
      alignment: Alignment.centerLeft,
      height: 50.0,
      decoration: _decoration(),
      child: DropdownButton<String>(
          hint: Text("Civility", style: TextStyle(color: Colors.white30)),
          value: _civilityValue,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          iconSize: 30,
          dropdownColor: Colors.black,
          underline: SizedBox(),
          onChanged: (value) {
            setState(() {
              _civilityValue = value!;
            });
          },
          items: <String>[
            'MONSIEUR',
            'MADAME',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            );
          }).toList()),
    );
  }

  Widget _buildAddButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: addContractor,
        child: Text(
          'ADD',
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Colors.black,
      border: Border.all(
          color: Colors.white30, // border color
          width: 2.0), // border width
      borderRadius:
          BorderRadius.all(Radius.circular(20.0)), // rounded corner radius
    );
  }

  //api methods:--------------------------------------
  Future<void> addContractor() async {
    //check fields
    if (!_isValidForm()){
      MyToast.showToast("please check provided information");
      return;
    }

    //create a contractor from fields
    Contractor contractor = new Contractor(
      civility: _civilityValue,
      email: _emailControl.text.trim(),
      firstname: _firstnameControl.text.trim(),
      lastname: _lastnameControl.text.trim(),
      address_1: _address1Control.text.trim(),
      address_2: _address2Control.text.trim(),
      postal_code: _postalCodeControl.text.trim(),
      city: _cityControl.text.trim(),
      cell_phone: _cellPhoneControl.text.trim(),
    );

    //add the new contractor (remotely then locally if success)
    await Repository().addContractor(contractor).then((value) {
      //Notify that a new contractor has been added
      widget.callback(value!);
      //Go back to Home
      Navigator.pop(context);
    });
  }

//Other Methods:--------------------------------------
  bool _isValidForm() {
    //  simple checker to secure given data not empty
    //  email should respect the regex
    //  "civility" is one of the following (MONSIEUR,MADAME)
    if (!_emailControl.text.isValidEmail()) return false;
    if (_firstnameControl.text.isEmpty) return false;
    if (_lastnameControl.text.isEmpty) return false;
    if (_postalCodeControl.text.isEmpty) return false;
    if (_cityControl.text.isEmpty) return false;
    if (_cellPhoneControl.text.isEmpty) return false;
    if (_address1Control.text.isEmpty) return false;
    if (_address2Control.text.isEmpty) return false;
    if (_civilityValue != "MONSIEUR" && _civilityValue != "MADAME") return false;

    //  perfect, everything is good, return true
    return true;
  }
}
