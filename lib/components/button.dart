import "package:flutter/material.dart";

class MyBtn extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyBtn({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap  ,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.indigo[700], borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(text,
              style: const TextStyle(
                color: Colors.white,
                letterSpacing: 3,
                fontWeight: FontWeight.w800,
              )),
        ),
      ),
    );
  }
}
