import 'package:market/features/employers/data/models/employer_model.dart';
import 'package:market/features/employers/domain/repositories/employers_repositories.dart';

class GetEmployersUseCase{
  late final  EmployersRepositories repositories;

  GetEmployersUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<List<EmployerModel>?> call() async{
    return await repositories.getEmployers();
  }
}