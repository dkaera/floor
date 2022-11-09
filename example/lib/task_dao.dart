
import 'dart:async';

import 'package:example/task.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart';

@dao
abstract class TaskDao {
  DatabaseExecutor get executor;

  StreamController<String> get updateListener;

  @Query('SELECT * FROM task WHERE id = :id')
  Future<Task?> findTaskById(int id);

  Future<void> rawFunction() => executor
      .rawInsert('SELECT * FROM task WHERE id = :id')
      .then((_) => updateListener.add('rawInsert'));

  @Query('SELECT * FROM task')
  Future<List<Task>> findAllTasks();

  @Query('SELECT * FROM task')
  Stream<List<Task>> findAllTasksAsStream();

  @Query('SELECT * FROM task WHERE type = :type')
  Stream<List<Task>> findAllTasksByTypeAsStream(TaskType type);

  @insert
  Future<void> insertTask(Task task);

  @insert
  Future<void> insertTasks(List<Task> tasks);

  @update
  Future<void> updateTask(Task task);

  @update
  Future<void> updateTasks(List<Task> task);

  @delete
  Future<void> deleteTask(Task task);

  @delete
  Future<void> deleteTasks(List<Task> tasks);
}
