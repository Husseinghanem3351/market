
import '../../data/models/employer_model.dart';

abstract class EmployersRepositories {
  Future<void> deleteEmployer(int id);
  Future<void> addEmployer(EmployerModel customerModel);
  Future<void> updateEmployer(EmployerModel customerModel);
  Future<List<EmployerModel>?> getEmployers();

}