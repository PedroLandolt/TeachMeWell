import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teachmewell/course.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Faculty extends StatelessWidget {
  final DocumentSnapshot faculty;

  Faculty(this.faculty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(faculty['sigla']),
          backgroundColor: const Color(0xFF2574A8),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('curso').where('faculdade', isEqualTo: faculty['sigla']).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
            itemBuilder: (context, index) => _buildListItem(context, (snapshot.data as QuerySnapshot).docs[index]),
          );
        },
      )
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    String grau = document['grau'].toString();
    String grau_abrev;
    if (grau == 'Licenciatura') {
      grau_abrev = 'L';
    } else if (grau == 'Mestrado Integrado') {
      grau_abrev = 'MI';
    } else if (grau == 'Mestrado') {
      grau_abrev = 'M';
    } else if (grau == 'Doutoramento') {
      grau_abrev = 'D';
    } else {
      grau_abrev = 'O';
    }
    return ListTile(
      title: Row(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(right: 8.0, top: 8.0),
            child: Text(
              grau_abrev,
              style: const TextStyle(fontSize: 32.0),
            ),
          ),
          Expanded(
            child: Text(
              document['nome'],
              style: const TextStyle(fontSize: 22.0),
            ),
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Course(document),
        ),
      ),
    );
  }
}

class Faculties extends StatefulWidget {
  const Faculties({Key? key}) : super(key: key);

  @override
  State<Faculties> createState() => _FacultiesState();
}

class _FacultiesState extends State<Faculties> {

  //Main page at the moment
  final String title = "TeachMeWell";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Faculdades'),
          backgroundColor: const Color(0xFF2574A8),
          actions: const [],
        ),
        body: const LisTileExample(),
    );
  }
}

class LisTileExample extends StatefulWidget {
  const LisTileExample({super.key});

  @override
  State<LisTileExample> createState() => _LisTileExampleState();
}

class _LisTileExampleState extends State<LisTileExample>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('faculdade').snapshots(),
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
            itemExtent: 80.0,
            itemCount: (snapshot.data as QuerySnapshot).docs.length,
            itemBuilder:  (context, index) =>
                build_List_Item(context, (snapshot.data as QuerySnapshot).docs[index]),
          );
        }
    );
  }

  Widget build_List_Item(BuildContext context, DocumentSnapshot document) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Hero(
          tag: 'Faculdade',
          child: Material(
            child: ListTile(
              title: Text(document["sigla"]),
              subtitle: Text(document["nome"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Faculty(document),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
