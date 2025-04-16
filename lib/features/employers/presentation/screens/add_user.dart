import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/features/employers/data/models/employer_model.dart';
import 'package:market/features/employers/presentation/cubit/cubit.dart';
import 'package:market/global/widgets/default_button.dart';
import 'package:market/global/widgets/default_text_form_field.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  static TextEditingController nameController = TextEditingController();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController goalAmountController = TextEditingController();
  static TextEditingController salaryController = TextEditingController();
  static String position = 'user';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SizedBox(
              width: 250,
              child: Column(
                children: [
                  DefaultFormField(
                    controller: userNameController,
                    labelText: 'اسم المستخدم',
                  ),
                  DefaultFormField(
                    controller: nameController,
                    labelText: 'الاسم',
                  ),
                  DefaultFormField(
                    controller: passwordController,
                    labelText: 'كلمة السر',
                  ),
                  DefaultFormField(
                    controller: goalAmountController,
                    labelText: 'الهدف',
                  ),
                  DefaultFormField(
                    controller: salaryController,
                    labelText: 'الراتب',
                  ),
                  DropdownMenu(
                    hintText: 'نوع المستخدم',
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'admin', label: 'admin'),
                      DropdownMenuEntry(value: 'user', label: 'user'),
                    ],
                    onSelected: (value) {
                      position = value ?? 'user';
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultButton(
                      onPressed: () {
                        EmployerModel employer = EmployerModel(
                          username: userNameController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          goalAmount: double.parse(goalAmountController.text),
                          position: position,
                          salary: double.parse(salaryController.text),
                        );
                        EmployersCubit.get(context).addEmployer(employer);
                        Navigator.pop(context);
                      },
                      textBtn: 'اضافة المستخدم',
                      textStyle:const TextStyle(fontWeight: FontWeight.bold),
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
