import 'scraper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter/services.dart';

Future populateFCUPTeachers() async {
  String html = await rootBundle.loadString('assets/fcup2022.html');

  BeautifulSoup soup = BeautifulSoup(html);

  var content = soup.find('*', id: 'conteudoinner');
  var rows = content!.findAll('li');

  Map<int, String> codesNames = {};

  for (var row in rows) {
    var a = row.find('a');
    String code = a.toString();
    code = code.substring(38,44);
    codesNames[int.parse(code)] = a!.getText();
  }

  codesNames.forEach((key, value) async {
    final newDocument = FirebaseFirestore.instance.collection('professor').doc('FCUP'+key.toString());
    final json = {'codigo': key, 'nome-simpl': removeDiacritics(value).toLowerCase(), 'nome': value, 'faculdade': 'FCUP'};

    await newDocument.set(json);
  });
}

Future populateFCNAUPTeachers() async {
  String html = await rootBundle.loadString('assets/fcnaup2022.html');

  BeautifulSoup soup = BeautifulSoup(html);

  var content = soup.find('*', id: 'conteudoinner');
  var rows = content!.findAll('li');

  Map<int, String> codesNames = {};

  for (var row in rows) {
    var a = row.find('a');
    String code = a.toString();
    code = code.substring(38,44);
    codesNames[int.parse(code)] = a!.getText();
  }

  codesNames.forEach((key, value) async {
    final newDocument = FirebaseFirestore.instance.collection('professor').doc('FCNAUP'+key.toString());
    final json = {'codigo': key, 'nome-simpl': removeDiacritics(value).toLowerCase(), 'nome': value, 'faculdade': 'FCNAUP'};

    await newDocument.set(json);
  });
}

void populateFADEUPTeachers() async {
  String html = await rootBundle.loadString('assets/fadeup2022.html');

  BeautifulSoup soup = BeautifulSoup(html);

  var content = soup.find('*', id: 'conteudoinner');
  var rows = content!.findAll('li');

  Map<int, String> codesNames = {};

  for (var row in rows) {
    var a = row.find('a');
    String code = a.toString();
    code = code.substring(38,44);
    codesNames[int.parse(code)] = a!.getText();
  }

  codesNames.forEach((key, value) async {
    final newDocument = FirebaseFirestore.instance.collection('professor').doc('FADEUP'+key.toString());
    final json = {'codigo': key, 'nome-simpl': removeDiacritics(value).toLowerCase(), 'nome': value, 'faculdade': 'FADEUP'};

    await newDocument.set(json);
  });
}

Future populateFDUPTeachers() async {
  String html = await rootBundle.loadString('assets/fdup2022.html');

  BeautifulSoup soup = BeautifulSoup(html);

  var content = soup.find('*', id: 'conteudoinner');
  var rows = content!.findAll('li');

  Map<int, String> codesNames = {};

  for (var row in rows) {
    var a = row.find('a');
    String code = a.toString();
    code = code.substring(38,44);
    codesNames[int.parse(code)] = a!.getText();
  }

  codesNames.forEach((key, value) async {
    final newDocument = FirebaseFirestore.instance.collection('professor').doc('FDUP'+key.toString());
    final json = {'codigo': key, 'nome-simpl': removeDiacritics(value).toLowerCase(), 'nome': value, 'faculdade': 'FDUP'};

    await newDocument.set(json);
  });
}

Future populateFEPTeachers() async {
  String html = await rootBundle.loadString('assets/fep2022.html');

  BeautifulSoup soup = BeautifulSoup(html);

  var content = soup.find('*', id: 'conteudoinner');
  var rows = content!.findAll('li');

  Map<int, String> codesNames = {};

  for (var row in rows) {
    var a = row.find('a');
    String code = a.toString();
    code = code.substring(38,44);
    codesNames[int.parse(code)] = a!.getText();
  }

  codesNames.forEach((key, value) async {
    final newDocument = FirebaseFirestore.instance.collection('professor').doc('FEP'+key.toString());
    final json = {'codigo': key, 'nome-simpl': removeDiacritics(value).toLowerCase(), 'nome': value, 'faculdade': 'FEP'};

    await newDocument.set(json);
  });
}

