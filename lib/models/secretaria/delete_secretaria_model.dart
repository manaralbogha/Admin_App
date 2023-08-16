class DeleteSecretariaModel
{
  late bool success;
  late String message;

  DeleteSecretariaModel.fromJson(Map<String,dynamic> jsonData){
    success = jsonData['success'];
    message = jsonData['message'];
  }
}