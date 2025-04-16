import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/employers/data/models/employer_model.dart';
import 'package:market/features/employers/presentation/cubit/states.dart';
import 'package:market/global/global.dart';
import 'package:market/global/global_methods.dart';
import 'package:market/global/home_screen.dart';
import 'package:market/global/use_cases.dart';

import '../../../../global/widgets/show_toast.dart';

class EmployersCubit extends Cubit<EmployersStates> {
  EmployersCubit() : super(InitEmployersState());

  static EmployersCubit get(context) => BlocProvider.of(context);
  List<EmployerModel> employers = [];

  Future<void> getUsers() async {
    employers = await EmployersUseCases.getEmployersUseCase();

    emit(GetEmployersSuccessState());
  }

  Future<void> addEmployer(EmployerModel employer) async {
    EmployersUseCases.addEmployerUseCase(employer);
    getUsers();
    emit(AddEmployerSuccessState());
  }

  Future<void> editEmployer(EmployerModel employer) async {
    EmployersUseCases.updateEmployerUseCase(employer);
    getUsers();
    emit(AddEmployerSuccessState());
  }

  Future<void> deleteEmployer(int id,context) async {
    bool? insuring=await insureDialog(context, 'هل انت متاكد تريد حذف هذا المستخدم؟');
    if(insuring==true){
      EmployersUseCases.deleteEmployerUseCase(id);
    }
    getUsers();
  }

  Future<void> logIn(String userName, String pass, context) async {
    EmployerModel employerModel = employers.singleWhere(
      (element) => element.username == userName,
    );
    if (employerModel.password == pass) {
      isAdmin = employerModel.position == 'admin';
      navigateAndFinish(context, const HomeScreen());
      startDateTime = DateTime.now();
    } else {
      showToast(
        context: context,
        msg: 'password is not true',
      );
    }
  }
}
