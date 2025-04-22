import 'package:flutter/material.dart';
import 'journalEntry.dart';
import 'addEditEntryPage.dart';

class JournalView extends StatefulWidget {
  const JournalView({super.key});

  @override
  State<JournalView> createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {
  final List<JournalEntry> _entries = [];

  void _navigateToAddEntry() async {
    final newEntry = await Navigator.push<JournalEntry>(
      context,
      MaterialPageRoute(builder: (context) => const AddEditEntryPage()),
    );

    if (newEntry != null) {
      setState(() {
        _entries.add(newEntry);
        _entries.sort((a, b) => b.date.compareTo(a.date));
      });
    }
  }

  void _navigateToEditEntry(JournalEntry entry, int index) async {
    final updatedEntry = await Navigator.push<JournalEntry>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditEntryPage(entryToEdit: entry),
      ),
    );

    if (updatedEntry != null) {
      setState(() {
        _entries[index] = updatedEntry;
        _entries.sort((a, b) => b.date.compareTo(a.date));
      });
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
        title: Text("PLASCEHOLDER"),
      ),
      body: _entries.isEmpty
          ? const Center(
              child: Text('No journal entries yet. Press + to add one!'),
            )
          : ListView.builder(
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                final entry = _entries[index];
                return ListTile(
                  title: Text(entry.title),
                  subtitle: Text(entry.date.toLocal().toString().split(' ')[0]),
                  onTap: () => _showEntryDetails(entry),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _navigateToEditEntry(entry, index),
                  ),
                );
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
