import 'dart:io';

class RegisterDoctorModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? departmentName;
  String? description;
  String? phoneNum;
  String? specialty;
  String? consulationPrice;
  File? image;

  RegisterDoctorModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNum,
    this.specialty,
    this.consulationPrice,
    this.image,
    this.departmentName,
    this.description,
  });
}
