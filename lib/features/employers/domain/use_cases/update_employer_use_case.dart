import 'package:market/features/employers/data/models/employer_model.dart';
import 'package:market/features/employers/domain/repositories/employers_repositories.dart';

class UpdateEmployerUseCase{
  late final  EmployersRepositories repositories;

  UpdateEmployerUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(EmployerModel employer) async{
    return await repositories.updateEmployer(employer);
  }
}