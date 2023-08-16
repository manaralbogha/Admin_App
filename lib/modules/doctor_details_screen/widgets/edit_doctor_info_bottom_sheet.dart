import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/doctor_model.dart';
import '../../../core/widgets/custome_button.dart';
import '../../../core/widgets/custome_text_field.dart';
import '../../../main.dart';
import '../../register_doctor_screen/widgets/pick_image_widget.dart';
import '../manager/doctor_details_cubit.dart';

abstract class EditDoctorInfoBottomSheet {
  static void editDoctorInfoBottomSheet(
    BuildContext context, {
    required DoctorModel doctorModel,
    required DoctorDetailsCubit cubit,
  }) {
    final formKey = GlobalKey<FormState>();
    bool change = false;

    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    height: 4,
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * .015,
                        horizontal: screenSize.width * .4),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: PickImageWidget(
                      image: doctorModel.imagePath,
                      detailsCubit: cubit,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomeTextField(
                    iconData: Icons.phone,
                    initialValue: doctorModel.user.phoneNum,
                    keyboardType: TextInputType.phone,
                    onChanged: (p0) {
                      cubit.phoneNum = p0;
                      change = true;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomeTextField(
                    iconData: Icons.attach_money,
                    initialValue: '${doctorModel.consultationPrice}',
                    keyboardType: TextInputType.number,
                    onChanged: (p0) {
                      cubit.consultationPrice = p0;
                      change = true;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomeTextField(
                    iconData: Icons.description,
                    initialValue: doctorModel.description,
                    onChanged: (p0) {
                      cubit.description = p0;
                      change = true;
                    },
                  ),
                  SizedBox(height: 40.h),
                  CustomeButton(
                    text: 'Update',
                    onPressed: () async {
                      if (!change && cubit.doctorImage == null) {
                        Navigator.pop(context);
                      } else if (formKey.currentState!.validate() &&
                          (change || cubit.doctorImage != null)) {
                        Navigator.pop(context);
                        DoctorModel update = DoctorModel(
                            id: doctorModel.id,
                            specialty: doctorModel.specialty,
                            description:
                                cubit.description ?? doctorModel.description,
                            imagePath:
                                cubit.doctorImage ?? doctorModel.imagePath,
                            departmentID: doctorModel.departmentID,
                            consultationPrice: cubit.consultationPrice == null
                                ? doctorModel.consultationPrice
                                : int.parse(cubit.consultationPrice!),
                            review: doctorModel.review,
                            userID: doctorModel.userID,
                            user: doctorModel.user);

                        await cubit.updateDoctorDetails(context,
                            doctorModel: update);
                        log(cubit.doctorImage ?? 'null');
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
