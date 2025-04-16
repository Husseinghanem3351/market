import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/features/employers/data/models/employer_model.dart';
import 'package:market/features/employers/presentation/cubit/cubit.dart';
import 'package:market/global/widgets/default_button.dart';
import 'package:market/global/widgets/default_text_form_field.dart';

class EditUser extends StatelessWidget {
  const EditUser({super.key,required this.employerModel});
  final EmployerModel employerModel;


  @override
  Widget build(BuildContext context) {
     TextEditingController nameController = TextEditingController(text: employerModel.name);
     TextEditingController userNameController = TextEditingController(text: employerModel.username);
     TextEditingController passwordController = TextEditingController(text: employerModel.password);
     TextEditingController goalAmountController = TextEditingController(text: employerModel.goalAmount.toString());
     TextEditingController salaryController = TextEditingController(text: employerModel.salary.toString());
     String position = employerModel.position!;
    return Scaffold(
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
                  labelText: 'هدف البيع',
                ),
                DefaultFormField(
                  controller: salaryController,
                  labelText: 'الراتب',
                ),
                DropdownMenu(
                  hintText: 'نوع المستخدم',
                  initialSelection: position,
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
                        id: employerModel.id,
                        username: userNameController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        goalAmount: double.parse(goalAmountController.text),
                        position: position,
                        salary: double.parse(salaryController.text),
                      );
                      EmployersCubit.get(context).editEmployer(employer);
                      Navigator.pop(context);
                    },
                    textBtn: 'تعديل المستخدم',
                    textStyle:const TextStyle(fontWeight: FontWeight.bold),
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
