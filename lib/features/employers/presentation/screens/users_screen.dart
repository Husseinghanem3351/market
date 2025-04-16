import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/employers/presentation/cubit/cubit.dart';
import 'package:market/features/employers/presentation/cubit/states.dart';
import 'package:market/features/employers/presentation/screens/add_user.dart';
import 'package:market/features/employers/presentation/widgets/user_widget.dart';
import 'package:market/global/global_methods.dart';
import '../../../../global/widgets/default_button.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployersCubit, EmployersStates>(
      builder: (BuildContext context, EmployersStates state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                DefaultButton(
                  onPressed: () {
                    navigateTo(context, const AddUser(),);
                  },
                  textBtn: 'اضافة مستخدم',
                )
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => UserWidget(
                        employerModel:
                            EmployersCubit.get(context).employers[index],
                      ),
                      separatorBuilder: (context, index) => Divider(
                        height: 10,
                        color: Colors.grey.withOpacity(.2),
                      ),
                      itemCount: EmployersCubit.get(context).employers.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
