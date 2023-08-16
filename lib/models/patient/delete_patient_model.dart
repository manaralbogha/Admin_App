class DeletePatientModel
{
  late bool success;
  late String message;

  DeletePatientModel.fromJson(Map<String,dynamic> jsonData){
    success = jsonData['success'];
    message = jsonData['message'];
  }
}