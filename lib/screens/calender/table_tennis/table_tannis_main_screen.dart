import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psa/models/userDetails.dart';
import 'package:psa/screens/calender/table_tennis/playing.dart';
import 'package:psa/screens/calender/table_tennis/popUpWidget.dart';
import 'package:psa/screens/calender/table_tennis/requests.dart';
import 'package:psa/screens/calender/table_tennis/return.dart';
import 'package:psa/screens/calender/table_tennis/table_status_popup.dart';
import 'package:psa/screens/calender/table_tennis/table_tennis_issue_screen.dart';

class TabletannisScreen extends StatefulWidget {
  @override
  State<TabletannisScreen> createState() => _TabletannisScreenState();
}

class _TabletannisScreenState extends State<TabletannisScreen> {

  late int _isRequested=0;
  bool _isFirstVisit=false;
  var _table,_noOfRacket;
  int racket1=0,racket2=0,racket3=0;

  Future TT_Logic()async{
    _isFirstVisit?Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return IssueTheRacket();
        })):_isRequested==1? showDialog(
        context: context,
        builder: (context) {
          return PopUpRequest(onTap: (){
            FirebaseFirestore.instance.collection('TTEquipment')
                //.doc('TT').collection('Equipment')
                .doc(UserDetails.uid).update({
              'isRequested':3,
            });
            setState(() {
              _isFirstVisit=true;
            });
            Navigator.pop(context);
          },
              text: 'Want to cancel the request');
          //---------
        }):_isRequested==2? showDialog(context: context,
        builder: (context){
          return ReturnPopUpWidget(
              noOfRacket: _noOfRacket,
              table: _table,
              onTap: (){
                FirebaseFirestore.instance.collection('TTEquipment')
                    //.doc('TT').collection('Equipment')
                    .doc(UserDetails.uid).update({
                  'isRequested':4,
                  'isReturn':true,
                  'timeOfReturn':Timestamp.now(),
                });
                setState(() {
                  _isFirstVisit=true;
                });
                Navigator.pop(context);
              });
        }):Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return IssueTheRacket();
        }));
  }

  Future<void> getStatus(BuildContext context)async{
    var v =await FirebaseFirestore.instance.collection('TTEquipment')
        .doc(UserDetails.uid).get();
    if (v.exists){
      _isRequested=v.get('isRequested');
      _table=v.get('tableNumber');
      _noOfRacket=v.get('racketNumber');
      if (_isRequested==3 || _isRequested==5){
        setState(() {
          _isFirstVisit=true;
        });
      }else{
        setState(() {
          _isFirstVisit=false;
        });
      }
      }
    else{
      setState(() {
        _isFirstVisit=true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getStatus(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(""
              "Table Tennis",),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Request();
              }));
            },
                icon: const Icon(Icons.request_page_outlined,size: 30,)),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Playing();
              }));
            },
                icon: const Icon(Icons.change_history_outlined,size: 30,)),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ReturnScreen();
              }));
            },
                // icon: const Icon(Icons.read_more_outlined,size: 30,)),
                icon: const Icon(Icons.compare_arrows,size: 30,)),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: ()=> getStatus(context),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.
            collection('TTEquipment').snapshots(),
            builder:(ctx, userSnapshot){
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final usersnap = userSnapshot.data!.docs;
              racket1=0;racket3=0;racket2=0;

              print('start');
              for(int i=0;i<usersnap.length;i++){
                if (usersnap[i]['tableNumber']=='Table 1'){
                  print('racket 1');
                  if (usersnap[i]['isRequested']==2){
                    racket1+=int.parse(usersnap[i]['racketNumber']);
                  }
                  print(racket1);
                }else if (usersnap[i]['tableNumber']=='Table 2'){
                  print('racket 2 initial');
                  print(racket2);
                  if (usersnap[i]['isRequested']==2){
                    racket2+=int.parse(usersnap[i]['racketNumber']);
                  }
                  print('racket 2 after');
                  print(racket2);
                }else if (usersnap[i]['tableNumber']=='Table 3'){
                  print('racket 3 inital');
                  print(racket3);
                  if (usersnap[i]['isRequested']==2){
                    racket3+=int.parse(usersnap[i]['racketNumber']);
                  }
                  print('racket 3 after');
                  print(racket3);
                }
              }
              if (racket1<0){racket1=0;}
              if (racket2<0){racket2=0;}
              if (racket3<0){racket3=0;}
              print(racket1);
              print(racket2);
              print(racket3);
              print('end');
              return  SingleChildScrollView(
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      TTWidget(tableNumber: '01',
                        enrolledSeats: racket1,
                        image: "assets/table_tenis_1.jpg",),
                      const SizedBox(
                        height: 15,
                      ),
                      TTWidget(image: "assets/table_tenis_2.jpg",
                          enrolledSeats: racket2, tableNumber: '02'),
                      const SizedBox(
                        height: 15,
                      ),
                      TTWidget(image: "assets/table_tenis_1.jpg",
                        enrolledSeats: racket3,tableNumber: '03',),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: 200,
                        height: 60,
                        // margin: const EdgeInsets.all(12.0),
                        child: RaisedButton(
                          splashColor: Colors.lightBlueAccent,
                          elevation: 10.0, shape: const StadiumBorder(),
                          child:_isFirstVisit? const Text(
                            'Issue the Racked',
                            style: TextStyle(fontSize: 16),
                          ):_isRequested==1? const Text(
                            'Cancel Request',
                            style: TextStyle(fontSize: 16),
                          ):_isRequested==2? const Text(
                            'Return the Racket',
                            style: TextStyle(fontSize: 16),
                          ):_isRequested==4?const Text(
                            'Issue the Racked',
                            style: TextStyle(fontSize: 16),
                          ): Container(),
                          onPressed: () {
                            TT_Logic();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          ),
        ));
  }
}




class TTWidget extends StatelessWidget {
  late String tableNumber;
  late String image;
  late int enrolledSeats;
  TTWidget({required this.image,
    required this.enrolledSeats,required this.tableNumber});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
              backgroundColor: Colors.lightBlueAccent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      // bottomRight: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                      topLeft: Radius.circular(56.0))),
              context: context,
              builder: (context) {
                return TableStatusPopup(
                  tableno: 'Table NO $tableNumber',
                  unEnrollSeats: enrolledSeats,
                );
              });
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: height*0.2,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                border: Border.all(color: Colors.black,width: 5),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                "TABLE NO $tableNumber",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 20,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
               // border: Border.all(color: Colors.grey,width: 5),
              ),
              child: Text(enrolledSeats.toString()),
            )
          ],
        ),
      ),
    );
  }
}
