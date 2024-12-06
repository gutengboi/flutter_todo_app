import 'package:flutter_todo_app/db/db_helper.dart';
import 'package:get/get.dart';

import '../models/task.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);
  }

  void getTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }
  void delete(Task task){
    DBHelper.delete(task);
  }
}