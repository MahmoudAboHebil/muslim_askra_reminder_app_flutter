import 'package:flutter/material.dart';
import 'constant.dart';

class miniCardPage1 extends StatelessWidget {
  String text;
  Color textColor;
  Color parentColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(top: 20, bottom: 10),
        decoration: BoxDecoration(
          color: parentColor,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Center(
          child: CustomText(
            text,
            20,
            textColor,
          ),
        ),
      ),
    );
  }

  miniCardPage1(this.text, this.textColor, this.parentColor);
}

class MiniCardHome extends StatelessWidget {
  String assestPath;
  String title;
  Color couler1;
  Color couler2;

  MiniCardHome(this.assestPath, this.title, this.couler1, this.couler2);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 30),
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[couler1, couler2],
          ),
          boxShadow: [kBoxShadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Image.asset(
                assestPath,
                height: 40,
                width: 40,
              ),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  String title;
  double size;
  Color couler;

  CustomText(this.title, this.size, this.couler);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size,
        color: couler,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  Function fun;
  BoxConstraints box;
  String title;
  Color fillColor;

  NavButton(this.fun, this.box, this.title, this.fillColor);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      focusElevation: 0.0,
      hoverElevation: 0.0,
      highlightElevation: 0.0,
      elevation: 0.0,
      shape: selectedBorder,
      onPressed: () {
        fun();
      },
      constraints: box,
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF76d668),
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      fillColor: fillColor,
    );
  }
}

class miniRow extends StatelessWidget {
  String title;
  String assestPath;

  miniRow(this.title, this.assestPath);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: 10,
        ),
        Image.asset(
          assestPath,
          height: 20,
          width: 20,
        ),
      ],
    );
  }
}

class customActionFloating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xFF76d668),
      onPressed: () {},
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
