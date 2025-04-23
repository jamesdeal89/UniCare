import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpView();
}

class Charity {
  final String name;
  final String description;
  final String phoneNumber;
  final String website;
  final IconData icon;
  final Color colour;
  final String opening;

  Charity({
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.website,
    required this.icon,
    required this.colour,
    required this.opening,
  });
}

// TODO: abstract fonts to maintain cohesive experience across the app
// TODO: abtract out all colours to a seperate file? not sure if this is stricttly needed since theyre only really used here
// TODO: maybe also abstract out the charity details to their own file?

class _HelpView extends State<HelpView> {
  @override
  Widget build(BuildContext context) {
    final List<Charity> charities = [
      Charity(
        name: 'NHS Mental Health Resources',
        description: 'Access support from the National Health Service.',
        phoneNumber: '111',
        website: 'https://www.nhs.uk/nhs-services/mental-health-services/',
        icon: Icons.local_hospital,
        colour: const Color.fromARGB(255, 53, 94, 180),
        opening: '24/7',
      ),
      Charity(
        name: 'Samaritans',
        description: '24/7 support for anyone who\’s struggling to cope, who needs someone to listen without judgement or pressure.',
        phoneNumber: '116 123',
        website: 'https://www.samaritans.org/',
        icon: Icons.call,
        colour: const Color.fromARGB(255, 93, 164, 137),
        opening: '24/7',
      ),
      Charity(
        name: 'Mind',
        description: 'Mind offers resources and a safe space to talk about your mental health.',
        phoneNumber: '0300 102 1234',
        website: 'https://www.mind.org.uk/',
        icon: Icons.menu_book,
        colour: const Color.fromARGB(255, 47, 62, 124),
        opening: '9am - 6pm, Monday - Friday (Except Bank Holidays)',
      ),
      Charity(
        name: 'SANE',
        description: 'SANE offers non-judgemental and compassionate emotional support.',
        phoneNumber: '0300 304 7000',
        website: 'https://www.sane.org.uk/how-we-help/emotional-support/',
        icon: Icons.volunteer_activism,
        colour: const Color.fromARGB(255, 203, 28, 79),
        opening: '4pm - 10pm, daily',
      ),
      Charity(
        name: 'No Panic',
        description: 'Support for those living with Panic Attacks, Phobias, Obsessive Compulsive Disorders and other related anxiety disorders.',
        phoneNumber: '0300 772 9844',
        website: 'https://nopanic.org.uk/',
        icon: Icons.call,
        colour: const Color.fromARGB(255, 92, 159, 161),
        opening: '10am - 10pm, daily',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 32, top: 32),
                    child: Text(
                      "Help",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade700, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.emergency,
                          color: Colors.red.shade700,
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "If you or someone else is in danger, call 999 or go to A&E now. If you need urgent help for your mental health, get help from NHS 111 online or call 111.",
                            style: TextStyle(
                              color: Colors.red.shade900,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        "Mental Health Resources",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Text(
                        "These organisations provide free mental health support and resources. Please note that some data, such as contact details or opening hours, may be incorrect or outdated.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemCount: charities.length,
                      itemBuilder: (context, index) {
                        return _buildCharityCard(context, charities[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharityCard(BuildContext context, Charity charity) {
    bool isAlwaysOpen = charity.opening.toLowerCase().contains('24/7');

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showContacts(context, charity),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: charity.colour.withOpacity(0.2),
                child: Icon(
                  charity.icon,
                  color: charity.colour,
                  size: 28,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            charity.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        if (isAlwaysOpen)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 12,
                                  color: Colors.green.shade700,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '24/7',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      charity.description,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.touch_app,
                          size: 14,
                          color: Colors.blue[700],
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Tap for details',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContacts(BuildContext context, Charity charity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: charity.colour.withOpacity(0.2),
                  child: Icon(charity.icon, color: charity.colour),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        charity.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        charity.description,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            CallContactButton(
              phoneNumber: charity.phoneNumber,
              availability: charity.opening,
              onTap: () => _launchUrl('tel:${charity.phoneNumber}'),
            ),
            SizedBox(height: 16),
            WebsiteContactButton(
              website: charity.website,
              onTap: () => _launchUrl(charity.website),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class CallContactButton extends StatelessWidget {
  final String phoneNumber;
  final String availability;
  final VoidCallback onTap;

  const CallContactButton({
    required this.phoneNumber,
    required this.availability,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.call, color: Colors.green),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Call',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  availability,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiaryFixedVariant.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  phoneNumber,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WebsiteContactButton extends StatelessWidget {
  final String website;
  final VoidCallback onTap;

  const WebsiteContactButton({
    required this.website,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.language, color: Colors.blue),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visit Website',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    website,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO: make more formal?
Future<void> _launchUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);
  try {
    await launchUrl(url);
  } catch (e) {
    throw Exception('couldnt open $url');
  }
}
