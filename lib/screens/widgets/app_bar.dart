import 'package:challenge_flutter_2022/constants/constants.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBar(BuildContext context,
    {String? title, bool? settings}) {
  return AppBar(
    title: title != null
        ? Text(
            title,
            style: joutStyle.copyWith(fontSize: 25),
          )
        : const Image(image: AssetImage('assets/images/logo.png'), height: 50),
    centerTitle: true,
    backgroundColor: Colors.transparent.withOpacity(0.7),
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
