import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stellar_anchor_admin_app/bloc/agent_bloc.dart';
import 'package:stellar_anchor_admin_app/ui/agent_editor.dart';
import 'package:stellar_anchor_admin_app/ui/funder.dart';
import 'package:stellar_anchor_library/models/agent.dart';
import 'package:stellar_anchor_library/models/balances.dart';
import 'package:stellar_anchor_library/models/client.dart';
import 'package:stellar_anchor_library/util/functions.dart';
import 'package:stellar_anchor_library/util/image_handler/random_image.dart';
import 'package:stellar_anchor_library/util/util.dart';
import 'package:stellar_anchor_library/widgets/agent_widgets.dart';
import 'package:stellar_anchor_library/widgets/avatar.dart';
import 'package:stellar_anchor_library/widgets/balances_scroller.dart';
import 'package:stellar_anchor_library/widgets/contact_widgets.dart';
import 'package:stellar_anchor_library/widgets/sizes.dart';

class AgentDetailMobile extends StatefulWidget {
  final Agent agent;
  const AgentDetailMobile(this.agent);

  @override
  _AgentDetailMobileState createState() => _AgentDetailMobileState();
}

class _AgentDetailMobileState extends State<AgentDetailMobile> {
  bool weAreInProduction = false;
  List<Balances> balancesList = List();
  Balances currentBalances;
  List<Client> clients = [];
  String path;
  bool isBusy = false;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  _setup() async {
    weAreInProduction = await isProductionMode();
    path = RandomImage.getImagePath();
    clients = await agentBloc.getClients(agentId: widget.agent.agentId);
    currentBalances =
        await agentBloc.getLocalBalances(widget.agent.stellarAccountId);
    if (mounted) {
      setState(() {});
    }
    currentBalances =
        await agentBloc.getRemoteBalances(widget.agent.stellarAccountId);
    if (mounted) {
      setState(() {});
    }
    p('🎁 Clients and Balances received in UI ... 🔆 🔆 🔆 🔆 🔆 🔆 🔆 ');
    agentBloc.busyStream.listen((List<bool> busies) {
      p('Received busy status ... 🔆 🔆 🔆  ${busies.last}');
      if (mounted) {
        setState(() {
          isBusy = busies.last;
        });
      }
    });
  }

  String getPath() {
    path = RandomImage.getImagePath();
    if (weAreInProduction) {
      if (widget.agent.url == null) {
        return 'assets/logo/logo.png';
      } else {
        return widget.agent.url;
      }
    } else {
      if (widget.agent.url != null) {
        return widget.agent.url;
      }
      return path;
    }
  }

  @override
  Widget build(BuildContext context) {
    p('Getting agent clients from bloc .... 🥦 🥦 🥦 ...');
    var width = displayWidth(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Agent Details",
            style: Styles.blackSmall,
          ),
          backgroundColor: Colors.brown[100],
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.attach_money),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          curve: Curves.easeInOut,
                          duration: Duration(seconds: 2),
                          child: AgentFunder(
                            agent: widget.agent,
                          )));
                }),
            IconButton(
                icon: Icon(Icons.create),
                onPressed: () {
                  assert(widget.agent != null);
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          curve: Curves.easeInOut,
                          duration: Duration(seconds: 2),
                          child: AgentEditor(
                            agent: widget.agent,
                          )));
                }),
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  agentBloc.getClients(
                      agentId: widget.agent.agentId, refresh: true);
                  agentBloc.getRemoteBalances(widget.agent.stellarAccountId);
                }),
          ],
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.agent.personalKYCFields.getFullName(),
                    style: Styles.blackBoldMedium,
                  ),
                  SizedBox(
                    height: 0,
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.brown[100],
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 20,
              top: 40,
              child: Container(
                width: 320,
                height: 300,
                decoration:
                    BoxDecoration(boxShadow: customShadow, color: baseColor),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: isBusy ? 10 : 40,
                    ),
                    EmailWidget(
                      emailAddress: widget.agent.personalKYCFields.emailAddress,
                    ),
                    PhoneWidget(
                      phoneNumber: widget.agent.personalKYCFields.mobileNumber,
                    ),
                    AgentClientsWidget(
                      agent: widget.agent,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 70,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: RoundAvatar(
                    path: getPath(),
                    radius: 200,
                    fromNetwork: weAreInProduction),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 88,
              child: Text('Balances'),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: Container(
                width: width - 40,
                height: 60,
                decoration:
                    BoxDecoration(boxShadow: customShadow, color: baseColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<List<Balances>>(
                      stream: agentBloc.balancesStream,
                      builder: (context, snapshot) {
                        Balances mBal;
                        if (snapshot.hasData) {
                          p('👽 👽 👽 👽 balances delivered via stream ... 👽 👽 👽 ');
                          balancesList = snapshot.data;
                          mBal = balancesList.last;
                        }
                        return Center(
                          child: BalancesScroller(
                            balances: mBal,
                            direction: Axis.horizontal,
                          ),
                        );
                      }),
                ),
              ),
            ),
            isBusy
                ? Positioned(
                    left: 20,
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
