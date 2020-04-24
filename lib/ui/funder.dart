import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stellar_anchor_admin_app/models/agent.dart';
import 'package:stellar_anchor_admin_app/ui/mobile/mobile_funder.dart';
import 'package:stellar_anchor_admin_app/util/functions.dart';

class AgentFunder extends StatefulWidget {
  final Agent agent;

  const AgentFunder({Key key, this.agent}) : super(key: key);
  @override
  _AgentFunderState createState() => _AgentFunderState();
}

class _AgentFunderState extends State<AgentFunder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Agent Funding'),
              backgroundColor: Colors.brown[100],
              bottom: PreferredSize(
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.agent == null
                            ? ''
                            : widget.agent.personalKYCFields.getFullName(),
                        style: Styles.blackBoldMedium,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  preferredSize: Size.fromHeight(60)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ScreenTypeLayout(
                mobile: AgentFunderMobile(
                  agent: widget.agent,
                ),
              ),
            )));
  }
}
