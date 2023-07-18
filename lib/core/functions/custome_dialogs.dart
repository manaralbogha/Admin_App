import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_one_admin_app/core/styles/text_styles.dart';
import 'package:project_one_admin_app/main.dart';

abstract class CustomeDialogs {
  // static showSpecialityDialog(BuildContext context) {
  // showDialog(
  //   context: context,
  //   builder: (context) {
  //     return AlertDialog(
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //       content: SizedBox(
  //         height: screenSize.height * .4,
  //         child: Column(
  //           children: [
  //             SpecialityDialogButton(
  //               onTap: () {},
  //               specialty: '1',
  //             ),
  //             SpecialityDialogButton(
  //               onTap: () {},
  //               specialty: '2',
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   },
  // );
  // }

  // static showTimesDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         content: SizedBox(
  //           height: screenSize.height * .4,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Row(
  //                 children: [
  //                   timeDialogButton(context, time: '10:00 AM'),
  //                   SizedBox(width: screenSize.width * .05),
  //                   timeDialogButton(context, time: '04:00 PM'),
  //                 ],
  //               ),
  //               SizedBox(height: screenSize.height * .009),
  //               Row(
  //                 children: [
  //                   timeDialogButton(context, time: '11:00 AM'),
  //                   SizedBox(width: screenSize.width * .05),
  //                   timeDialogButton(context, time: '05:00 PM'),
  //                 ],
  //               ),
  //               SizedBox(height: screenSize.height * .009),
  //               Row(
  //                 children: [
  //                   timeDialogButton(context, time: '12:00 PM'),
  //                   SizedBox(width: screenSize.width * .05),
  //                   timeDialogButton(context, time: '06:00 PM'),
  //                 ],
  //               ),
  //               SizedBox(height: screenSize.height * .009),
  //               Row(
  //                 children: [
  //                   timeDialogButton(context, time: '01:00 PM'),
  //                   SizedBox(width: screenSize.width * .05),
  //                   timeDialogButton(context, time: '07:00 PM'),
  //                 ],
  //               ),
  //               SizedBox(height: screenSize.height * .009),
  //               Row(
  //                 children: [
  //                   timeDialogButton(context, time: '02:00 PM'),
  //                   SizedBox(width: screenSize.width * .05),
  //                   timeDialogButton(context, time: '08:00 PM'),
  //                 ],
  //               ),
  //               SizedBox(height: screenSize.height * .009),
  //               Row(
  //                 children: [
  //                   timeDialogButton(context, time: '03:00 PM'),
  //                   SizedBox(width: screenSize.width * .05),
  //                   timeDialogButton(context, time: '09:00 PM'),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  static Widget timeDialogButton(
    BuildContext context, {
    required void Function() onTap,
    required String time,
    // required String value,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              time,
              style: TextStyles.textStyle20,
            ),
          ),
        ),
      ),
    );
  }
}

class SpecialityDialogButton extends StatelessWidget {
  final void Function() onTap;
  final String specialty;
  const SpecialityDialogButton(
      {super.key, required this.onTap, required this.specialty});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            width: screenSize.width * .6,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                specialty,
                style: TextStyles.textStyle20,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}

// class TimeDialogButton extends StatelessWidget {
//   final String time;
//   final String? value;
//   // final void Function() onTap;
//   const TimeDialogButton({super.key, required this.time, this.value});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(10),
//       onTap: () {},
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             time,
//             style: TextStyles.textStyle20,
//           ),
//         ),
//       ),
//     );
//   }
// }
