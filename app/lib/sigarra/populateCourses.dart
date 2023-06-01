import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_options.dart';
import'scraper.dart';

List<String> faculties = ['fcup', 'fcnaup', 'fadeup', 'fdup', 'fep', 'feup', 'flup', 'fmup', 'fpceup', 'icbas'];

Future<void> populateCourses(String faculty) async {
  List<int> bachelorsIDs = await getFacultyBachelorsIDs(faculty);
  List<int> mastersIDs = await getFacultyMastersIDs(faculty);
  List<int> PhDsIDs = await getFacultyPhDsIDs(faculty);
  
  List<Course> courses = [];
  
  for (int id in bachelorsIDs) courses.add(await getCourse(faculty, id, 'Licenciatura'));
  for (int id in mastersIDs) courses.add(await getCourse(faculty, id, 'Mestrado'));
  for (int id in PhDsIDs) courses.add(await getCourse(faculty, id, 'Doutoramento'));
  
  for (Course course in courses) {
    final newDocument = FirebaseFirestore.instance.collection('curso').doc(faculty.toUpperCase() + course.sigla);
    final json = {'grau': course.grau, 'nome': course.nome, 'sigla': course.sigla, 'faculdade': course.faculdade, 'id': course.id};

    await newDocument.set(json);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  for (String faculty in faculties) await populateCourses(faculty);
}
