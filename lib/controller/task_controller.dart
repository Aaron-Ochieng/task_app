import 'package:get/get.dart';
import 'package:theme_changer/db/db_helper.dart';
import 'package:theme_changer/models/task.dart';

class TaskConteroller extends GetxController {
  var taskList = <Task>[].obs;
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  //get all the data from the database
  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  Future<void> delete(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  Future<void> taskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
