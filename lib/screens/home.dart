// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:theme_changer/controller/notification_controller.dart';
import 'package:theme_changer/controller/task_controller.dart';
import 'package:theme_changer/models/task.dart';
import 'package:theme_changer/screens/add_task_bar.dart';
import 'package:theme_changer/services/theme_service.dart';
import 'package:intl/intl.dart';
import 'package:theme_changer/themes/styles.dart';
import 'package:theme_changer/widgets/bottom_sheet_button.dart';
import 'package:theme_changer/widgets/my_button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:theme_changer/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final NotificationService service;
  final _taskcontroller = Get.put(TaskConteroller());
  DateTime _selectedDate = DateTime.now();
  final store = GetStorage();
  final key = 'isDarkMode';

  bool dark = false;

  @override
  void initState() {
    service = NotificationService();
    service.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Column(
        children: [
          _addTaskBar(),
          const SizedBox(
            height: 10,
          ),
          _dateBar(),
          const SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _appbar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () async {
          await service.showNotification(
            id: 0,
            title: 'Theme Changed',
            body: Get.isDarkMode
                ? 'Activated Light theme'
                : 'Activated Dark theme',
          );
          // await service.scheduledNotification(
          //   body: 'Theme changed 5 seconds ago',
          //   title: 'Theme changed',
          // );
          ThemeService().changeTheme();
          setState(() {
            dark = store.read('isDarkMode');
          });
        },
        icon: dark
            ? const Icon(
                Icons.nightlight_round_sharp,
                size: 25,
                color: Colors.yellow,
              )
            : const Icon(
                Icons.light_mode,
                size: 25,
                color: Colors.yellow,
              ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 10,
          child: Icon(Icons.person, color: Colors.grey.shade500),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Styles().subHeadingStyle,
              ),
              Text('Today', style: Styles().headingStyle)
            ],
          ),
          MyButton(
              label: 'Add Task',
              onTap: () async {
                await Get.to(() => const AddtaskPage());
                _taskcontroller.getTasks();
              })
        ],
      ),
    );
  }

  _dateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: DatePicker(
        DateTime.now(),
        height: 80,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Styles.primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: Styles().dateTextStyle,
        dayTextStyle: Styles().dayTextStyle,
        monthTextStyle: Styles().monthTextStyle,
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          // physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: _taskcontroller.taskList.length,
          itemBuilder: (_, index) {
            Task task = _taskcontroller.taskList[index];
            if (task.repeat == 'Daily') {
              DateTime date = DateFormat.jm().parse(task.startTime.toString());
              var myTime = DateFormat('HH:mm').format(date);
              service.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]),
                int.parse(myTime.toString().split(":")[1]),
                task,
              );
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    duration: const Duration(seconds: 1),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(
                            task: task,
                          ),
                          // child: TaskTile(_taskcontroller.taskList[index]),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }

            if (task.date == DateFormat.yMd().format(_selectedDate)) {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(
                            task: task,
                          ),
                          // child: TaskTile(_taskcontroller.taskList[index]),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }

  Future<void> _showBottomSheet(BuildContext context, Task task) {
    var h = MediaQuery.of(context).size.height;
    return Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1 ? h * 0.24 : h * 0.32,
      color: Get.isDarkMode ? Styles.bgColor : Colors.white,
      child: Column(children: [
        Container(
          height: 6,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        task.isCompleted == 1
            ? Container()
            : BottomSheetButton(
                label: 'Task Completed',
                onTap: () {
                  _taskcontroller.taskCompleted(task.id!);
                  Get.back();
                },
                clr: Styles.primaryClr,
                context: context,
              ),
        BottomSheetButton(
          label: 'Delete Task',
          onTap: () {
            _taskcontroller.delete(task);
            Get.back();
          },
          clr: Colors.red.shade300,
          context: context,
        ),
        BottomSheetButton(
          label: 'Close',
          onTap: () {
            Get.back();
          },
          clr: const Color.fromARGB(255, 100, 93, 93),
          context: context,
          close: true,
        )
      ]),
    ));
  }
}
