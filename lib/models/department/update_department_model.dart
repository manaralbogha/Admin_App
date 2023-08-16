/*
"success": true,
"message": "Department updated successfully.",
"Department": {
"id": 3,
"name": "public",
"created_at": "2023-07-04T20:19:34.000000Z",
"updated_at": "2023-07-06T09:20:50.000000Z"
}*/

class UpdateDepartmentModel
{
late bool success;
late String message;
late DepartmentData Department;


UpdateDepartmentModel.fromJson(Map<String,dynamic> json)
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
String? createdAt;
String ?updatedAt;

DepartmentData({
this.id,
this.name,
this.image,
this.createdAt,
this.updatedAt,
});

//named
DepartmentData.fromJson(Map <String,dynamic> json)
{
id = json['id'];
name = json['name'];
image = json['img'];
createdAt = json['created_at'];
updatedAt = json['updated_at'];
}
}