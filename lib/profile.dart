import 'package:flutter/material.dart';

class AppBarExample extends StatelessWidget {
  const AppBarExample({Key? key}) : super(key: key);

  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('notification')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('MERA UPSC')),
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _openDrawer(context),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () => _showSnackbar(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Show Snackbar'),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarApp extends StatelessWidget {
  const AppBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppBarExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(const AppBarApp());
}
