import 'package:flutter/material.dart';
import 'package:team_31_health_app/data/database_fields/journalEntry.dart';

class AddEditEntryPage extends StatefulWidget {
  final JournalEntry? entryToEdit;

  const AddEditEntryPage({super.key, this.entryToEdit});

  @override
  State<AddEditEntryPage> createState() => _AddEditEntryPageState();
}

class _AddEditEntryPageState extends State<AddEditEntryPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  bool _isEditing = false;

  bool _give = false;
  bool _takeNotice = false;
  bool _keepLearning = false;
  bool _beActive = false;
  bool _connect = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.entryToEdit != null;

    _titleController = TextEditingController(text: _isEditing ? widget.entryToEdit!.title : '');
    _descriptionController = TextEditingController(text: _isEditing ? widget.entryToEdit!.description : '');
    _selectedDate = _isEditing ? widget.entryToEdit!.date : DateTime.now();

    if (_isEditing) {
      _give = widget.entryToEdit!.give;
      _takeNotice = widget.entryToEdit!.takeNotice;
      _keepLearning = widget.entryToEdit!.keepLearning;
      _beActive = widget.entryToEdit!.beActive;
      _connect = widget.entryToEdit!.connect;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      final resultEntry = JournalEntry(
        id: _isEditing ? widget.entryToEdit!.id : null,
        title: _titleController.text,
        date: _selectedDate,
        description: _descriptionController.text,
        give: _give,
        takeNotice: _takeNotice,
        keepLearning: _keepLearning,
        beActive: _beActive,
        connect: _connect,
      );

      Navigator.pop(context, resultEntry);
    }
  }

  void _showInfoPopup(String option) {
    String infoText;
    
    switch(option) {
      case 'Give':
        infoText = 'Research suggests that acts of giving and kindness can help improve your mental wellbeing by:\n\n'
                  '• creating positive feelings and a sense of reward\n'
                  '• giving you a feeling of purpose and self-worth\n'
                  '• helping you connect with other people\n\n'
                  'It could be small acts of kindness towards other people, or larger ones like volunteering in your local community.\n\n'
                  'Some examples of the things you could try include:\n\n'
                  '• saying thank you to someone for something they have done for you\n'
                  '• asking friends, family or colleagues how they are and really listening to their answer\n'
                  '• spending time with friends or relatives who need support or company\n'
                  '• offering to help someone you know with DIY or a work project\n'
                  '• volunteering in your community, such as helping at a school, hospital or care home';
        break;
      case 'Take Notice':
        infoText = 'Paying more attention to the present moment can improve your mental wellbeing. This includes your thoughts and feelings, your body and the world around you.\n\n'
                  'Some people call this awareness "mindfulness". Mindfulness can help you enjoy life more and understand yourself better. It can positively change the way you feel about life and how you approach challenges.';
        break;
      case 'Keep Learning':
        infoText = 'Research shows that learning new skills can also improve your mental wellbeing by:\n\n'
                  '• boosting self-confidence and raising self-esteem\n'
                  '• helping you to build a sense of purpose\n'
                  '• helping you to connect with others\n\n'
                  'Even if you feel like you do not have enough time, or you may not need to learn new things, there are lots of different ways to bring learning into your life.\n\n'
                  'Some of the things you could try include:\n\n'
                  '• try learning to cook something new\n'
                  '• try taking on a new responsibility at work\n'
                  '• work on a DIY project\n'
                  '• consider signing up for a course at a local college\n'
                  '• try new hobbies that challenge you\n\n'
                  'Don\'t feel you have to learn new qualifications or sit exams if this does not interest you. It\'s best to find activities you enjoy and make them a part of your life';
        break;
      case 'Be Active':
        infoText = 'Being active is not only great for your physical health and fitness. Evidence also shows it can also improve your mental wellbeing by:\n\n'
                  '• raising your self-esteem\n'
                  '• helping you to set goals or challenges and achieve them\n'
                  '• causing chemical changes in your brain which can help to positively change your mood\n\n'
                  'Some things you can do:\n\n'
                  '• try running and aerobic exercises to help get you moving and improve your fitness\n'
                  '• try strength and flexibility exercises to increase muscle strength, improve balance and reduce joint pain\n\n'
                  'Don\'t feel you have to spend hours in a gym. It\'s best to find activities you enjoy and make them a part of your life';
        break;
      case 'Connect':
        infoText = 'Good relationships are important for your mental wellbeing. They can:\n\n'
                  '• help you to build a sense of belonging and self-worth\n'
                  '• give you an opportunity to share positive experiences\n'
                  '• provide emotional support and allow you to support others\n\n'
                  'There are lots of things you could try to help build stronger and closer relationships:\n\n'
                  '• take time each day to be with your family\n'
                  '• arrange a day out with friends you have not seen for a while\n'
                  '• try switching off the TV to talk or play a game with your children, friends or family\n'
                  '• have lunch with a colleague\n'
                  '• visit a friend or family member who needs support or company\n'
                  '• volunteer at a local school, hospital or community group\n'
                  '• make the most of technology to stay in touch with friends and family\n\n'
                  'Don\'t rely on technology or social media alone to build relationships. It\'s easy to get into the habit of only ever texting, messaging or emailing people';
        break;
      default:
        infoText = '';
    }
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(option),
          content: SingleChildScrollView(
            child: Text(infoText),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Entry' : 'Add New Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                style: Theme.of(context).textTheme.titleLarge,
                decoration: const InputDecoration(
                  
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                      style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text('Select Options', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurface)),
              CheckboxListTile(
                title: Row(
                  children: [
                    const Text('Give'),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => _showInfoPopup('Give'),
                      child: const Icon(Icons.info, size: 20),
                    ),
                  ],
                ),
                value: _give,
                onChanged: (bool? value) {
                  setState(() {
                    _give = value ?? false;
                  });
                },
                activeColor: theme.colorScheme.primary,
                tileColor: theme.colorScheme.surface,
                checkColor: theme.colorScheme.onPrimary,
              ),
              CheckboxListTile(
                title: Row(
                  children: [
                    const Text('Take Notice'),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => _showInfoPopup('Take Notice'),
                      child: const Icon(Icons.info, size: 20),
                    ),
                  ],
                ),
                value: _takeNotice,
                onChanged: (bool? value) {
                  setState(() {
                    _takeNotice = value ?? false;
                  });
                },
                activeColor: theme.colorScheme.primary,
                tileColor: theme.colorScheme.surface,
                checkColor: theme.colorScheme.onPrimary,
              ),
              CheckboxListTile(
                title: Row(
                  children: [
                    const Text('Keep Learning'),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => _showInfoPopup('Keep Learning'),
                      child: const Icon(Icons.info, size: 20),
                    ),
                  ],
                ),
                value: _keepLearning,
                onChanged: (bool? value) {
                  setState(() {
                    _keepLearning = value ?? false;
                  });
                },
                activeColor: theme.colorScheme.primary,
                tileColor: theme.colorScheme.surface,
                checkColor: theme.colorScheme.onPrimary,
              ),
              CheckboxListTile(
                title: Row(
                  children: [
                    const Text('Be Active'),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => _showInfoPopup('Be Active'),
                      child: const Icon(Icons.info, size: 20),
                    ),
                  ],
                ),
                value: _beActive,
                onChanged: (bool? value) {
                  setState(() {
                    _beActive = value ?? false;
                  });
                },
                activeColor: theme.colorScheme.primary,
                tileColor: theme.colorScheme.surface,
                checkColor: theme.colorScheme.onPrimary,
              ),
              CheckboxListTile(
                title: Row(
                  children: [
                    const Text('Connect'),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => _showInfoPopup('Connect'),
                      child: const Icon(Icons.info, size: 20),
                    ),
                  ],
                ),
                value: _connect,
                onChanged: (bool? value) {
                  setState(() {
                    _connect = value ?? false;
                  });
                },
                activeColor: theme.colorScheme.primary,
                tileColor: theme.colorScheme.surface,
                checkColor: theme.colorScheme.onPrimary,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveEntry,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text('Save Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
