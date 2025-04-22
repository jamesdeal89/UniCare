class JournalEntry {
  String title;
  DateTime date;
  String description;
  final String id;
  
  final bool give;
  final bool takeNotice;
  final bool keepLearning;
  final bool beActive;
  final bool connect;

  JournalEntry({
    required this.title,
    required this.date,
    required this.description,
    String? id,
    this.give = false,
    this.takeNotice = false,
    this.keepLearning = false,
    this.beActive = false,
    this.connect = false,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(); 
} 