import 'package:flutter_test/flutter_test.dart';
import 'package:teachmewell/sigarra/scraper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teachmewell/firebase_options.dart';
import 'package:teachmewell/main.dart';
import 'package:teachmewell/teacher.dart';
import 'package:teachmewell/uc.dart';


void main() async {
  test('Testing getUCTeachersIDs', () async {
    List<int> teachers = await getUCTeachersIDs("FEUP", 501682);
    Set<int> teachersSet = teachers.toSet();

    Set<int> expectedTeachers = {201100, 202091, 235739};

    expect(teachersSet, expectedTeachers);
  });

  test("FEUP_L.EIC UCs' IDs", () async {
    Set<int> expected_FEUP_LEIC = {
      501662, 501663, 501665, 501666, 501664, 501667, 501669, 501670, 501668,
      501672, 501671, 501673, 501674, 501675, 501677, 501676, 501680, 501678,
      501679, 501682, 501681, 501684, 501685, 501687, 501683, 501686, 501690,
      501688, 501689, 501692, 501691, 502284, 502227, 502236, 502290, 502285,
      502291, 502294, 502264, 502289};

    List<int> FEUP_LEIC = await getCourseUCsIDs('FEUP', 22841, 2022);
    Set<int> received_FEUP_LEIC = FEUP_LEIC.toSet();

    expect(received_FEUP_LEIC, expected_FEUP_LEIC);
  });

  test("FLUP_SOCI UCs' IDs", () async {
    Set<int> expected_FLUP_SOCI = {
      496882, 496884, 496885, 496883, 496886, 496888, 496889, 496887, 496890,
      496891, 496895, 496894, 496893, 496892, 496896, 496899, 496897, 496900,
      496898, 496901, 496902, 496906, 496903, 496908, 496907, 496911, 496904,
      496905, 496910, 496909, 496912};

    List<int> FLUP_SOCI = await getCourseUCsIDs('FLUP', 452, 2022);
    Set<int> received_FLUP_SOCI = FLUP_SOCI.toSet();

    expect(received_FLUP_SOCI, expected_FLUP_SOCI);
  });

  test("FEUP_L.EIC_ES details", () async {
    UC_details expectedES = new UC_details("Engenharia de Software", "L.EIC017", "ES", "feup", 501679);
    UC_details receivedES = await getUCInfo("FEUP", 501679);

    expect(ucEquals(receivedES, expectedES), true);
  });

  test("FEP_LECO_MIF details", () async {
    UC_details expectedMIF = new UC_details("Mercados e Investimentos Financeiros", "1EC208", "MIF", "fep", 499899);
    UC_details receivedMIF = await getUCInfo("FEP", 499899);

    expect(ucEquals(expectedMIF, receivedMIF), true);
  });

  test('Testing search 1', () async {
    List<TeacherDetails> teachers = [
      new TeacherDetails("10", "Nome1", "nome1", "FEUP", 123),
      new TeacherDetails("20", "Apelido1", "apelido1", "FEUP", 124),
      new TeacherDetails("30", "Nome2", "nome2", "FEUP", 125),
      new TeacherDetails("40", "Apelido2", "apelido2", "FEUP", 126),
    ];

    List<TeacherDetails> searchResult = search(teachers, "Nome", 2);

    List<TeacherDetails> expectedTeachers = [
      new TeacherDetails("10", "Nome1", "nome1", "FEUP", 123),
      new TeacherDetails("30", "Nome2", "nome2", "FEUP", 125),
    ];

    for(int i = 0; i < searchResult.length; i++){
      expect(teacherEquals(searchResult[i], expectedTeachers[i]), true);
    }

  });

  test('Testing search 2', () async {
    List<TeacherDetails> teachers = [
      new TeacherDetails("10", "Nome1", "nome1", "FEUP", 123),
      new TeacherDetails("20", "Apelido1", "apelido1", "FEUP", 124),
      new TeacherDetails("30", "Nome2", "nome2", "FEUP", 125),
      new TeacherDetails("40", "Apelido2", "apelido2", "FEUP", 126),
    ];

    List<TeacherDetails> searchResult = search(teachers, "Apelido", 2);

    List<TeacherDetails> expectedTeachers = [
      new TeacherDetails("20", "Apelido1", "apelido1", "FEUP", 124),
      new TeacherDetails("40", "Apelido2", "apelido2", "FEUP", 126),
    ];

    for(int i = 0; i < searchResult.length; i++){
      expect(teacherEquals(searchResult[i], expectedTeachers[i]), true);
    }

  });

  test('Testing search 3', () async {
    List<TeacherDetails> teachers = [
      new TeacherDetails("10", "Nome1 Apelido1", "nome1 apelido1", "FEUP", 123),
      new TeacherDetails("20", "Apelido1", "apelido1", "FEUP", 124),
      new TeacherDetails("30", "Nome2 Apelido2", "nome2 apelido2", "FEUP", 125),
      new TeacherDetails("40", "Apelido2", "apelido2", "FEUP", 126),
      new TeacherDetails("50", "Nome3", "nome3", "FEUP", 127),
    ];

    List<TeacherDetails> searchResult = search(teachers, "Apelido", 2);

    List<TeacherDetails> expectedTeachers = [
      new TeacherDetails("10", "Nome1 Apelido1", "nome1 apelido1", "FEUP", 123),
      new TeacherDetails("20", "Apelido1", "apelido1", "FEUP", 124),
      new TeacherDetails("30", "Nome2 Apelido2", "nome2 apelido2", "FEUP", 125),
      new TeacherDetails("40", "Apelido2", "apelido2", "FEUP", 126),
    ];

    for(int i = 0; i < searchResult.length; i++){
      expect(teacherEquals(searchResult[i], expectedTeachers[i]), true);
    }

  });

  test('Testing search 4', () async {
    List<TeacherDetails> teachers = [
      new TeacherDetails("10", "Nome1", "nome1", "FEUP", 123),
      new TeacherDetails("20", "Apelido1", "apelido1", "FEUP", 124),
      new TeacherDetails("30", "Nome2", "nome2", "FEUP", 125),
      new TeacherDetails("40", "Apelido2", "apelido2", "FEUP", 126),
    ];

    List<TeacherDetails> searchResult = search(teachers, "Lala", 20);

    List<TeacherDetails> expectedTeachers = [
      new TeacherDetails("10", "Nome1", "nome1", "FEUP", 123),
      new TeacherDetails("20", "Apelido1", "apelido1", "FEUP", 124),
      new TeacherDetails("30", "Nome2", "nome2", "FEUP", 125),
      new TeacherDetails("40", "Apelido2", "apelido2", "FEUP", 126),
    ];

    for(int i = 0; i < searchResult.length; i++){
      expect(teacherEquals(searchResult[i], expectedTeachers[i]), true);
    }

  });
}

bool teacherEquals(TeacherDetails t1, TeacherDetails t2){
  return t1.rowid == t2.rowid && t1.name == t2.name && t1.name_simpl == t2.name_simpl && t1.faculty == t2.faculty && t1.code == t2.code;
}

bool ucEquals(UC_details uc1, UC_details uc2) {
  return uc1.nome == uc2.nome && uc1.codigo == uc2.codigo && uc1.acronimo == uc2.acronimo && uc1.faculdade == uc2.faculdade && uc1.id == uc2.id;
}
