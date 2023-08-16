import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../layout/med_manage_layout.dart';
import '../../widgets/add_image.dart';
import '../../widgets/component.dart';
import '../../widgets/custome_button.dart';
import '../../widgets/register_text_field.dart';

class RegisterSecretaria extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var phoneNum = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var department = TextEditingController();

  RegisterSecretaria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: ConditionalBuilder(
              condition: state is! MedManageLoadingSecretariaRegisterState,
              builder: (context) => Padding(
                padding: const EdgeInsetsDirectional.all(10.0),
                child: SingleChildScrollView(
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
                        RegisterTextField(
                          lableText: 'First Name',
                          icon: Icons.person,
                          controller: firstName,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        RegisterTextField(
                          lableText: 'Last Name',
                          icon: Icons.person,
                          controller: lastName,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        RegisterTextField(
                          lableText: 'Phone Number',
                          icon: Icons.phone,
                          controller: phoneNum,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        RegisterTextField(
                          lableText: 'Email',
                          icon: Icons.mail,
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        RegisterTextField(
                          lableText: 'Password',
                          icon: Icons.lock,
                          controller: pass,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'the password must be at least 6 characters';
                            }
                            return null;
                          },
                          obscureText: MedManageCubit.get(context).isPassShow,
                          suffixIcon: MedManageCubit.get(context).suffixIcon,
                          onPressed: (){
                            MedManageCubit.get(context).changePassVisibility();
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        RegisterTextField(
                          lableText: 'Department',
                          icon: Icons.business_rounded,
                          controller: department,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        CustomeButton(
                          text: 'Next',
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              MedManageCubit.get(context).registerSecretaria(
                                first_name: firstName.text,
                                last_name: lastName.text,
                                phone_num: phoneNum.text,
                                email: email.text,
                                password: pass.text,
                                department_name: department.text,
                              );
                              MedManageCubit.get(context).indexSecretariaList();
                              navigateAndReplacement(context, const MedManageLayout());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context) =>
              Column(
                 children: [
                  const Center(child: CircularProgressIndicator()),
                ],
              )
          ),
        );
      },
    );
  }
}
