class DepartmentHomeModel
{
  bool? success;
  String? message;
  List<DepartmentModel>? Department =[];//list of object

  DepartmentHomeModel({
    this.success,
    this.message,
    this.Department
});

  DepartmentHomeModel.fromJson(Map<String,dynamic>json)
  {
    success = json['success'];
    message = json['message'];

    json['Department'].forEach((element)
    {
      Department?.add(DepartmentModel.fromJson(element));
    });
  }
}


class DepartmentModel
{

  late final int id;
  late final String name;
  late final String img;
  late final String created_at;
  late final String updated_at;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.img,
    required this.created_at,
    required this.updated_at,
});


  DepartmentModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }


}

