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

  Future<void> _deleteEntry(int? id) async {
    if (id == null) return;

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
        title: Text(entry.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Date: ${entry.date.toLocal().toString().split(' ')[0]}'),
              const SizedBox(height: 10),
              Text(entry.description),
              const SizedBox(height: 20),
              Text('Ways to Wellbeing:', style: Theme.of(context).textTheme.titleMedium),
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
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            child: const Text('Close'),
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
          color: value ? Theme.of(context).colorScheme.onPrimary : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(label),
        const SizedBox(width: 8),
        InkWell(
          onTap: () => _showInfoPopup(label),
          child: const Icon(Icons.info, size: 20),
        ),
      ],
    );
  }

  void _showInfoPopup(String option) {
    String infoText;

    switch (option) {
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        centerTitle: false,
        titleSpacing: 18,
        toolbarHeight: 108,
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
                  title: Text(entry.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold)),
                  subtitle: Text(entry.date.toLocal().toString().split(' ')[0]),
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
