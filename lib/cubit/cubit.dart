import 'dart:convert';
import 'dart:developer';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_manage_app/core/api/services/local/cache_helper.dart';
import 'package:med_manage_app/cubit/states.dart';
import 'package:med_manage_app/helper/dio_helper.dart';
import 'package:med_manage_app/models/department/add_department_model.dart';
import 'package:med_manage_app/modules/doctors_screen/doctors_screen.dart';
import '../constant.dart';
import '../helper/end_points.dart';
import '../models/department/delete_department_model.dart';
import '../models/department/index_department_model.dart';
import '../models/patient/delete_patient_model.dart';
import '../models/patient/index_patient_model.dart';
import '../models/patient/view_patient_model.dart';
import '../models/secretaria/delete_secretaria_model.dart';
import '../models/secretaria/index_secretaria_model.dart';
import '../models/secretaria/register_secretaria_model.dart';
import '../models/secretaria/update_secretaria_model.dart';
import '../models/secretaria/view_secretaria_model.dart';
import '../modules/department/department_screen.dart';
import '../modules/patients/patients_screen.dart';
import '../modules/secretaria/secretaria_screen.dart';
import '../modules/settings/settings_screen.dart';

class MedManageCubit extends Cubit<MedManageStates> {
  MedManageCubit() : super(MedManageInitialState());

  static MedManageCubit get(context) => BlocProvider.of(context);
  static String tokenOfAdmin = CacheHelper.getData(key: 'Token');
  // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZmY0ZWMxZThhZDljNmY4ZmVmYzNlYzgxOWIxZjQ2OTM3NWI4OWQ1ZTc1NmJlYjBlZTNlNmM1Zjg3OTQ5NjhhMjc5MDE0YzQ5MTY5ZjkxYjEiLCJpYXQiOjE2OTE0NzM1MzYuNTc0ODI1LCJuYmYiOjE2OTE0NzM1MzYuNTc0ODMsImV4cCI6MTcyMzA5NTkzNi41NTc4OTUsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.xoJ-WhdrIJVGrWYmU7PlHbuC6sGs59LWw3vuwD-ywlS-xX2U2pDV27zNy1bLinaAk771W9wFyKFG4fACmmdsXfr3oshVrdWI7Rs4tfpHmtR5lAQ6aohIQJg9qeeWEUOWzWcI9R9L2Kv_q6UWV_eGyne2_zJCy728rMP2k3Vw_UYdv4SgfJhErmfia9MNJzb3d48SZRYyqGFIB61uXLG33trOCYOvO_oKnyxpGls5mNZ0Ep6I-3yYPFwlM9YDcX4BTVWVvx1c8Tje6cbLBdXy_MaQAsf8SHdra7XEK6Zb8TJhLjnwuEwbQL8RBNtxi_PPIG0hYDaczUKZXaO3iDmvwQKTnqMZsYI9H1SddXuJOJgnc9Ppzl-4NXLxJTWjwYjVuQxne3t0DAqNaZoC_0E5ut8K5HZ0pd3A4UyOZL2E0gojkMQXaoY9YKfueCQlhTHZ3aYT7Gawgc_2_X9ujGNQNsDa-1rvQSJLE40-1xwITVTS5pq-Tm945rHZibhWxfq0Wt0sZ4kpmS9RULTt3hKpbgDfgQSqroXBMFkWINSQ1_FF4aLTjc1_mxADp1qOauYDPY34zdGB0UhCzatPdMNVWu7nG_paMcmQIKVMdg2JkKyH4jMVV40rAB9yqLjeyVKe9z3u0v58XxLJGg9uvk7bdB_XoFTz4JDp7gHBadJqLgA';
  static String baseUrl = baseURL;

  int currentIndex = 0;
  static int index = 0;

