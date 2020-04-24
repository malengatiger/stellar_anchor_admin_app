import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stellar_anchor_admin_app/models/agent.dart';
import 'package:stellar_anchor_admin_app/ui/mobile/mobile_agent_detail.dart';

class AgentDetail extends StatefulWidget {
  final Agent agent;

  const AgentDetail({Key key, this.agent}) : super(key: key);
  @override
  _AgentDetailState createState() => _AgentDetailState();
}

class _AgentDetailState extends State<AgentDetail> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AgentDetailMobile(agent: widget.agent),
    );
  }
}
