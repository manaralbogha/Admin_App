// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custome_image.dart';
import '../../../main.dart';
import '../manager/register_doctor_cubit.dart';

class PickImageWidget extends StatefulWidget {
  const PickImageWidget({super.key});

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
      },
      child: _image == null
          ? Stack(
              children: [
                CustomeImage(
                  image: AppAssets.registerDoctorImage,
                  width: screenSize.width * .51,
                  borderRadius: BorderRadius.circular(screenSize.width * .5),
                ),
                Positioned(
                  right: screenSize.width * .03,
                  bottom: screenSize.width * .01,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(.1),
                    radius: screenSize.width * .25,
                    child: Icon(
                      Icons.add,
                      size: screenSize.width * .55,
                      color: Colors.grey.withOpacity(.6),
                    ),
                  ),
                ),
              ],
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(screenSize.height * .2),
              child: Image.file(
                File(_image!),
                width: screenSize.height * .2,
                height: screenSize.height * .2,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    RegisterDoctorCubit cubit = BlocProvider.of<RegisterDoctorCubit>(context);
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: screenSize.height * .03),
          children: [
            const Text(
              'Pick Profile Piture',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenSize.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize:
                        Size(screenSize.width * .3, screenSize.height * .15),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    final XFile? image = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 80);
                    if (image != null) {
                      cubit.imageFile = File(image.path);

                      log('Image Path : ${image.path} -- Mime Type : ${image.mimeType}');

                      setState(() {
                        _image = image.path;
                      });

                      // APIs.updateProfilePicture(File(_image!));

                      //for hiding bottom sheet
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset(AppAssets.cameraImage),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize:
                        Size(screenSize.width * .3, screenSize.height * .15),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 80);
                    if (image != null) {
                      cubit.imageFile = File(image.path);
                      log('Image Path : ${image.path} -- Mime Type : ${image.mimeType}');

                      setState(() {
                        _image = image.path;
                      });

                      // APIs.updateProfilePicture(File(_image!));

                      //for hiding bottom sheet
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset(AppAssets.galleryImage),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
