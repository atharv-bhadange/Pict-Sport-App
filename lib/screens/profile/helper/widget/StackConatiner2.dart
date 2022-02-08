import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/screens/profile/helper/widget/custom_clipper2.dart';
import '../../profile_edit_srcreen.dart';

class StackContainer2 extends StatelessWidget {
  String? imageUrl;
  String? name;
  String? branch;
  String? dob;
  String? rollNo;
  String? headLine;
  String? location;

  StackContainer2({
    this.rollNo,this.headLine,
    this.dob,this.branch,this.location
    ,this.imageUrl,this.name
});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper2(),
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black, width: 5),
                // decoration:   BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(6, 3), // changes position of shadow
                  ),
                ],
                //BoxShadow
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9DcR1UKPNaaRtjfAEojtO_lbwggqEPUfgow&usqp=CAU"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Align(
            alignment:  const Alignment(1,0.3),
              child: IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.pencilAlt,
                    size: 29,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return EditProfileScreen();
                        }));
                  }),
          ),
          Positioned(
            top: 120,
            left: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(imageUrl!),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    name!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     headLine==''?Container(): Text(
                        headLine??'',
                        style: const TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                      rollNo==''?Container(): Text(
                            rollNo??'',
                        style: const TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pune Institute of Computer Technology, Pune.",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      branch==''?Container(): Text(
                        branch??'',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      dob==''?Container(): Text(
                        dob??'',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      location==''?Container(): Text(
                        location??'',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ),
          // TopBar(),
        ],
      ),
    );
  }
}

class EmailORMisId2 extends StatefulWidget {
  String? mail;
  String? misid;
  EmailORMisId2({required this.mail, required this.misid});
  @override
  _EmailORMisId2State createState() => _EmailORMisId2State();
}

class _EmailORMisId2State extends State<EmailORMisId2> {
  bool _isMail = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0), // shadow direction: bottom right
              )
            ],
            color: Colors.white,
            border: Border.all(color: Colors.grey)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 15.0,
              ),
              child: Icon(
                Icons.mail,
                size: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Icon(
                  //   Icons.mail,
                  //   size: 35,
                  // ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMail = false;
                          });
                        },
                        child: Text(
                          "MIS ID",
                          style: TextStyle(
                            color: !_isMail ? Colors.black : Colors.grey,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const Text(
                        " / ",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMail = true;
                          });
                        },
                        child: Text(
                          "EMAIL ID",
                          style: TextStyle(
                            color: _isMail ? Colors.black : Colors.grey,
                            fontSize: 18.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: 250,
                    child: SelectableText(
                      _isMail ? '${widget.mail}' : '${widget.misid}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
