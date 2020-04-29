import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:stellar_anchor_library/models/stokvel.dart';
import 'package:stellar_anchor_library/util/functions.dart';

class PageOne extends StatelessWidget {
  final Member member;

  PageOne(this.member);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
//                  color: Colors.blue,
                  height: 300,
                  width: double.infinity,
                  child: Opacity(
                    opacity: 0.7,
                    child: Image(
                      image: AssetImage('assets/images/download1.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 28,
            ),
            Column(
              children: <Widget>[
                Text(
                  'Welcome Aboard',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                Text(
                  member == null ? '' : member.name,
                  style: Styles.greyLabelSmall,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'The Member App enables you to participate '
                'in the Stokkie Network where you can save, make or give loans',
                style: Styles.blackBoldSmall,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            DotsIndicator(
              dotsCount: 5,
              position: 0,
            ),
          ],
        ),
      ],
    );
  }
}

class PageTwo extends StatelessWidget {
  final Member member;

  PageTwo(this.member);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
//                  color: Colors.blue,
                  height: 300,
                  width: double.infinity,
                  child: Opacity(
                    opacity: 0.7,
                    child: Image(
                      image: AssetImage('assets/images/download3.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              children: <Widget>[
                Text(
                  'Community Savings',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                Text(
                  member == null ? '' : member.name,
                  style: Styles.greyLabelSmall,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('The Member App enables you to participate '
                  'in the Stokkie Network where you can save money with a group of your friends'),
            ),
            SizedBox(
              height: 16,
            ),
            DotsIndicator(
              dotsCount: 5,
              position: 1,
            ),
          ],
        ),
      ],
    );
  }
}

class PageThree extends StatelessWidget {
  final Member member;

  PageThree(this.member);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
//                  color: Colors.blue,
                  height: 300,
                  width: double.infinity,
                  child: Opacity(
                    opacity: 0.6,
                    child: Image(
                      image: AssetImage('assets/images/download4.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              children: <Widget>[
                Text(
                  'Make or Receive Loans',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                Text(
                  member == null ? '' : member.name,
                  style: Styles.greyLabelSmall,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('The Member App enables you to participate '
                  'in the Stokkie Network where you can make or receive loans'),
            ),
            SizedBox(
              height: 16,
            ),
            DotsIndicator(
              dotsCount: 5,
              position: 2,
            ),
          ],
        ),
      ],
    );
  }
}

class PageFour extends StatelessWidget {
  final Member member;

  PageFour(this.member);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
//                  color: Colors.blue,
                  height: 300,
                  width: double.infinity,
                  child: Opacity(
                    opacity: 0.6,
                    child: Image(
                      image: AssetImage('assets/images/download8.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              children: <Widget>[
                Text(
                  'Be Happy!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                Text(
                  member == null ? '' : member.name,
                  style: Styles.greyLabelSmall,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('The Member App enables you to participate '
                  'in the Stokkie Network where you can be Happy!'),
            ),
            SizedBox(
              height: 16,
            ),
            DotsIndicator(
              dotsCount: 5,
              position: 3,
            ),
          ],
        ),
      ],
    );
  }
}

class PageFive extends StatelessWidget {
  final Member member;

  PageFive(this.member);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  height: 300,
                  width: double.infinity,
                  child: AnimatedOpacity(
                    opacity: 0.2,
                    duration: Duration(milliseconds: 500),
                    child: Image(
                      image: AssetImage('assets/images/images22.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              children: <Widget>[
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                Text(
                  member == null ? '' : member.name,
                  style: Styles.greyLabelSmall,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  debugPrint('📅 📅 📅 📭 Open phone email app... 📭 ');
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.email),
                          Text(
                            'Email:',
                            style: Styles.greyLabelSmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'info@stokkie.co.za',
                            style: Styles.blackBoldSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  debugPrint('☎️ ☎️ ☎️ Open phone dialler... ☎️');
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.phone),
                          Text(
                            'Telephone:',
                            style: Styles.greyLabelSmall,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '+27 12 666 7267',
                            style: Styles.pinkBoldSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
