import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';

class PrivacyView extends StatefulWidget {
  const PrivacyView({super.key});

  @override
  State<PrivacyView> createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              width: constraints.maxWidth > 800 ? 800.0 : constraints.maxWidth * 0.9,
              child: FutureBuilder(
                  future: rootBundle.loadString('assets/privacy_policy.md'),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return MarkdownWidget(
                        data: snapshot.data!,
                        config: MarkdownConfig(
                          configs: [
                            H1Config(style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                            H2Config(style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                            H3Config(style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                            H4Config(style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                            H5Config(style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                            H6Config(style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                            PConfig(textStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            );
          },
        ),
      ),
    );
  }
}
