import 'package:flutter/material.dart';
import 'package:stellar_anchor_admin_app/models/agent.dart';
import 'package:stellar_anchor_admin_app/util/functions.dart';
import 'package:stellar_anchor_admin_app/util/util.dart';

class AgentEditorMobile extends StatefulWidget {
  final Agent agent;

  const AgentEditorMobile({Key key, this.agent}) : super(key: key);
  @override
  _AgentEditorMobileState createState() => _AgentEditorMobileState();
}

class _AgentEditorMobileState extends State<AgentEditorMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          PageUno(
            agent: widget.agent,
          ),
        ],
      ),
    );
  }
}

class PageUno extends StatefulWidget {
  final Agent agent;

  const PageUno({Key key, this.agent}) : super(key: key);
  @override
  _PageUnoState createState() => _PageUnoState();
}

class _PageUnoState extends State<PageUno> {
  var _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formState,
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'First Name',
                hintText: 'Enter First Name',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Agent First Name';
                }
                return null;
              },
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Last Name',
                hintText: 'Enter Last Name',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Agent Last Name';
                }
                return null;
              },
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: RaisedButton(
                  color: baseColor,
                  onPressed: () {
                    p('Next Pressed');
                  },
                  child: Text(
                    'Next',
                    style: Styles.blueSmall,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
