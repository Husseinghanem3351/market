import 'package:market/global/database.dart';
import '../models/employer_model.dart';

abstract class EmployersLocalDataSource {
  Future<void> addEmployer(EmployerModel employer);

  Future<void> deleteEmployer(int id);

  Future<void> updateEmployer(EmployerModel employer);

  Future<List<EmployerModel>?> getEmployers();
}

class EmployersLocalDataSourceImplementation
    implements EmployersLocalDataSource {
  @override
  Future<void> addEmployer(EmployerModel employer) async {
    try {
      await database.transaction(
        (txn) => txn.insert(
          'employers',
          employer.toJson(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deleteEmployer(int id) async {
    try {
      await database.rawDelete('delete from employers where id = $id');
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<EmployerModel>?> getEmployers() async {
    try {
      final value = await database.rawQuery('select * from employers');
      return value.map<EmployerModel>((e) {
            return EmployerModel.fromJson(e);
          }).toList();
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<void> updateEmployer(EmployerModel employer) async {
    try {
      await database.rawUpdate('update employers set '
          'salary= ${employer.salary},'
          'name="${employer.name}",'
          'position="${employer.position}",'
          'password="${employer.password}",'
          'goalAmount= ${employer.goalAmount},'
          'userName="${employer.username}" '
          'where id = ${employer.id}');
    } catch (error) {
      print(error);
    }
  }
}
