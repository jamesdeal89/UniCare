import 'package:team_31_health_app/data/database_fields/data_model.dart';

class JournalEntry implements DataModel {
  String title;
  DateTime date;
  String description;
  final int? id;
  
  final bool give;
  final bool takeNotice;
  final bool keepLearning;
  final bool beActive;
  final bool connect;

  JournalEntry({
    required this.title,
    required this.date,
    required this.description,
    this.id,
    this.give = false,
    this.takeNotice = false,
    this.keepLearning = false,
    this.beActive = false,
    this.connect = false,
  });

  @override
  Map<String, Object?> toMap() {
    final map = {
      'title': title,
      'date': date.toIso8601String(), 
      'description': description,
      'give': give ? 1 : 0,
      'takeNotice': takeNotice ? 1 : 0,
      'keepLearning': keepLearning ? 1 : 0,
      'beActive': beActive ? 1 : 0,
      'connect': connect ? 1 : 0,
    };
    
    if (id != null) {
      map['id'] = id as Object;
    }
    
    return map;
  }

  @override
  String toString() {
    return 'JournalEntry{id: $id, title: $title, date: $date, description: $description, give: $give, takeNotice: $takeNotice, keepLearning: $keepLearning, beActive: $beActive, connect: $connect}';
  }


  static JournalEntry fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      id: map['id'] as int?,
      title: map['title'] as String,
      date: DateTime.parse(map['date'] as String), 
      description: map['description'] as String,
      give: map['give'] == 1,
      takeNotice: map['takeNotice'] == 1,
      keepLearning: map['keepLearning'] == 1,
      beActive: map['beActive'] == 1,
      connect: map['connect'] == 1,
    );
  }
} 