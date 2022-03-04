import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psa/screens/Home/VolleyBall/requested.dart';

class PlayingVolly extends StatefulWidget {
  const PlayingVolly({Key? key}) : super(key: key);

  @override
  _PlayingVollyState createState() => _PlayingVollyState();
}

class _PlayingVollyState extends State<PlayingVolly> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Ball Issued'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('VVEquipment')
                .snapshots(),
            builder: (ctx, equimentSnapshot) {
              if (equimentSnapshot.connectionState
                  == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final reqMembers = equimentSnapshot.data!.docs;
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: reqMembers.length,
                  itemBuilder: (ctx, index) => reqMembers[index]['isRequested'] == 2
                      ?VVRequest(

                      isReturn: reqMembers[index]['isReturn'],
                      image: reqMembers[index]['url'],
                      uid: reqMembers[index]['uid'],
                      timeOfReturn: reqMembers[index]['timeOfReturn'],
                      timeOfIssue: reqMembers[index]['timeOfIssue'],
                      noOfBall: reqMembers[index]['noOfBall'].toString(),
                      name: reqMembers[index]['name'],
                      isAdmin: false,misId: reqMembers[index]['misId'])
                      : Container());
            },
          ),
        ));
  }
}
