import 'package:market/features/employers/data/models/employer_model.dart';
import 'package:market/features/employers/domain/repositories/employers_repositories.dart';

class AddEmployerUseCase{
  late final EmployersRepositories repositories;

  AddEmployerUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(EmployerModel employers) async{
    return await repositories.addEmployer(employers);
  }
}