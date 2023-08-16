import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../widgets/edit_secretaria_prof_item.dart';

class EditSecretariaProfScreen extends StatelessWidget {

  final int? index;

  const EditSecretariaProfScreen({
    super.key,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is MedManageErrorSecretariaProfEditState)
        {
          return const Center(
            child: Text(
              'There is some thing error',
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }else
        {
          return ConditionalBuilder(
            condition: state is! MedManageLoadingSecretariaProfEditState,
            builder: (context) => EditSecretariaProfItem(
              model: MedManageCubit.get(context).viewSecretariaModel,
              modelIn: MedManageCubit.get(context).indexSecretariaModel,
              index: index,
            ),
            fallback: (context) => Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
