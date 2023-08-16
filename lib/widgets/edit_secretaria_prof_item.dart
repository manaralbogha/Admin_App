import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../models/secretaria/index_secretaria_model.dart';
import '../models/secretaria/view_secretaria_model.dart';
import '../modules/secretaria_profile/secretaria_profile-screen.dart';
import '../styles/colors/colors.dart';
import 'add_image.dart';
import 'component.dart';
import 'edit_text_field.dart';

class EditSecretariaProfItem extends StatelessWidget {

  final ViewSecretariaModel model;
  final IndexSecretariaModel? modelIn;
  final int? index;
  var formKey = GlobalKey<FormState>();

  EditSecretariaProfItem({
    super.key,
    required this.model,
    required this.modelIn,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var firstName = TextEditingController(text: model.secretary!.user.firstName);
    var lastName = TextEditingController(text: model.secretary!.user.lastName);
    var phoneNum = TextEditingController(text: model.secretary!.user.phoneNum);
    var dep = TextEditingController(text: 'bone');
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state)
      {

      },
      builder: (context, state)
      {

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            leadingWidth: 80.0,
            leading: TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: color5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: (){
                navigateAndReplacement(context, const SecretariaProfile());
              },
            ),
            actions: [
              TextButton(
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: color5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: (){
                  if(formKey.currentState!.validate()){
                    MedManageCubit.get(context).updateSecretaria(
                      first_name: firstName.text,
                      last_name: lastName.text,
                      department_name: dep.text,
                      phone_num: phoneNum.text,
                      user_id: modelIn!.secretary.isEmpty ? 0 : modelIn!.secretary[index!].userId,
                    );
                    MedManageCubit.get(context).viewSecretaria(
                      user_id: modelIn!.secretary.isEmpty ? 0 : modelIn!.secretary[index!].userId,);
                    navigateAndReplacement(context, SecretariaProfile(index: index,));
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                start: 25.0,
                end: 25.0,
                top: 20.0,
                bottom: 10.0,
              ),
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AddImage(
                      image: 'assets/images/undraw_Male_avatar_g98d (1).png',
                      width: MediaQuery.of(context).size.height * .2,
                      height: MediaQuery.of(context).size.height * .2,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    EditTextField(
                      lableText: 'First Name',
                      controller: firstName,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    EditTextField(
                      lableText: 'Last Name',
                      controller: lastName,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    EditTextField(
                      lableText: 'Phone Number',
                      controller: phoneNum,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    EditTextField(
                      lableText: 'Department',
                      //initialValue: 'Dental',
                      keyboardType: TextInputType.text,
                      controller: dep,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
