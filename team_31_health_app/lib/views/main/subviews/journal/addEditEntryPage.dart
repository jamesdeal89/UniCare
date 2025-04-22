import 'package:flutter/material.dart';
import 'journalEntry.dart';

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
        id: _isEditing ? widget.entryToEdit!.id : DateTime.now().millisecondsSinceEpoch.toString(),
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

  @override
  Widget build(BuildContext context) {
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
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text('Select Options', style: Theme.of(context).textTheme.titleLarge),
              CheckboxListTile(
                title: const Text('Give'),
                value: _give,
                onChanged: (bool? value) {
                  setState(() {
                    _give = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Take Notice'),
                value: _takeNotice,
                onChanged: (bool? value) {
                  setState(() {
                    _takeNotice = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Keep Learning'),
                value: _keepLearning,
                onChanged: (bool? value) {
                  setState(() {
                    _keepLearning = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Be Active'),
                value: _beActive,
                onChanged: (bool? value) {
                  setState(() {
                    _beActive = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Connect'),
                value: _connect,
                onChanged: (bool? value) {
                  setState(() {
                    _connect = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
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
                child: const Text('Save Entry'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
