import 'package:flutter/material.dart';

class UserGuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Guide'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Introduction'),
            SectionContent(
              content: 'Welcome to our Exchange Rate Converter app! This user guide is designed to help you navigate through the features and functionalities of our application. Whether you\'re a frequent traveler, a business professional, or simply someone interested in currency exchange rates, our app aims to provide you with a seamless experience for converting currencies effortlessly.',
            ),
            SectionTitle(title: 'Getting Started'),
            SectionContent(
              content: '1. Installation: You can download and install the Exchange Rate Converter app from the Google Play Store or Apple App Store, depending on your device\'s operating system.\n2. Launch: Once installed, locate the app icon on your device\'s home screen or app drawer and tap to launch the application.',
            ),
            // Add other sections with content similarly
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String content;

  const SectionContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(content),
    );
  }
}

