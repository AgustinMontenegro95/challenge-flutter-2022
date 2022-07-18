import 'package:flutter/material.dart';

PreferredSizeWidget appBar(BuildContext context,
    {String? title, bool? settings}) {
  return AppBar(
    title: title != null
        ? Text(title.toUpperCase())
        : const Image(image: AssetImage('assets/images/logo.png'), height: 50),
    centerTitle: true,
    backgroundColor: Colors.transparent.withOpacity(0.4),
    actions: [
      if (settings != null)
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
          icon: const Icon(Icons.settings),
        ),
    ],
  );
}
