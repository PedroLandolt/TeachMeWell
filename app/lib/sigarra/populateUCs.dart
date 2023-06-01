import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_options.dart';
import'scraper.dart';

Stream<QuerySnapshot<Map<String, dynamic>>> courses = FirebaseFirestore.instance
    .collection('curso').where('faculdade', isEqualTo: 'FCUP')
    .snapshots();

Future<bool> checkIfDocExists(String docId) async {
  try {
    var collectionRef = FirebaseFirestore.instance.collection('uc');

    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  } catch (e) {
    return false;
  }
}

Future<void> populateUCs() async {
  // Set<String> faculties = {};
  await for (final s in courses) {
    for(int i = 0; i < s.docs.length; i++) {
      final course = s.docs[i];
      // if(faculties.contains(course['faculdade'])){
      //   print("Ja existe: " + course['faculdade']);
      //   continue;
      // }
      // faculties.add(course['faculdade']);
      Stream<UC_details> stream = await getCourseUCsIDsStream(course['faculdade'], course['id'], 2022);
      await for (final uc in stream) {
        if (uc.nome != "") {
          if(uc.codigo.contains("/"))
            uc.codigo = uc.codigo.replaceAll("/", "_");
          try{
            int i = 1;
            bool cont = false;
            while(await checkIfDocExists(uc.faculdade.toUpperCase() + uc.codigo)) {
              dynamic colection = await FirebaseFirestore.instance.collection('uc').doc(uc.faculdade.toUpperCase() + uc.codigo).get();
              if(colection['courseId'] == course['id']){
                print("Ja existe: " + uc.faculdade.toUpperCase() + uc.codigo);
                cont = true;
                break;
              }
              uc.codigo += '-' + i.toString();
              i++;
            }
            if(cont)
              continue;
            final newDocument = FirebaseFirestore.instance.collection('uc').doc(
                uc.faculdade.toUpperCase() + uc.codigo);
            final json = {
              'nome': uc.nome,
              'codigo': uc.codigo,
              'faculdade': uc.faculdade.toUpperCase(),
              'courseId': course['id'],
              'id': uc.id
            };
            print(json);
            await newDocument.set(json);
            // break;
          } catch(e) {
            print("Continued!");
            continue;
            // print("!!!!");
            // print('nome' + uc.nome);
            // print('codigo' + uc.codigo);
            // print('faculdade' + uc.faculdade.toUpperCase());
            // print('courseId' + course['id'].toString());
            // throw e;
          }
        }
      }
    }
  }
  print("Done!");
}

Future<void> main() async {
  print("Starting...");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await populateUCs();
  print("Done!");
}
