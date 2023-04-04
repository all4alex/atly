// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfileModel {
  String? email;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? bday;
  String? country;
  String? city;

  UserProfileModel({
    this.email,
    this.firstName,
    this.lastName,
    this.contactNumber,
    this.bday,
    this.country,
    this.city,
  });

  UserProfileModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? contactNumber,
    String? bday,
    String? country,
    String? city,
  }) {
    return UserProfileModel(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      contactNumber: contactNumber ?? this.contactNumber,
      bday: bday ?? this.bday,
      country: country ?? this.country,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'contactNumber': contactNumber,
      'bday': bday,
      'country': country,
      'city': city,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      contactNumber:
          map['contactNumber'] != null ? map['contactNumber'] as String : null,
      bday: map['bday'] != null ? map['bday'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfileModel(email: $email, firstName: $firstName, lastName: $lastName, contactNumber: $contactNumber, bday: $bday, country: $country, city: $city)';
  }

  @override
  bool operator ==(covariant UserProfileModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.contactNumber == contactNumber &&
        other.bday == bday &&
        other.country == country &&
        other.city == city;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        contactNumber.hashCode ^
        bday.hashCode ^
        country.hashCode ^
        city.hashCode;
  }
}
