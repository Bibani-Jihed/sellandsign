class Contractor {
  int? id;
  String? civility;
  String? firstname;
  String? lastname;
  String? address_1;
  String? address_2;
  String? postal_code;
  String? city;
  String? cell_phone;
  String? email;


  Contractor({
    this.id,
    this.civility,
    this.firstname,
    this.lastname,
    this.address_1,
    this.address_2,
    this.postal_code,
    this.city,
    this.cell_phone,
    this.email,
  });

  factory Contractor.fromJson(Map<String, dynamic> json) =>
      Contractor(
        id: json["id"],
        civility: json["civility"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        address_1: json["address_1"],
        address_2: json["address_2"],
        postal_code: json["postal_code"],
        city: json["city"],
        cell_phone: json["cell_phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "civility": civility,
        "firstname": firstname,
        "lastname": lastname,
        "address_1": address_1,
        "address_2": address_2,
        "postal_code": postal_code,
        "city": city,
        "cell_phone": cell_phone,
        "email": email,
      };

}