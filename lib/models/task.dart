class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.color,
    this.date,
    this.endTime,
    this.startTime,
    this.isCompleted,
    this.remind,
    this.repeat,
  });

//converting data from json format
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    color = json['color'];
    date = json['date'];
    endTime = json['endTime'];
    startTime = json['startTime'];
    isCompleted = json['isCompleted'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  //Converting Data to json format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['color'] = color;
    data['date'] = date;
    data['endTime'] = endTime;
    data['startTime'] = startTime;
    data['isCompleted'] = isCompleted;
    data['remind'] = remind;
    data['repeat'] = repeat;
    return data;
  }
}
