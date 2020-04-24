import 'package:flutter/material.dart';
import 'package:stellar_anchor_admin_app/bloc/agent_bloc.dart';
import 'package:stellar_anchor_admin_app/models/agent.dart';
import 'package:stellar_anchor_admin_app/models/balances.dart';
import 'package:stellar_anchor_admin_app/util/functions.dart';

class AgentFunderMobile extends StatefulWidget {
  final Agent agent;

  const AgentFunderMobile({Key key, this.agent}) : super(key: key);
  @override
  _AgentFunderMobileState createState() => _AgentFunderMobileState();
}

class _AgentFunderMobileState extends State<AgentFunderMobile>
    with SingleTickerProviderStateMixin {
  Balances _balances;
  AnimationController controller;
  Animation animation;
  bool isBusy = false;

  @override
  void initState() {
    super.initState();
    _setAnimation();
    _getBalances();
  }

  _getBalances() async {
    _balances = await agentBloc.getBalances(widget.agent.stellarAccountId);
  }

  _setAnimation() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Agent Funding'),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.agent.personalKYCFields.getFullName(),
                    style: Styles.blackBoldMedium,
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(60)),
      ),
      body: Stack(
        children: <Widget>[],
      ),
    ));
  }
}
