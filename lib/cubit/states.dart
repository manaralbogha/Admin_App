
abstract class MedManageStates{}

class MedManageInitialState extends MedManageStates{}
class MedManageChangeBottomNavState extends MedManageStates{}

class MedManageChangePassVisibilityState extends MedManageStates{}


class MedManageLoadHomeDepDataState extends MedManageStates{}
class MedManageSuccessHomeDepDataState extends MedManageStates
{
  /*final DepartmentHomeModel depHomeModel;
  MedManageSuccessHomeDepDataState(this.depHomeModel);*/
}
class MedManageErrorHomeDepDataState extends MedManageStates
{
  final String error;
  MedManageErrorHomeDepDataState(this.error);

}


class MedManageLoadingAddDepartmentState extends MedManageStates{}
class MedManageAddDepartmentSuccessState extends MedManageStates{}
class MedManageAddDepartmentErrorState extends MedManageStates{}

class MedManageDeleteDepartmentSuccessState extends MedManageStates{}
class MedManageDeleteDepartmentErrorState extends MedManageStates{}

class MedManageLoadingUpdateDepartmentState extends MedManageStates{}
class MedManageUpdateDepartmentSuccessState extends MedManageStates{}
class MedManageUpdateDepartmentErrorState extends MedManageStates{}

class MedManageDepImagePickedSuccessState extends MedManageStates{}
class MedManageDepImagePickedErrorState extends MedManageStates{}

//Secritary AND Patient*********************************************************************************************************************

class MedManageLoadingSecretariaListState extends MedManageStates{}
class MedManageSuccssesSecretariaListState extends MedManageStates{}
class MedManageErrorSecretariaListState extends MedManageStates{}

class MedManageLoadingSecretariaProfState extends MedManageStates{}
class MedManageSuccssesSecretariaProfState extends MedManageStates{}
class MedManageErrorSecretariaProfState extends MedManageStates{}

class MedManageLoadingSecretariaProfEditState extends MedManageStates{}
class MedManageSuccssesSecretariaProfEditState extends MedManageStates{}
class MedManageErrorSecretariaProfEditState extends MedManageStates{}

class MedManageLoadingSecretariaProfDeleteState extends MedManageStates{}
class MedManageSuccssesSecretariaProfDeleteState extends MedManageStates{}
class MedManageErrorSecretariaProfDeleteState extends MedManageStates{}

class MedManageLoadingSecretariaRegisterState extends MedManageStates{}
class MedManageSuccssesSecretariaRegisterState extends MedManageStates{}
class MedManageErrorSecretariaRegisterState extends MedManageStates{}

class MedManageLoadingPatientsListState extends MedManageStates{}
class MedManageSuccssesPatientsListState extends MedManageStates{}
class MedManageErrorPatientsListState extends MedManageStates{}

class MedManageLoadingPatientsProfState extends MedManageStates{}
class MedManageSuccssesPatientsProfState extends MedManageStates{}
class MedManageErrorPatientsProfState extends MedManageStates{}

class MedManageLoadingPatientsDeleteState extends MedManageStates{}
class MedManageSuccssesPatientsDeleteState extends MedManageStates{}
class MedManageErrorPatientsDeleteState extends MedManageStates{}
