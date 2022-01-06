import 'package:flutter/material.dart';

class AppAlert{
  

  static progressIndicator( context){
    return showDialog(
      context:context,
      builder:(context){
        return AlertDialog(
          content: Container( height: 100,child: Center(child: CircularProgressIndicator(),)),
        );
      }
    );
  }
}