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
                title: const Text('Give'),
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
                title: const Text('Take Notice'),
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
                title: const Text('Keep Learning'),
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
                title: const Text('Be Active'),
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
                title: const Text('Connect'),
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
