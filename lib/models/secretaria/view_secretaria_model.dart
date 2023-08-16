class ViewSecretariaModel {
  ViewSecretariaModel({
    required this.success,
    required this.message,
    required this.secretary,
    required this.department,
  });
  late final bool success;
  late final String message;
  late final SecretaryModel secretary;
  late final Department department;

  ViewSecretariaModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    secretary = SecretaryModel.fromJson(json['secretary']);
    department = Department.fromJson(json['department']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['secretary'] = secretary.toJson();
    data['department'] = department.toJson();
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

class Department {
  Department({
    required this.id,
    required this.name,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String img;
  late final String createdAt;
  late final String updatedAt;

  Department.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}