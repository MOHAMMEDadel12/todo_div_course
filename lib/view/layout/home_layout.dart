// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_is_empty
import 'package:flutter/material.dart';
import 'package:todoapp/core/shared_widget/custom_form_field.dart';
import 'package:todoapp/logic/app_logic.dart';
import 'package:todoapp/view/archived_screen.dart';
import 'package:todoapp/view/done_screen.dart';
import 'package:todoapp/view/task_screen.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  int currentIndex = 0;

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  bool isDark = false;
  changeColorMode() {
    isDark = !isDark;
    setState(() {});
  }

  List<Widget> screens = [TaskScreen(), DoneScreen(), ArchivedScreen()];

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    setState(() {});
  }

  @override
  void initState() {
    AppLogic.createDatabase();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var name = 10;
    name = 10;

    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Add Task"),
          onPressed: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text(
                              'Add New Task',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomFormField(
                                controller: titleController,
                                type: TextInputType.text,
                                isClickable: true,
                                onTap: () {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This Field Must Not Empty';
                                  }
                                  return null;
                                },
                                labelText: "Task Title",
                                prefixIcon: Icons.title),
                            SizedBox(
                              height: 15.0,
                            ),
                            CustomFormField(
                                isClickable: true,
                                onTap: () async {
                                  await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                                controller: timeController,
                                type: TextInputType.none,
                                showCursor: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This Field Must Not Empty';
                                  }
                                  return null;
                                },
                                labelText: 'Task Time',
                                prefixIcon: Icons.watch_later_outlined),
                            SizedBox(
                              height: 15.0,
                            ),
                            CustomFormField(
                                isClickable: true,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                  ).then((value) {
                                    print(value);

                                    // DateFormat.yMMMMEEEEd().format(value);

                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                controller: dateController,
                                type: TextInputType.none,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This Field Must Not Empty';
                                  }
                                  return null;
                                },
                                labelText: 'Task Date',
                                prefixIcon: Icons.calendar_today_outlined),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: MaterialButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        await AppLogic.insertToDatabase(
                                            title: titleController.text,
                                            date: dateController.text,
                                            time: timeController.text);
                                        // add task to database
                                        //// todo
                                        Navigator.pop(context);
                                        titleController.clear();
                                        timeController.clear();
                                        dateController.clear();

                                        setState(() {});
                                      }
                                    },
                                    child: Text(
                                      'Add Task',
                                      style: TextStyle(color: Colors.white),
                                    ))),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            selectedItemColor: Colors.red,
            onTap: (index) {
              currentIndex = index;
              print(currentIndex);
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline), label: 'Done'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: 'Archived'),
            ]),
        body: screens[currentIndex]);
  }
}
