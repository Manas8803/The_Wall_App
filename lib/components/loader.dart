import 'package:flutter/material.dart';

class FancyLoader {
  static void show(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(20.0),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 28, 50, 175)),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Loading...',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
