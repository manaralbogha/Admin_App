class RegisterSecretariaModel
{
  late String token;
  late String role;

  RegisterSecretariaModel.fromJson(Map<String,dynamic> jsonData){
    token = jsonData['token'];
    role = jsonData['role'];
  }
}