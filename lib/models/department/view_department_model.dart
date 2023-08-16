class ViewDepartmentModel
{
  late bool success;
  late String message;
  late ItemOfDepartment item;


  ViewDepartmentModel.fromJson(Map<String,dynamic>json)
  {
    success =json['success'];
    message =json['message'];
    item = (json['item'] != null ? ItemOfDepartment.fromJson(json['item']): null)!;
  }


}
class ItemOfDepartment
{
  int? id;
  String? name;
  String? image;
  String? created_at;
  String ?updated_at;

  ItemOfDepartment({
    this.id,
    this.name,
    this.image,
    this.created_at,
    this.updated_at,
  });

  //named
  ItemOfDepartment.fromJson(Map <String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image =json['img'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}