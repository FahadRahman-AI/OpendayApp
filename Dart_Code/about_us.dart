import 'package:flutter/material.dart';
import 'pages_layout.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'About Us',
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/about_us.png',
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 24.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 30),
                          child: Text(
                            'The University of Wolverhampton is a modern, dynamic university with a rich history of providing quality education dating back nearly 200 years. We are committed to helping students from diverse backgrounds achieve their potential through inclusive teaching, innovative research, and strong industry partnerships. With campuses in Wolverhampton, Walsall, and Telford, we offer a wide range of undergraduate, postgraduate, and professional courses designed to equip students with real-world skills and experiences. Our vibrant community, cutting-edge facilities, and global outlook make us a leading choice for learners seeking academic excellence and career success.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
