import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/employers/presentation/cubit/cubit.dart';
import 'package:market/features/employers/presentation/cubit/states.dart';
import 'package:market/global/widgets/default_button.dart';
import 'package:market/global/widgets/default_text_form_field.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  static TextEditingController passController = TextEditingController();
  static String username = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployersCubit, EmployersStates>(
      builder: (BuildContext context, EmployersStates state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  DropdownMenu(
                    hintText: 'اختر اسم المستخدم',
                    dropdownMenuEntries: List.generate(
                      EmployersCubit.get(context).employers.length,
                      (index) => DropdownMenuEntry(
                        value:
                            EmployersCubit.get(context).employers[index].username,
                        label:
                            EmployersCubit.get(context).employers[index].username,
                      ),
                    ),
                    onSelected: (value) {
                      username = value ?? username;
                    },
                  ),
                  DefaultFormField(
                    maxLines: 1,
                    controller: passController,
                    hintText: 'كلمة السر',
                    obscureText: true,
                  ),
                  DefaultButton(
                    color: Colors.grey,
                    onPressed: () {
                      EmployersCubit.get(context).logIn(
                        username,
                        passController.text,
                        context,
                      );
                    },
                    textBtn:'تسجيل',
                  )
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
