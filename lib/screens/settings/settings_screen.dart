import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListTile(
        title: Text("Dark Mode"),
        trailing: Switch(
          value: themeProvider.isDarkMode,
          onChanged: (_) {
            themeProvider.toggleTheme();
          },
        ),
      ),
    );
  }
}
