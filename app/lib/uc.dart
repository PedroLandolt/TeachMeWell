import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teachmewell/sigarra/scraper.dart';
import 'package:teachmewell/teacher.dart';
import 'package:loading_indicator/loading_indicator.dart';

class UC extends StatefulWidget {
  final DocumentSnapshot uc;

  UC(this.uc);

  @override
  _UCState createState() {
    return new _UCState(uc);
  }
}

class _UCState extends State<UC> {
  final DocumentSnapshot uc;

  List<DocumentSnapshot> teacherList = [];

  _UCState(this.uc) {
    getUCTeachers(uc['faculdade'], uc['id']).then((value) => setState(() {
      teacherList = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(uc['nome']),
          backgroundColor: const Color(0xFF2574A8),
        ),
        body: teacherList.isEmpty? Center(
          child:
          Center(
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
                      strokeWidth: 0,
                      backgroundColor: Colors.transparent,
                      pathBackgroundColor: Colors.transparent
                  ),
                )
              ],
            ),
          ),
        ) : ListView.builder(
          itemCount: teacherList.length,
          itemBuilder: (_, index) {
            return _buildListItem(context, teacherList[index]);
          },
        )
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
        title: Row(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 5,
                top: 8,
                right: 15,
                bottom: 8,
              ),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF2574A8),
                radius: 33,
                child: CircleAvatar(
                  foregroundImage: NetworkImage('https://sigarra.up.pt/${document['faculdade'].toString().toLowerCase()}/pt/FOTOGRAFIAS_SERVICE.foto?pct_cod=${document['codigo']}'),
                  backgroundImage: const NetworkImage('https://www.der-windows-papst.de/wp-content/uploads/2019/03/Windows-Change-Default-Avatar-448x400.png'),
                  radius: 30,
                  onBackgroundImageError: (e, s) {
                    debugPrint('image issue, $e,$s');
                  },
                ),
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherPage(document),
            ),
          );
        }
    );
  }
}
