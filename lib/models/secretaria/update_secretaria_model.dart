class UpdateSecretariaModel
{
  late bool success;
  late String message;

  UpdateSecretariaModel.fromJson(Map<String,dynamic> jsonData){
    success = jsonData['success'];
    message = jsonData['message'];
  }
}