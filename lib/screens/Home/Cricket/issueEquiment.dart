import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/table_tennis/table_tennis_issue_screen.dart';

import '../../intial_page.dart';

class CricketIssue extends StatefulWidget {
  const CricketIssue({Key? key}) : super(key: key);

  @override
  _CricketIssueState createState() => _CricketIssueState();
}

class _CricketIssueState extends State<CricketIssue> {

  final formatYMDHM = DateFormat("yyyy-MM-dd HH:mm");
  DateTime? eventDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String? chossedBall,
      chossedBat,chossedGloves,
      chossedPad,chossedInnerPad,
      chossedHelmet;

  void _selectedBall(String ball)=>chossedBall=ball;
  void _selectedBat(String bat)=>chossedBat=bat;
  void _selectedGloves(String gloves)=>chossedGloves=gloves;
  void _selectedPad(String pad)=>chossedPad=pad;
  void _selectedInnerPad(String innerPad)=>chossedInnerPad=innerPad;
  void _selectedHelmet(String hel)=>chossedHelmet=hel;

  Future _submit()async{
    if (chossedHelmet==null
    &&chossedInnerPad==null
    && chossedPad==null&&
    chossedGloves==null
    &&chossedBat==null
    &&chossedBall==null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please select at least one field',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    }else{
      FirebaseFirestore.instance.collection('CREquipment')
          .doc(UserDetails.uid).set({
        'bat': chossedBat,
        'ball':chossedBall,
        'gloves':chossedGloves,
        'pad':chossedPad,
        'innerPad':chossedInnerPad,
        'helmet':chossedHelmet,
        'timeOfIssue': Timestamp.now(),
        'timeOfReturn': Timestamp.now(),
        'isRequested': 1,
        'isReturn': false,
        'name': UserDetails.name,
        'misId': UserDetails.misId,
        'url': UserDetails.photourl,
        'uid': UserDetails.uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),content: Text(
        'Request have been send',style: TextStyle(
        color: Colors.green,
        fontSize: 15,
      ),
      )));
      Navigator.pushNamedAndRemoveUntil(context,
          IntialScreen.routeName
          , (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
   // double hei = MediaQuery.of(context).size.height;
    double wei = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/cricket.jpg'),
              fit: BoxFit.fill,
              opacity: 20,
            )),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  spreadRadius: 16,
                  color: const Color(0XFF4527A0).withOpacity(0.2),
                )
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaY: 16,
                    sigmaX: 16,
                  ),
                  child: Container(
                    //height: hei * 0.5,
                    width: wei * 0.9,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: AssetImage('assets/cricket.jpg'), fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Number of Balls',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            DropDown(
                                itemList: const ['1','2','3','4','5','6'],
                                item1: 'Ball',
                                submitFn: _selectedBall),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Number of Bat',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            DropDown(
                                itemList: const ['1', '2','3','4','5'],
                                item1: 'Bat',
                                submitFn: _selectedBat),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Number of Gloves',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            DropDown(
                                itemList: const ['1', '2','3','4','5'],
                                item1: 'Gloves',
                                submitFn: _selectedGloves),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Number of Pad',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            DropDown(
                                itemList: const ['1', '2','3','4','5'],
                                item1: 'Pad',
                                submitFn: _selectedPad),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Number of InnerPad',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            DropDown(
                                itemList: const ['1', '2','3','4','5'],
                                item1: 'InnerPad',
                                submitFn: _selectedInnerPad),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Number of Helmet',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            DropDown(
                                itemList: const ['1', '2','3','4','5'],
                                item1: 'Helmet',
                                submitFn: _selectedHelmet),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Time Of Issuement',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: DateTimeField(
                                  resetIcon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  initialValue: DateTime.now(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  enabled: true,
                                  enableInteractiveSelection: true,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                  format: formatYMDHM,
                                  onShowPicker: (context, currentValue) async {
                                    final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      initialDate:
                                      currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100),
                                    );
                                    if (date != null) {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now(),
                                        ),
                                      );
                                      eventDate =
                                          DateTimeField.combine(date, time);
                                      return DateTimeField.combine(date, time);
                                    } else {
                                      eventDate = currentValue;
                                      return currentValue;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _submit();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
