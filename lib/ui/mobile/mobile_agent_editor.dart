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
    assert(widget.agent != null);
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

class _PageUnoState extends State<PageUno> with SingleTickerProviderStateMixin {
  var _formState = GlobalKey<FormState>();
  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var emailController = TextEditingController();
  var cellController = TextEditingController();
  @override
  void initState() {
    super.initState();

    if (widget.agent != null) {
      fNameController.text = widget.agent.personalKYCFields.firstName;
      lNameController.text = widget.agent.personalKYCFields.lastName;
      emailController.text = widget.agent.personalKYCFields.emailAddress;
      cellController.text = widget.agent.personalKYCFields.mobileNumber;
    } else {
      p('MobileAgentEditor - agent is null 🔆 🔆 🔆 ');
    }
  }

  double height = 600, width = 400;
  bool isBusy = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formState,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: fNameController,
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
              controller: lNameController,
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
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter Email',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: cellController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Cellphone Number',
                hintText: 'Enter Cellphone Number',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Cellphone Number';
                }
                return null;
              },
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              child: RaisedButton(
                  color: baseColor,
                  elevation: 4,
                  onPressed: () {
                    setState(() {
                      isBusy = !isBusy;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: isBusy
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Next',
                            style: Styles.blueSmall,
                          ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
