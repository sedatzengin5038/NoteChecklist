import 'package:firebase_core/firebase_core.dart';  
import 'package:flutter/material.dart';
import '/app/app.dart';
import '/app/di/get_it.dart' as di;

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await Future.wait([di.init()]);
  runApp(const NoteApp());
}