  List<Widget> bottomScreens = [
    DepartmentScreen(
      index: index,
    ),
    const PatientsScreen(),
    const SecretariaScreen(),
    DoctorsView(token: CacheHelper.getData(key: 'Token')),
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: 25.0,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        size: 25.0,
      ),
      label: 'Patients',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.manage_accounts,
        size: 25.0,
      ),
      label: 'Secretary',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.stethoscope,
        size: 25.0,
      ),
      label: 'Doctors',
    ),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(MedManageChangeBottomNavState());
    if (index == 1) {
      indexPatientsList();
    }
    if (index == 2) {
      indexSecretariaList();
    }
  }

  IconData suffixIcon = Icons.visibility;
  bool isPassShow = false;

  void changePassVisibility() {
    isPassShow = !isPassShow;
    suffixIcon = isPassShow ? Icons.visibility_off : Icons.visibility;
    emit(MedManageChangePassVisibilityState());
  }

  late DepartmentHomeModel departmentHomeModel;
  void getHomeDepData() {
    emit(MedManageLoadHomeDepDataState());

    DioHelper.getData(
      url: INDEX_DEPARTMENT,
      token: tokenOfAdmin,
    ).then((value) {
      departmentHomeModel = DepartmentHomeModel.fromJson(value.data);
      //print(departmentHomeModel.Department![1].img);
      emit(MedManageSuccessHomeDepDataState());
    }).catchError((error) {
      emit(MedManageErrorHomeDepDataState(error.toString()));
      print('err: ${error.toString()}');
    });
  }

  late AddDepartmentModel addDepartmentModel;
  void addDepartment({
    required String name,
    required String img,
  }) {
    DioHelper.postData(url: ADD_DEPARTMENT, token: tokenOfAdmin, data: {
      'name': name,
      'img': img,
    }).then((value) {
      addDepartmentModel = AddDepartmentModel.fromJson(value.data);
      emit(MedManageAddDepartmentSuccessState());
      getHomeDepData();
    }).catchError((error) {
      emit(MedManageAddDepartmentErrorState());
    });
  }

  late DeleteDepartmentModel deleteDepartmentModel;
  void deleteDepartment({
    required int id,
  }) {
    DioHelper.postData(url: DELETE_DEPARTMENT, token: tokenOfAdmin, data: {
      'id': id,
    }).then((value) {
      deleteDepartmentModel = DeleteDepartmentModel.fromJson(value.data);
      emit(MedManageDeleteDepartmentSuccessState());
      getHomeDepData();
    }).catchError((error) {
      emit(MedManageDeleteDepartmentErrorState());
    });
  }

  void updateDepartment({
    required int id,
    required String name,
  }) {
    DioHelper.postData(url: UPDATE_DEPARTMENT, token: tokenOfAdmin, data: {
      'id': id,
      'name': name,
    }).then((value) {
      departmentHomeModel = DepartmentHomeModel.fromJson(value.data);
      emit(MedManageUpdateDepartmentSuccessState());
      getHomeDepData();
    }).catchError((error) {
      emit(MedManageUpdateDepartmentErrorState());
    });
  }

  // File? departmentImage;
  var departmentImage;
  final picker = ImagePicker();
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      departmentImage = pickedFile.path;
      //File(pickedFile.path);
      print(departmentImage.toString());
      emit(MedManageDepImagePickedSuccessState());
    } else {
      print('no image selected.');
      emit(MedManageDepImagePickedErrorState());
    }
  }

  Future<dynamic> postWithImage({
    required String endPoint,
    required Map<String, String> body,
    @required String? imagePath,
    @required String? token,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl$endPoint'),
    );
    request.fields.addAll(body);
    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath('img', imagePath));
    }
    request.headers.addAll(
      {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    http.StreamedResponse response = await request.send();

    http.Response r = await http.Response.fromStream(response);

    if (r.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(r.body);
      log('HTTP POSTIMAGE Data: $data');
      getHomeDepData();
      return data;
    } else {
      throw Exception(
        'there is an error with status code ${r.statusCode} and with body : ${r.body}',
      );
    }
  }

  //Secritary AND Patient*********************************************************************************************************************

  late IndexSecretariaModel indexSecretariaModel;

  void indexSecretariaList() {
    emit(MedManageLoadingSecretariaListState());
    DioHelperG.getDataG(url: 'indexSecretary', query: null, token: tokenG)
        .then((value) {
      indexSecretariaModel = IndexSecretariaModel.fromJson(value.data);
      print(value.toString());
      print(indexSecretariaModel.message);
      print(indexSecretariaModel.secretary[0].user.firstName);
      emit(MedManageSuccssesSecretariaListState());
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorSecretariaListState());
    });
  }

  late DeleteSecretariaModel deleteSecretariaModel;

  void deleteSecretaria({
    required int user_id,
  }) {
    emit(MedManageLoadingSecretariaProfDeleteState());
    DioHelperG.postDataG(
      url: 'deleteSecretary',
      data: {
        'user_id': user_id,
      },
      token: tokenG,
    ).then((value) {
      deleteSecretariaModel = DeleteSecretariaModel.fromJson(value.data);
      print(value.data);
      print(deleteSecretariaModel.success);
      print(deleteSecretariaModel.message);
      emit(MedManageSuccssesSecretariaProfDeleteState());
      indexSecretariaList();
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorSecretariaProfDeleteState());
    });
  }

  late ViewSecretariaModel viewSecretariaModel;

  void viewSecretaria({
    required int user_id,
  }) {
    emit(MedManageLoadingSecretariaProfState());
    DioHelperG.postDataG(
            url: 'viewSecretary',
            data: {
              'user_id': user_id,
            },
            token: tokenG)
        .then((value) {
      print(value.data);
      viewSecretariaModel = ViewSecretariaModel.fromJson(value.data);
      //print(viewSecretariaModel.secretary?.departmentId);
      //print(viewSecretariaModel.secretary?.user.firstName);
      emit(MedManageSuccssesSecretariaProfState());
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorSecretariaProfState());
    });
  }

  late UpdateSecretariaModel updateSecretariaModel;

  void updateSecretaria({
    required String? first_name,
    required String? last_name,
    required String? department_name,
    required String? phone_num,
    required int user_id,
  }) {
    emit(MedManageLoadingSecretariaProfState());
    DioHelperG.postDataG(
            url: 'updateSecretary',
            data: {
              'first_name': first_name,
              'last_name': last_name,
              'department_name': department_name,
              'phone_num': phone_num,
              'user_id': user_id,
            },
            token: tokenG)
        .then((value) {
      //print(value.data);
      // print(value.data['message']);
      updateSecretariaModel = UpdateSecretariaModel.fromJson(value.data);
      print(updateSecretariaModel.success);
      emit(MedManageSuccssesSecretariaProfEditState());
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorSecretariaProfEditState());
    });
  }

  late RegisterSecretariaModel registerSecretariaModel;

  void registerSecretaria({
    required String first_name,
    required String last_name,
    required String phone_num,
    required String email,
    required String password,
    required String department_name,
  }) {
    emit(MedManageLoadingSecretariaRegisterState());
    DioHelperG.postDataG(
            url: 'registerSecretary',
            data: {
              'first_name': first_name,
              'last_name': last_name,
              'phone_num': phone_num,
              'email': email,
              'password': password,
              'department_name': department_name,
            },
            token: tokenG)
        .then((value) {
      print(value.data);
      registerSecretariaModel = RegisterSecretariaModel.fromJson(value.data);
      // print(value.toString());
      // print(registerSecretariaModel.token);
      // print(registerSecretariaModel.role);
      emit(MedManageSuccssesSecretariaRegisterState());
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorSecretariaRegisterState());
    });
  }

  late IndexPatientModel indexPatientModel;

  void indexPatientsList() {
    emit(MedManageLoadingPatientsListState());
    DioHelperG.getDataG(url: 'indexPatient', query: null, token: tokenG)
        .then((value) {
      indexPatientModel = IndexPatientModel.fromJson(value.data);
      //print(value.toString());
      //print(indexPatientModel.patient[0].user.firstName);
      emit(MedManageSuccssesPatientsListState());
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorPatientsListState());
    });
  }

  late DeletePatientModel deletePatientModel;

  void deletePatient({
    required int user_id,
  }) {
    emit(MedManageLoadingPatientsDeleteState());
    DioHelperG.postDataG(
      url: 'deletePatient',
      data: {
        'user_id': user_id,
      },
      token: tokenG,
    ).then((value) {
      deletePatientModel = DeletePatientModel.fromJson(value.data);
      // print(value.data);
      // print(deletePatientModel.success);
      // print(deletePatientModel.message);
      emit(MedManageSuccssesPatientsDeleteState());
      indexPatientsList();
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorPatientsDeleteState());
    });
  }

  late ViewPatientModel viewPatientModel;

  void viewPatient({
    required int user_id,
  }) {
    emit(MedManageLoadingPatientsProfState());
    DioHelperG.postDataG(
            url: 'viewPatient',
            data: {
              'user_id': user_id,
            },
            token: tokenG)
        .then((value) {
      print(value.data);
      viewPatientModel = ViewPatientModel.fromJson(value.data);
      // print(viewPatientModel.message);
      // print(viewPatientModel.patient.user.firstName);
      emit(MedManageSuccssesPatientsProfState());
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorPatientsProfState());
    });
  }

/*
  bool isDark = false;
   void changeMode({ bool? fromShared})
    {
      if(fromShared != null)
      {
        isDark = fromShared;//true
        emit(MedManageChangeModeState());
      } else
      {
        isDark = !isDark;
        CacheHelper.putBoolean(
            key: 'isDark',
            value: isDark).
        then((value)
        {
          emit(MedManageChangeModeState());
        });
      }


    }
*/
}
