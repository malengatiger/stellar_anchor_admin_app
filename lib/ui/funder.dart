import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stellar_anchor_admin_app/ui/mobile/mobile_funder.dart';
import 'package:stellar_anchor_library/models/agent.dart';

class AgentFunder extends StatefulWidget {
  final Agent agent;

  const AgentFunder({Key key, this.agent}) : super(key: key);
  @override
  _AgentFunderState createState() => _AgentFunderState();
}

class _AgentFunderState extends State<AgentFunder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ScreenTypeLayout(
      mobile: AgentFunderMobile(widget.agent),
    ));
  }
}
