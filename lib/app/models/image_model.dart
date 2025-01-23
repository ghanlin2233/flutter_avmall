import 'package:get/get.dart';

class MyImage {  
  final String name;  
  final String assetPath; 
  RxBool isChecked; 

  MyImage({required this.name, required this.assetPath, bool? checked})
    : isChecked = (checked ?? false).obs;
} 