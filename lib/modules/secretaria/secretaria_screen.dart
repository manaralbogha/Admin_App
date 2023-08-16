import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../styles/colors/colors.dart';
import '../../widgets/component.dart';
import '../../widgets/secretaria_list_view_item.dart';
import '../register_secretaria/register_secretaria_screen.dart';

class SecretariaScreen extends StatelessWidget {
  const SecretariaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is MedManageErrorSecretariaListState) {
          return Scaffold(
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateAndReplacement(context, RegisterSecretaria());
              },
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
            body: const Center(
              child: Text(
                'There is some thing error',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        }
        if (state is MedManageLoadingSecretariaListState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SecretariaListViewItem(
            context,
            profImage: 'assets/images/default_photo.jpg',
            model: MedManageCubit.get(context).indexSecretariaModel,
          );
        }
      },
    );
  }
}
