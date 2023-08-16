import 'package:flutter/material.dart';
import 'custome_image.dart';
import 'custome_text_info.dart';

class ExpertListViewItem extends StatelessWidget {
  final void Function()? onPressed;
  const ExpertListViewItem({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onPressed,
        child: Row(
          children: [
            CustomeImage(
              image: 'assets/images/expert_image2.jpg',
              width: MediaQuery.of(context).size.height * .09,
              height: MediaQuery.of(context).size.height * .09,
              borderRadius: BorderRadius.circular(40),
            ),
            const SizedBox(width: 20),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomeTextInfo(
                  text: 'Abudllah',
                  iconData: Icons.location_history,
                ),
                CustomeTextInfo(
                  iconData: Icons.email,
                  text: 'abdullah.h.nah@gmail.com',
                ),
                CustomeTextInfo(
                  text: '+963994573075',
                  iconData: Icons.phone,
                ),
                CustomeTextInfo(
                  text: 'Midan',
                  iconData: Icons.location_on,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
