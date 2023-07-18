import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_admin_app/core/functions/custome_dialogs.dart';
import 'package:project_one_admin_app/core/styles/colors/colors.dart';
import 'package:project_one_admin_app/core/styles/text_styles.dart';
import 'package:project_one_admin_app/core/widgets/custome_button.dart';
import 'package:project_one_admin_app/core/widgets/custome_error_widget.dart';
import 'package:project_one_admin_app/core/widgets/custome_progress_indicator.dart';
import 'package:project_one_admin_app/core/widgets/custome_text_field.dart';
import 'package:project_one_admin_app/main.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/add_work_times_screen.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/manager/register_doctor_cubit.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/manager/register_doctor_states.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/widgets/pick_image_widget.dart';

class RegisterDoctorView extends StatelessWidget {
  static const route = 'RegisterDoctorView';
  const RegisterDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    String token = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: BlocProvider(
        create: (context) => RegisterDoctorCubit(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: RegisterDoctorViewBody(token: token),
          ),
        ),
      ),
    );
  }
}

class RegisterDoctorViewBody extends StatelessWidget {
  final String token;
  const RegisterDoctorViewBody({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    RegisterDoctorCubit cubit = BlocProvider.of(context);
    return BlocBuilder<RegisterDoctorCubit, RegisterDoctorStates>(
      builder: (context, state) {
        if (state is RegisterDoctorLoading) {
          return const CustomeProgressIndicator();
        } else if (state is RegisterDoctorFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is RegisterDoctorSuccess) {
          return const AddWorkTimesView();
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: screenSize.width,
                      height: 10,
                    ),
                    const PickImageWidget(),
                    SizedBox(height: screenSize.height * .02),
                    Text(
                      'Create Doctor Account',
                      style: TextStyles.textStyle30.copyWith(
                          letterSpacing: 1, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: screenSize.height * .05),
                    CustomeTextField(
                      initialValue: cubit.registerModel.firstName ?? '',
                      hintText: 'First Name ...',
                      iconData: Icons.person,
                      onChanged: (value) =>
                          cubit.registerModel.firstName = value,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      hintText: 'Last Name ...',
                      iconData: Icons.person,
                      onChanged: (value) =>
                          cubit.registerModel.lastName = value,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      hintText: 'Email ...',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => cubit.registerModel.email = value,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      hintText: 'Password ...',
                      iconData: Icons.lock,
                      onChanged: (value) =>
                          cubit.registerModel.password = value,
                      obscureText: cubit.obscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          cubit.changePasswordState();
                        },
                        icon: Icon(
                          cubit.icon,
                          color: defaultColor,
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      obscureText: cubit.obscureText,
                      hintText: 'Confirm Password ...',
                      iconData: Icons.lock,
                      validator: (value) {
                        if (cubit.registerModel.password == null) {
                          return 'required';
                        } else {
                          if (value != cubit.registerModel.password) {
                            return "Passwords doesn't Match";
                          }
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      keyboardType: TextInputType.phone,
                      hintText: 'Phone ...',
                      iconData: Icons.phone,
                      onChanged: (value) =>
                          cubit.registerModel.phoneNum = value,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      disableFocusNode: true,
                      hintText: cubit.specialty ?? 'Specialty ...',
                      hintStyle: cubit.specialty != null
                          ? const TextStyle(color: Colors.black)
                          : null,
                      iconData: FontAwesomeIcons.stethoscope,
                      suffixIcon: const Icon(
                        Icons.expand_more_sharp,
                        size: 40,
                        color: defaultColor,
                      ),
                      validator: (value) {
                        if (cubit.specialty == null) {
                          return 'required';
                        }
                        return null;
                      },
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              content: SizedBox(
                                height: screenSize.height * .4,
                                child: Column(
                                  children: List.generate(
                                    cubit.specialties.length,
                                    (index) => SpecialityDialogButton(
                                      onTap: () {
                                        cubit.registerModel.specialty =
                                            cubit.specialties[index];
                                        cubit.selectSpecialty(
                                          specialty: cubit.specialties[index],
                                        );
                                        Navigator.pop(context);
                                      },
                                      specialty: cubit.specialties[index],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      hintText: 'Consulation Price ...',
                      keyboardType: TextInputType.number,
                      iconData: Icons.attach_money,
                      onChanged: (value) =>
                          cubit.registerModel.consulationPrice = value,
                    ),
                    SizedBox(height: screenSize.height * .05),
                    CustomeButton(
                      text: 'Next',
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.registerDoctor(token: token).then(
                            (value) {
                              Navigator.pushNamed(
                                context,
                                AddWorkTimesView.route,
                              );
                            },
                          );
                          //log('\nDoctor Imagggggge \n ${cubit.imageFile}');
                        }
                        // Navigator.pushNamed(
                        //   context,
                        //   AddWorkTimesView.route,
                        // );
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