Future populateFEUPTeachers() async {
  String html = await rootBundle.loadString('assets/feup2022.html');

  BeautifulSoup soup = BeautifulSoup(html);

  var content = soup.find('*', id: 'conteudoinner');
  var rows = content!.findAll('li');

  Map<int, String> codesNames = {};

  for (var row in rows) {
    var a = row.find('a');
    String code = a.toString();
    code = code.substring(38,44);
    codesNames[int.parse(code)] = a!.getText();
  }

  codesNames.forEach((key, value) async {
    final newDocument = FirebaseFirestore.instance.collection('professor').doc('FEUP'+key.toString());
    final json = {'codigo': key, 'nome-simpl': removeDiacritics(value).toLowerCase(), 'nome': value, 'faculdade': 'FEUP'};

    await newDocument.set(json);
  });
}

Future populateFLUPTeachers() async {
  String html = await rootBundle.loadString('assets/flup2022.html');

  BeautifulSoup soup = BeautifulSoup(html);

  var content = soup.find('*', id: 'conteudoinner');
  var rows = content!.findAll('li');

  Map<int, String> codesNames = {};

  for (var row in rows) {
    var a = row.find('a');
    String code = a.toString();
    code = code.substring(38,44);
    codesNames[int.parse(code)] = a!.getText();
  }

  codesNames.forEach((key, value) async {
    final newDocument = FirebaseFirestore.instance.collection('professor').doc('FLUP'+key.toString());
    final json = {'codigo': key, 'nome-simpl': removeDiacritics(value).toLowerCase(), 'nome': value, 'faculdade': 'FLUP'};

    await newDocument.set(json);
  });
}

Future populateFMUPTeachers() async {
  String html = await rootBundle.loadString('assets/fmup2022.html');

  BeautifulSoup soup = BeautifulSoup(html);

  var content = soup.find('*', id: 'conteudoinner');
  var rows = content!.findAll('li');

  Map<int, String> codesNames = {};

  for (var row in rows) {
    var a = row.find('a');
    String code = a.toString();
    code = code.substring(38,44);
    codesNames[int.parse(code)] = a!.getText();
  }

  codesNames.forEach((key, value) async {
    final newDocument = FirebaseFirestore.instance.collection('professor').doc('FMUP'+key.toString());
    final json = {'codigo': key, 'nome-simpl': removeDiacritics(value).toLowerCase(), 'nome': value, 'faculdade': 'FMUP'};

    await newDocument.set(json);
  });
}

Future populateFPCEUPTeachers() async {
  String html = await rootBundle.loadString('assets/fpceup2022.html');

  BeautifulSoup soup = BeautifulSoup(html);

  var content = soup.find('*', id: 'conteudoinner');
  var rows = content!.findAll('li');

  Map<int, String> codesNames = {};

  for (var row in rows) {
    var a = row.find('a');
    String code = a.toString();
    code = code.substring(38,44);
    codesNames[int.parse(code)] = a!.getText();
  }

  codesNames.forEach((key, value) async {
    final newDocument = FirebaseFirestore.instance.collection('professor').doc('FPCEUP'+key.toString());
    final json = {'codigo': key, 'nome-simpl': removeDiacritics(value).toLowerCase(), 'nome': value, 'faculdade': 'FPCEUP'};

    await newDocument.set(json);
  });
}

Future populateICBASTeachers() async {
  String html = await rootBundle.loadString('assets/icbas2022.html');

  BeautifulSoup soup = BeautifulSoup(html);

  var content = soup.find('*', id: 'conteudoinner');
  var rows = content!.findAll('li');

  Map<int, String> codesNames = {};

  for (var row in rows) {
    var a = row.find('a');
    String code = a.toString();
    code = code.substring(38,44);
    codesNames[int.parse(code)] = a!.getText();
  }

  codesNames.forEach((key, value) async {
    final newDocument = FirebaseFirestore.instance.collection('professor').doc('ICBAS'+key.toString());
    final json = {'codigo': key, 'nome-simpl': removeDiacritics(value).toLowerCase(), 'nome': value, 'faculdade': 'ICBAS'};

    await newDocument.set(json);
  });
}
