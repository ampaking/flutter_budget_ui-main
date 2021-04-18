import 'package:flutter/material.dart';

Color getColor(BuildContext context, double percent){
 if(percent >=0.70 ){
   return Colors.red;
 }else if(percent >= 0.5){
   return Colors.deepOrangeAccent;
 }else if (percent >= 0.3){
   return Colors.lightGreen;
 }else if (percent >= 0.25){
   return Colors.green;
 }
 return null;
}

