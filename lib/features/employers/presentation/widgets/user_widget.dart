import 'package:flutter/material.dart';
import 'package:market/features/employers/presentation/cubit/cubit.dart';
import 'package:market/features/employers/presentation/screens/edit_user.dart';
import 'package:market/global/global_methods.dart';

import '../../data/models/employer_model.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.employerModel});

  final EmployerModel employerModel;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onDoubleTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(employerModel.position!='admin')
                IconButton(
                    onPressed: () {
                      EmployersCubit.get(context).deleteEmployer(
                        employerModel.id!,
                        context,
                      );
                    },

                    icon: const Icon(
                      Icons.delete,
                    )),
                IconButton(
                    onPressed: () {
                      navigateTo(context, EditUser(employerModel: employerModel));
                    },

                    icon: const Icon(
                      Icons.edit,
                    )),

                const Text('اسم المستخدم: '),
                Text(employerModel.username),
                const Text('الاسم:'),
                Text(employerModel.name),
                const Text('هدف البيع:'),
                Text('${employerModel.goalAmount}'),
                const Text('الراتب:'),
                Text('${employerModel.salary}'),
                const Text('كلمة السر:'),
                Text(' ${employerModel.password}'),
                const Text('نوع المستخدم:'),
                Text('${employerModel.position}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
