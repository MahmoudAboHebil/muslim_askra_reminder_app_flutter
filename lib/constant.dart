import 'package:flutter/material.dart';

const selectedBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(30.0),
  ),
);

BoxShadow kBoxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  spreadRadius: 1,
  blurRadius: 7,
  offset: Offset(0, 3), // changes position of shadow
);

Color color = Color(0xFF63b459);
