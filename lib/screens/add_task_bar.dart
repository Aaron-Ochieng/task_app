// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:theme_changer/controller/task_controller.dart';
import 'package:theme_changer/models/task.dart';
import 'package:theme_changer/themes/styles.dart';
import 'package:theme_changer/widgets/input_field.dart';
import 'package:theme_changer/widgets/my_button.dart';

class AddtaskPage extends StatefulWidget {
  const AddtaskPage({super.key});

  @override
  State<AddtaskPage> createState() => _AddtaskPageState();
}

///Intialize task controller
final TaskConteroller _taskConteroller = Get.put(TaskConteroller());

final TextEditingController _titleController = TextEditingController();
final TextEditingController _noteController = TextEditingController();

DateTime _selectedDate = DateTime.now();
String _startTime = DateFormat('hh:mm  a').format(DateTime.now()).toString();
String _endTime = "8:30 PM";
int _selectedRemind = 5;
List<int> remindList = [5, 10, 15, 20];

String _selectedRepeat = 'None';
List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
int _selectedColor = 0;

class _AddtaskPageState extends State<AddtaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: Styles().headingStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              MyInputField(
                title: 'Title',
                hint: 'Enter your title',
                controller: _titleController,
              ),
              const SizedBox(
                height: 15,
              ),
              MyInputField(
                title: 'Note',
                hint: 'Enter your note',
                controller: _noteController,
              ),
              const SizedBox(
                height: 15,
              ),
              MyInputField(
                title: 'Date',
                hint: DateFormat.yMEd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Get.isDarkMode ? Colors.white : Colors.grey.shade500,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Get.isDarkMode
                              ? Colors.white
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Get.isDarkMode
                              ? Colors.white
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              MyInputField(
                title: 'Remind',
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRemind = int.parse(value!);
                    });
                  },
                  underline: Container(
                    height: 0,
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 25,
                    color: Get.isDarkMode ? Colors.white : Colors.grey.shade500,
                  ),
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              MyInputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: DropdownButton(
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRepeat = value!;
                    });
                  },
                  underline: Container(
                    height: 0,
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 25,
                    color: Get.isDarkMode ? Colors.white : Colors.grey.shade500,
                  ),
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallette(),
                  MyButton(
                    label: 'Create task',
                    onTap: _validateData,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
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

  _getDateFromUser() async {
    DateTime? _pickerdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (_pickerdate != null) {
      setState(() {
        _selectedDate = _pickerdate;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _timePicker();
    // ignore: use_build_context_synchronously
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      // ignore: avoid_print
      print('Time cancelled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _timePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _colorPallette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: Styles().titleStyle,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? Styles.primaryClr
                      : index == 1
                          ? Styles.pinkColor
                          : Styles.orangeColor,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 15,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      //Save to database;
      addTaskToDB();
      _titleController.clear();
      _noteController.clear();
      //Navigate back to homepage
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        'Required',
        'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey.shade200,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
        duration: const Duration(seconds: 3),
      );
    }
  }

//For submitting data to the controller
  addTaskToDB() async {
    int value = await _taskConteroller.addTask(
      //Passing the data to the model
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );

    // ignore: avoid_print
    print('Created task id $value');
  }
}
