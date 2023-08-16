class DeleteDepartmentModel
{
  late bool success;
  late String message;

  DeleteDepartmentModel({
    required this.success,
    required this.message,
});

  DeleteDepartmentModel.fromJson(Map<String, dynamic> json)
  {
    success = json['success'];
    message = json['message'];

  }

}
