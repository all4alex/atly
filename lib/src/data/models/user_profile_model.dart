import 'dart:convert';

class UserProfileModel {
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? bday;
  String? country;
  String? city;

  UserProfileModel(
      {this.firstName,
      this.lastName,
      this.contactNumber,
      this.bday,
      this.country,
      this.city});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'contactNumber': contactNumber,
      'bday': bday,
      'country': country,
      'city': city,
    };
  }
}
