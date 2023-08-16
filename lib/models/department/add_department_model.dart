class AddDepartmentModel
{
  late bool success;
  late String message;
  late DepartmentData Department;


  AddDepartmentModel.fromJson(Map<String,dynamic> json)
  {
    success = json['success'];
    message = json['message'];
    Department = (json['Department'] != null ? DepartmentData.fromJson(json['Department']): null)!;

  }


}
class DepartmentData
{
  int? id;
  String? name;
  String? image;
  String? created_at;
  String ?updated_at;

  DepartmentData({
    this.id,
    this.name,
    this.image,
    this.created_at,
    this.updated_at,
  });

  //named
  DepartmentData.fromJson(Map <String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['img'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}