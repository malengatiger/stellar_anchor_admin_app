import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stellar_anchor_admin_app/bloc/agent_bloc.dart';
import 'package:stellar_anchor_admin_app/ui/agent_details.dart';
import 'package:stellar_anchor_admin_app/ui/agent_editor.dart';
import 'package:stellar_anchor_library/models/agent.dart';
import 'package:stellar_anchor_library/models/anchor.dart';
import 'package:stellar_anchor_library/util/functions.dart';
import 'package:stellar_anchor_library/util/util.dart';
import 'package:stellar_anchor_library/widgets/avatar.dart';

class AgentList extends StatefulWidget {
  @override
  _AgentListState createState() => _AgentListState();
}

class _AgentListState extends State<AgentList>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation animation, animation2;
  bool productionMode = false;
  bool isBusy;

  @override
  void initState() {
    super.initState();
    _setProductionStatus();
    _setAnimation();
    _listenForBusy();
    _refresh();
  }

  _setProductionStatus() async {
    productionMode = await isProductionMode();
  }

  _setAnimation() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(animController);
    animation2 = Tween(begin: 1.0, end: 0.0).animate(animController);
    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        p(".......... 💦 💦 💦 Forward Animation completed");
      }
    });
  }

  List<Agent> _agents = List();
  Anchor _anchor;

  _listenForBusy() {
    agentBloc.busyStream.listen((List<bool> mBusy) {
      if (mounted) {
        setState(() {
          isBusy = mBusy.last;
        });
      }
    });
  }

  _refresh() async {
    p('🥦 AgentList: refresh base data 🥦 🥦 🥦  ...');
    setState(() {
      isBusy = true;
    });
    _anchor = await agentBloc.getAnchor();
    if (_anchor != null) {
      _agents = agentBloc.agents;
      if (_agents.isEmpty) {
        _agents = await agentBloc.getAgents(_anchor.anchorId);
      }
      setState(() {
        isBusy = false;
      });
    }
  }

  _navigateToAgentDetails(Agent agent) {
    p("🚈 _navigateToAgentDetails ...");
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            curve: Curves.easeInOut,
            duration: Duration(seconds: 2),
            child: AgentDetail(
              agent: agent,
            )));
  }

  _navigateToAgentEditor({Agent agent}) {
    p("🚈 🔆 🔆 _navigateToAgentDetails ...");
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.centerRight,
          duration: Duration(seconds: 1),
          child: AgentEditor(
            agent: agent,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[100],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        _anchor == null ? '' : _anchor.name,
                        style: Styles.blackBoldMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(60)),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                agentBloc.getAgents(_anchor.anchorId);
              }),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _navigateToAgentEditor();
              }),
        ],
        title: Text(
          "Agent List",
          style: Styles.blackSmall,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: StreamBuilder<List<Agent>>(
                stream: agentBloc.agentStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _agents = snapshot.data;
                  }

                  return ListView.builder(
                      itemCount: _agents.length,
                      itemBuilder: (context, index) {
                        var mAgent = _agents.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 12),
                          child: GestureDetector(
                            onTap: () {
                              _navigateToAgentDetails(mAgent);
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  boxShadow: customShadow, color: baseColor),
                              child: ListTile(
                                leading: RoundAvatar(
                                  path: mAgent.url == null
                                      ? 'assets/logo/logo.png'
                                      : mAgent.url,
                                  radius: mAgent.url == null ? 20 : 48,
                                  fromNetwork:
                                      mAgent.url == null ? false : true,
                                ),
                                title: Text(
                                  _agents
                                      .elementAt(index)
                                      .personalKYCFields
                                      .getFullName(),
                                  style: Styles.blackSmall,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
          Positioned(
            right: 20,
            top: 0,
            child: Container(
              width: _agents.length < 100000 ? 80 : 90,
              height: _agents.length < 100000 ? 80 : 90,
              decoration: BoxDecoration(
                  boxShadow: customShadow,
                  color: secondaryColor,
                  shape: BoxShape.circle),
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      boxShadow: customShadow,
                      color: baseColor,
                      shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      "${_agents.length}",
                      style: Styles.blackBoldSmall,
                    ),
                  ),
                ),
              ),
            ),
          ),
          isBusy
              ? Positioned(
                  left: 20,
                  top: 8,
                  child: Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  double left = 40.0, bottom, top = 40, right;
  bool isUp = true;

  _moveUp() {
    setState(() {
      left = 40;
      bottom = 60;
    });
  }

  _moveDown() {
    setState(() {
      left = 40;
      bottom = 40;
    });
  }
}
