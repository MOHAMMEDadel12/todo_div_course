import 'package:flutter/material.dart';
import 'package:todoapp/logic/app_logic.dart';

class BuildTaskItem extends StatelessWidget {

  final Map<String , dynamic> task ; 




  const BuildTaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task["id"].toString()),
      onDismissed: (direction) {
        AppLogic.deleteFromDatabase(task["id"]);

        
      },
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
             CircleAvatar(
              radius: 50.0,
              child: Text("${task["time"]}"),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${task["title"]}',
                  maxLines: 3,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${task["date"]}',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            )),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {


                AppLogic.updateTaskStatusInDatabase(task["id"], "DONE");
              },
              icon: Icon(Icons.check_box, color: Colors.green),
            ),
            IconButton(
                onPressed: () {
                AppLogic.updateTaskStatusInDatabase(task["id"], "Archived");
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black45,
                )),
          ],
        ),
      ),
    );
  }
}