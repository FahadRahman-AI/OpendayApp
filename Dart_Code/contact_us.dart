import 'package:flutter/material.dart';
import 'about_us.dart';
import 'what_to_do.dart';
import 'intro_screen.dart';
import 'pages_layout.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(

      title: 'Contact Us',
      body: ListView(
        //Create expanding tiles for contact information
        children: [
          //Each tile can be clicked to expand for an answer
          ExpansionTile(
            title: Text("How can I contact the university?"),
            children: [
              ListTile(
                title: Text("Main Telephone: 01902 321 000"),
              ),
              ListTile(
                title: Text("General Enquiries Email: enquiries@wlv.ac.uk"),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Where can I get help or more information?"),
            children: [
              ListTile(
                title: Text("ASK@WLV"),
                subtitle: Text("Tel: +44 (0) 1902 323 505"),
              ),
              ListTile(
                title: Text("Email: enquiries@wlv.ac.uk"),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Who do I contact about admissions?"),
            children: [
              ListTile(
                title: Text("Tel: 0800 953 3222"),
              ),
              ListTile(
                title: Text("Email: admissions@wlv.ac.uk"),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Who do I contact regarding my application?"),
            children: [
              ListTile(
                title: Text("Application Support Tel: +44 (0) 1902 322 736"),
              ),
              ListTile(
                title: Text("Email: enquiries@wlv.ac.uk"),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Who handles media or press enquiries?"),
            children: [
              ListTile(
                title: Text("Corporate Communications Team"),
              ),
              ListTile(
                title: Text("Tel: +44 (0) 1902 322 474"),
              ),
              ListTile(
                title: Text("Email: comms@wlv.ac.uk"),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Who do I contact as an international student?"),
            children: [
              ListTile(
                title: Text("Tel: +44 (0) 1902 518 518"),
              ),
              ListTile(
                title: Text("Email: international@wlv.ac.uk"),
              ),
              ListTile(
                title: Text("Use the International Enquiry Form on the website"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
