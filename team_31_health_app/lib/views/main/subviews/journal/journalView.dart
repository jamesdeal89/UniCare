import 'package:flutter/material.dart';
import 'package:team_31_health_app/data/database/journalRepo.dart'; // Import JournalRepo
import 'package:team_31_health_app/data/database_fields/journalEntry.dart';
import 'addEditEntryPage.dart';

class JournalView extends StatefulWidget {
  const JournalView({super.key, required this.journalRepo});

  final JournalRepo journalRepo; 

  @override
  State<JournalView> createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {
  late Future<List<JournalEntry>> _entriesFuture;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    _entriesFuture = widget.journalRepo.get();
  }

  
  void _refreshEntries() {
    setState(() {
      _loadEntries();
    });
  }

  void _navigateToAddEntry() async {
    final newEntry = await Navigator.push<JournalEntry>(
      context,
      MaterialPageRoute(builder: (context) => const AddEditEntryPage()),
    );

    if (newEntry != null) {
      try {
        await widget.journalRepo.insert(newEntry);
        _refreshEntries();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving entry: $e')),
        );
      }
    }
  }

  void _navigateToEditEntry(JournalEntry entry) async {
    final updatedEntry = await Navigator.push<JournalEntry>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditEntryPage(entryToEdit: entry),
      ),
    );

    if (updatedEntry != null) {
      try {
        await widget.journalRepo.update(updatedEntry);
        _refreshEntries(); 
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating entry: $e')),
        );
      }
    }
  }

  Future<void> _deleteEntry(int id) async {
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this journal entry?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        await widget.journalRepo.delete(id);
        _refreshEntries();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Entry deleted')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting entry: $e')),
        );
      }
    }
  }

  void _showEntryDetails(JournalEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(entry.title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Date: ${entry.date.toLocal().toString().split(' ')[0]}'),
              const SizedBox(height: 10),
              Text(entry.description),
              const SizedBox(height: 20),
              Text('Options:', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              _optionRow('Give', entry.give),
              _optionRow('Take Notice', entry.takeNotice),
              _optionRow('Keep Learning', entry.keepLearning),
              _optionRow('Be Active', entry.beActive),
              _optionRow('Connect', entry.connect),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _optionRow(String label, bool value) {
    return Row(
      children: [
        Icon(
          value ? Icons.check_box : Icons.check_box_outline_blank,
          color: value ? Theme.of(context).colorScheme.primary : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Journal"),
        actions: [ 
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshEntries,
            tooltip: 'Refresh Entries',
          ),
        ],
      ),
      body: FutureBuilder<List<JournalEntry>>(
        future: _entriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading entries: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No journal entries yet. Press + to add one!'),
            );
          } else {
            final entries = snapshot.data!;
            entries.sort((a, b) => b.date.compareTo(a.date));

            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return ListTile(
                  title: Text(entry.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.date.toLocal().toString().split(' ')[0]),
                      const SizedBox(height: 4),
                      _optionRow('Give', entry.give),
                      _optionRow('Take Notice', entry.takeNotice),
                      _optionRow('Keep Learning', entry.keepLearning),
                      _optionRow('Be Active', entry.beActive),
                      _optionRow('Connect', entry.connect),
                    ],
                  ),
                  onTap: () => _showEntryDetails(entry),
                  trailing: PopupMenuButton<String>(
                    onSelected: (String result) {
                      switch (result) {
                        case 'edit':
                          _navigateToEditEntry(entry);
                          break;
                        case 'delete':
                          _deleteEntry(entry.id);
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Edit'),
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(Icons.delete, color: Colors.red),
                          title: Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddEntry,
        tooltip: 'Add Entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}

