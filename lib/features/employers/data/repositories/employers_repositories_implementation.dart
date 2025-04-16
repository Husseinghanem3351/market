import 'package:market/features/employers/data/data_sources/employers_local_data_source.dart';
import 'package:market/features/employers/data/models/employer_model.dart';
import 'package:market/features/employers/domain/repositories/employers_repositories.dart';

class EmployersRepositoriesImplementation implements EmployersRepositories {
  final EmployersLocalDataSource employersLocalDataSource =
      EmployersLocalDataSourceImplementation();

  @override
  Future<void> addEmployer(EmployerModel employerModel) async {
    await employersLocalDataSource.addEmployer(employerModel);
  }

  @override
  Future<void> deleteEmployer(int id) async {
    await employersLocalDataSource.deleteEmployer(id);
  }

  @override
  Future<List<EmployerModel>?> getEmployers() async {
    return await employersLocalDataSource.getEmployers();
  }

  @override
  Future<void> updateEmployer(EmployerModel employerModel) async {
    await employersLocalDataSource.updateEmployer(employerModel);
  }
}
