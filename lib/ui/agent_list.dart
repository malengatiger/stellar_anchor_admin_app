import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stellar_anchor_admin_app/bloc/agent_bloc.dart';
import 'package:stellar_anchor_admin_app/models/agent.dart';
import 'package:stellar_anchor_admin_app/models/anchor.dart';
import 'package:stellar_anchor_admin_app/ui/agent_details.dart';
import 'package:stellar_anchor_admin_app/ui/agent_editor.dart';
import 'package:stellar_anchor_admin_app/util/functions.dart';
import 'package:stellar_anchor_admin_app/util/util.dart';

class AgentList extends StatefulWidget {
  @override
  _AgentListState createState() => _AgentListState();
}

class _AgentListState extends State<AgentList>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation animation, animation2;

  @override
  void initState() {
    super.initState();
    _setAnimation();
    _listenForBusy();
    _refresh();
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
  bool isBusy = false;

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
            curve: Curves.easeInBack,
            duration: Duration(seconds: 1),
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
            child: Column(
              children: <Widget>[
                Text(
                  _anchor.name == null ? '' : _anchor.name,
                  style: Styles.blackBoldMedium,
                ),
              ],
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
            padding: const EdgeInsets.only(top: 28.0),
            child: StreamBuilder<List<Agent>>(
                stream: agentBloc.agentStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _agents = snapshot.data;
                  }
                  return ListView.builder(
                      itemCount: _agents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 12),
                          child: GestureDetector(
                            onTap: () {
                              _navigateToAgentDetails(_agents.elementAt(index));
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  boxShadow: customShadow, color: baseColor),
                              child: ListTile(
                                leading: MyAvatar(
                                  icon: Icon(Icons.person),
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
            left: left,
            bottom: bottom,
            right: right,
            top: top,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isBusy = true;
                  if (isUp) {
                    _moveDown();
                  } else {
                    _moveUp();
                  }
                  isUp = !isUp;
                });
                _refresh();
                if (isUp) {
                  _moveDown();
                } else {
                  _moveUp();
                }
              },
              child: Card(
                child: Container(
                  decoration:
                      BoxDecoration(boxShadow: customShadow, color: baseColor),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                              boxShadow: customShadow,
                              color: baseColor,
                              shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              "${_agents.length}",
                              style: Styles.pinkBoldMedium,
                            ),
                          ),
                        ),
                        Text('Agents'),
                      ],
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

  double left = 40.0, bottom = 40.0, top, right;
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

class MyAvatar extends StatelessWidget {
  final Icon icon;

  const MyAvatar({Key key, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
          boxShadow: customShadow, color: baseColor, shape: BoxShape.circle),
      child: icon,
    );
  }
}

class TransitionListTile extends StatelessWidget {
  const TransitionListTile({
    this.onTap,
    this.title,
    this.subtitle,
  });

  final GestureTapCallback onTap;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black54,
          ),
        ),
        child: Icon(
          Icons.play_arrow,
          size: 35,
        ),
      ),
      onTap: onTap,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
