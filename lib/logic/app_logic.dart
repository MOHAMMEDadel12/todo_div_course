import 'package:sqflite/sqflite.dart';

class AppLogic {
  static late Database database;

  static List<Map<String, dynamic>> todoTasks = [];
  static List<Map<String, dynamic>> doneTasks = [];
  static List<Map<String, dynamic>> archivedTasks = [];

  static Future<void> createDatabase() async {  
    database = await openDatabase("todo.db", version: 1,
        onCreate: (Database db, int version) async {
      print("database created");
      await db
          .execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT , status TEXT)")
          .then(
        (value) {
          print("table created");
        },
      );
    }, onOpen: (Database db) {

      database = db;
      print("database opened");
      getTasksFromDatabase();
    });
  }

  static insertToDatabase(

      {required String title,
      required String time,
      required String date}) async {
    await database.transaction((txn) async {
      

      await txn

          .rawInsert(
              'INSERT INTO tasks(title, time, date , status) VALUES("$title","$time", "$date" ,"TODO" )')
          .then((primaryKey) {
            getTasksFromDatabase();
        print("primaryKey $primaryKey");
        print("TASK INSERTED");
      }).catchError((e) {
        print(e.toString());
      });
    });
  }

  static getTasksFromDatabase() async {
    await database.rawQuery('SELECT * FROM tasks').then((list) {
      for (int i = 0; i < list.length; i++) {
        if (list[i]["status"] == "TODO") {
          todoTasks.add(list[i]);
        } else if (list[i]["status"] == "DONE") {
          doneTasks.add(list[i]);
        } else {
          archivedTasks.add(list[i]);
        }
      }

      print("get tasks succses");
      print(todoTasks);
            print(doneTasks);
      print(archivedTasks);

    });
  }

  static deleteFromDatabase(int id ) async {
    // Delete a record
await database

    .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      getTasksFromDatabase();

      print("valuuuuuuuuuuuuuuuuuuuuuuuuuuuu $value");

    });
  }

  static updateTaskStatusInDatabase(int id, String status) async {
    // Update task status
    await database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]);
  }
}
