class Task {
   String? title;
   String? description;
   int? date;
   int? time;
   String? id;
   bool? isDone;
   bool? isToggled;

  Task(
      {required this.title,
       this.description,
       this.date,
       this.time,
       this.id,
      this.isDone = false
        ,this.isToggled= false
      });

  Task.fromFireStore(Map<String, dynamic>? data):
       this(
        title: data?['title'],
        description: data?['description'],
        date: data?['date'],
        time: data?['time'],
        id: data?['id'],
        isToggled: data?['isToggled']
      );


  Map<String, dynamic> toFireStore() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'id': id,
       'isToggled': isToggled
    };
  }
}
