
import 'package:market/features/employers/domain/repositories/employers_repositories.dart';

class DeleteEmployerUseCase{
  late final  EmployersRepositories repositories;

  DeleteEmployerUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(int id) async{
    return await repositories.deleteEmployer(id);
  }
}