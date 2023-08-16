class IndexSecretariaModel {
  IndexSecretariaModel({
    required this.success,
    required this.message,
    required this.secretary,
  });
  late final bool success;
  late final String message;
  late final List<SecretaryModel> secretary;

  IndexSecretariaModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    secretary = List.from(json['Secretary']).map((e)=>SecretaryModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['Secretary'] = secretary.map((e)=>e.toJson()).toList();
    return data;
  }
}

class SecretaryModel {
  SecretaryModel({
    required this.id,
    required this.userId,
    required this.departmentId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
  late final int id;
  late final int userId;
  late final int departmentId;
  late final String createdAt;
  late final String updatedAt;
  late final UserModel user;

  SecretaryModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    departmentId = json['department_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['department_id'] = departmentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user.toJson();
    return data;
  }
}

class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNum,
    required this.email,
    this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String phoneNum;
  late final String email;
  late final Null emailVerifiedAt;
  late final String role;
  late final String createdAt;
  late final String updatedAt;

  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNum = json['phone_num'];
    email = json['email'];
    emailVerifiedAt = null;
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_num'] = phoneNum;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}




/*
class IndexSecretariaModel
{
   late bool success;
   late String message;
   late List<SecretariaModel> Secretary;

  IndexSecretariaModel({
    required this.success,
    required this.message,
    required this.Secretary,
  });

  IndexSecretariaModel.fromJson(Map<String,dynamic>jsonData){
      success = jsonData['success'];
      message = jsonData['message'];
      Secretary = [];
      //if(jsonData['Secretary'] != null) {
        jsonData['Secretary'].forEach((element) {
          Secretary.add(SecretariaModel.fromJson(element));
        });
      //}
      */
/*secretary = jsonData['secretary']
                .map((dynamic item) => SecretariaModel.fromJson(item))
                .toList();*//*

  }
}

class SecretariaModel
{
  late int id;
  late int user_id;
  late int department_id;
  late UserModel user;

  SecretariaModel({
    required this.id,
    required this.user_id,
    required this.department_id,
    required this.user,
  });

  SecretariaModel.fromJson(Map<String,dynamic> jsonData){
    id = jsonData['id'];
    user_id = jsonData['user_id'];
    user_id = jsonData['department_id'];
    user = UserModel.fromJson(jsonData['user']);
  }
}

class UserModel
{
  late String first_name;
  late String last_name;
  late String phone_num;
  late String email;

  UserModel({
    required this.first_name,
    required this.last_name,
    required this.phone_num,
    required this.email,
  });

  UserModel.fromJson(Map<String,dynamic> jsonData){
      first_name = jsonData['first_name'];
      last_name = jsonData['last_name'];
      phone_num = jsonData['phone_num'];
      email = jsonData['email'];
  }
}*/
