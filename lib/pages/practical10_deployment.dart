import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Practical 10: App Deployment & Versioning
class Practical10DeploymentInfo extends StatelessWidget {
  const Practical10DeploymentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Practical 10: Deployment Info',
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'App Deployment & Versioning',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              'This practical provides a guide for generating a signed APK for Android and preparing your app for deployment.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            _buildSectionTitle(context, '1. Keystore Generation & App Signing'),
            _buildInfoText(
              context,
              'A keystore is a binary file that contains a set of private keys. You need to create one to digitally sign your Android app for publishing.',
            ),
            _buildInfoText(context, 'Command to generate a key:'),
            _buildCodeSnippet(
              context,
              'keytool -genkey -v -keystore [keystore_name].jks -keyalg RSA -keysize 2048 -validity 10000 -alias [alias_name]',
            ),
            _buildInfoText(
              context,
              'You will need to remember the keystore password, key password, and alias name.',
            ),
            _buildSectionTitle(context, '2. Flutter Build Process for Release'),
            _buildInfoText(
              context,
              'To create a release build for Android, run the following command:',
            ),
            _buildCodeSnippet(context, 'flutter build apk --release'),
            _buildInfoText(
              context,
              'This command generates an `app-release.apk` file in the `build/app/outputs/flutter-apk/` directory.',
            ),
            _buildSectionTitle(context, '3. App Versioning'),
            _buildInfoText(
              context,
              'App versioning is crucial for updates. It is defined in your `pubspec.yaml` file.',
            ),
            _buildCodeSnippet(context, 'version: 1.0.0+1'),
            _buildInfoText(
              context,
              'Here, `1.0.0` is the `versionName` (visible to users), and `1` is the `versionCode` (an internal number for app stores). The `versionCode` must be incremented with every new upload.',
            ),
            _buildSectionTitle(context, '4. Google Play Store Deployment'),
            _buildInfoText(
              context,
              'To publish your app, you will need a Google Play Developer account. The process involves:',
            ),
            _buildListItem(
              context,
              'Creating a new app listing in the Play Console.',
            ),
            _buildListItem(
              context,
              'Uploading your signed `app-release.apk` or `app-release.aab` file.',
            ),
            _buildListItem(
              context,
              'Providing store listings, screenshots, and privacy policy.',
            ),
            _buildListItem(
              context,
              'Setting up the target audience and content rating.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildInfoText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  Widget _buildCodeSnippet(BuildContext context, String code) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        color: Colors.grey.shade200,
        child: Text(
          code,
          style: GoogleFonts.sourceCodePro(color: Colors.black, fontSize: 14.0),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('• ', style: TextStyle(fontSize: 16.0)),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
