import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'dart:collection';
import 'package:teachmewell/teacher.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class MyMessages extends StatefulWidget {
  final int studentID;

  MyMessages(this.studentID);

  @override
  _MyMessagesState createState() => _MyMessagesState(studentID);
}
class _MyMessagesState extends State<MyMessages> {
  final int studentID;

  HashMap<int, DocumentSnapshot> teachers = HashMap<int, DocumentSnapshot>();

  _MyMessagesState(this.studentID){
    getTeachers().then((value) => setState(() {
      teachers = value;
    }));
  }

  Future<HashMap<int, DocumentSnapshot>> getTeachers() async {
    HashMap<int, DocumentSnapshot> teachers_temp = HashMap<int, DocumentSnapshot>();
    var avaliacoes = await FirebaseFirestore.instance.collection('avaliacao')
        .where('studentID', isEqualTo : studentID).get();
    for(int i = 0; i < avaliacoes.docs.length; i++){
      var prof = await FirebaseFirestore.instance.collection('professor')
          .where('codigo', isEqualTo : int.parse(avaliacoes.docs[i]['teacherID']))
          .get();
        // names[i] = "lala($i)lala";
      teachers_temp[int.parse(avaliacoes.docs[i]['teacherID'])] = prof.docs[0];
    }
    return teachers_temp;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: const Text('Meus Comentários'),
      backgroundColor: const Color(0xFF2574A8),
      actions: const [],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('avaliacao').where('studentID', isEqualTo : studentID).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 75,
                    width: 75,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballSpinFadeLoader,
                        colors: [Color(0xFF2574A8)],
                        strokeWidth: 10,
                        backgroundColor: Colors.transparent,
                        pathBackgroundColor: Colors.transparent
                    ),
                  )
                ],
              ),
            );
            }
            return ListView.builder(
              itemCount: (snapshot.data as QuerySnapshot).docs.length,
              itemBuilder:  (context, index) =>
                  _buildListItem(context, (snapshot.data as QuerySnapshot).docs[index]),
            );
          }
      )
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document2) {
    try{
      if(document2['titulo']==null || document2['media_single']==null) {
        return Container();
      }
    }catch(e){
      return Container();
    }

    DocumentSnapshot? teacher = teachers[int.parse(document2['teacherID'])];

    if(teacher == null) {
      return Container();
    }

    double media_comment = double.parse(document2['media_single'].toStringAsFixed(1));
    late ValueNotifier<double> valueNotifier = ValueNotifier(media_comment*20);

    return ListTile(
        title: Row(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(right: 8.0, top: 8.0),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF2574A8),
                radius: 28,
                child: CircleAvatar(
                  foregroundImage: NetworkImage('https://sigarra.up.pt/${teacher['faculdade'].toString().toLowerCase()}/pt/FOTOGRAFIAS_SERVICE.foto?pct_cod=${teacher['codigo']}'),
                  backgroundImage: const NetworkImage('https://www.der-windows-papst.de/wp-content/uploads/2019/03/Windows-Change-Default-Avatar-448x400.png'),
                  radius: 25,
                  onBackgroundImageError: (e, s) {
                    debugPrint('image issue, $e,$s');
                  },
                ),
              ),
            ),
            Expanded(
              child: Text(
                teacher['nome'],
                style: const TextStyle(fontSize: 19.0),
              ),
            ),
            SimpleCircularProgressBar(
              size: 35,
              progressStrokeWidth: 5,
              backStrokeWidth: 0,
              valueNotifier: valueNotifier,
              mergeMode: true,
              animationDuration: 2,
              progressColors: const [Colors.orange],
              onGetText: (double value) {
                return Text(
                  document2['media_single'].toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            scrollable: true,
            content: Column(
              children: [
                InkWell(
                  child: Text(teacher['nome'],
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center
                          ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeacherPage(teacher)),
                    );
                  },
                ),
                const SizedBox(child: Text('Bom Relacionamento com os Estudantes'),),
                SizedBox(
                  child: FlutterRating (rating: document2['bom relacionamento com os estudantes'], size: 40, color: Colors.orange),
                ),
                const SizedBox(child: Text('Capacidade de Estimular o Interesse'),),
                SizedBox(
                  child: FlutterRating (rating: document2['capacidade de estimular o interesse'], size: 40, color: Colors.orange),
                ),
                const SizedBox(child: Text('Cumprimento das Regras de Avaliação'),),
                SizedBox(
                  child: FlutterRating (rating: document2['cumprimento das regras de avaliacao'], size: 40, color: Colors.orange),
                ),
                const SizedBox(child: Text('Disponibilidade'),),
                SizedBox(
                  child: FlutterRating (rating: document2['disponibilidade'], size: 40, color: Colors.orange),
                ),
                const SizedBox(child: Text('Empenho'),),
                SizedBox(
                  child: FlutterRating (rating: document2['empenho'], size: 40, color: Colors.orange),
                ),
                const SizedBox(child: Text('Exigência'),),
                SizedBox(
                  child: FlutterRating (rating: document2['exigencia'], size: 40, color: Colors.orange),
                ),
                const SizedBox(child: Text('Organização dos Conteúdos'),),
                SizedBox(
                  child: FlutterRating (rating: document2['organizacao dos conteudos'], size: 40, color: Colors.orange),
                ),
                const SizedBox(child: Text('Promoção da Reflexão'),),
                SizedBox(
                  child: FlutterRating (rating: document2['promocao da reflexao'], size: 40, color: Colors.orange),
                ),
                const SizedBox(child: Text('Qualidade do Ensino'),),
                SizedBox(
                  child: FlutterRating (rating: document2['qualidade do ensino'], size: 40, color: Colors.orange),
                ),
                Container(
                    height: 50,
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: Center(
                      child: Text(document2['titulo']),
                    )
                ),
                Container(
                    height: 220,
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: SizedBox(
                      child: SingleChildScrollView(
                        child: Text(document2['comentario']),
                      ),
                    )
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}