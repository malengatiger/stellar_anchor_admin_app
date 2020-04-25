import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stellar_anchor_admin_app/bloc/agent_bloc.dart';
import 'package:stellar_anchor_admin_app/models/agent.dart';
import 'package:stellar_anchor_admin_app/models/balances.dart';
import 'package:stellar_anchor_admin_app/models/client.dart';
import 'package:stellar_anchor_admin_app/ui/agent_editor.dart';
import 'package:stellar_anchor_admin_app/ui/agent_list.dart';
import 'package:stellar_anchor_admin_app/util/functions.dart';
import 'package:stellar_anchor_admin_app/util/image_handler/currency_icons.dart';
import 'package:stellar_anchor_admin_app/util/image_handler/random_image.dart';
import 'package:stellar_anchor_admin_app/util/util.dart';

class AgentDetailMobile extends StatelessWidget {
  final Agent agent;

  const AgentDetailMobile(this.agent);

  @override
  Widget build(BuildContext context) {
    var image = RandomImage.getImage();
    p('Getting agent clients from bloc .... 🥦 🥦 🥦 ...');
    List<Balances> balancesList = List();
    agentBloc.getClients(agent.agentId);
    agentBloc.getBalances(agent.stellarAccountId);
    bool isBusy = false;
    agentBloc.busyStream.listen((List<bool> busies) {
      p('Received busy shit ... 🔆 🔆 🔆 🔆 🔆 🔆 🔆 ');
    });
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
                icon: Icon(Icons.create),
                onPressed: () {
                  assert(agent != null);
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          curve: Curves.easeInOut,
                          duration: Duration(seconds: 2),
                          child: AgentEditor(
                            agent: agent,
                          )));
                }),
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  agentBloc.getClients(agent.agentId);
                  agentBloc.getBalances(agent.stellarAccountId);
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
                    agent.personalKYCFields.getFullName(),
                    style: Styles.blackBoldMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      isBusy
                          ? Container(
                              width: 20,
                              height: 20,
                              color: baseColor,
                              child: CircularProgressIndicator())
                          : Container(),
                    ],
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
                      height: 40,
                    ),
                    EmailWidget(
                      agent: agent,
                    ),
                    PhoneWidget(
                      agent: agent,
                    ),
                    AgentClientsWidget(
                      agent: agent,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    decoration: BoxDecoration(
                        boxShadow: customShadow,
                        color: baseColor,
                        shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(image),
                      radius: 100.0,
                    )),
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
                width: 180,
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
                        return ListView.builder(
                            itemCount: mBal == null ? 0 : mBal.balances.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var currency = 'XLM';
                              if (mBal.balances.elementAt(index).assetCode ==
                                  null) {
                                currency = 'XLM';
                              } else {
                                currency =
                                    mBal.balances.elementAt(index).assetCode;
                              }
                              var imagePath =
                                  CurrencyIcons.getCurrencyImagePath(currency);
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 4),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        width: 24,
                                        height: 24,
                                        child: Image.asset(imagePath)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      getFormattedAmount(
                                          mBal.balances
                                              .elementAt(index)
                                              .balance,
                                          context),
                                      style: Styles.tealBoldSmall,
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailWidget extends StatelessWidget {
  final Agent agent;

  const EmailWidget({Key key, this.agent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 12, right: 16),
      child: Container(
//        decoration: BoxDecoration(boxShadow: customShadow, color: baseColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 60,
                child: MyAvatar(
                  icon: Icon(Icons.email),
                ),
              ),
              Expanded(child: Text(agent.personalKYCFields.emailAddress))
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneWidget extends StatelessWidget {
  final Agent agent;

  const PhoneWidget({Key key, this.agent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 12, right: 16),
      child: Container(
//        decoration: BoxDecoration(boxShadow: customShadow, color: baseColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 60,
                child: MyAvatar(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                ),
              ),
              Text(agent.personalKYCFields.mobileNumber)
            ],
          ),
        ),
      ),
    );
  }
}

class AgentClientsWidget extends StatelessWidget {
  final Agent agent;

  const AgentClientsWidget({Key key, this.agent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 12, right: 16),
      child: Container(
//        decoration: BoxDecoration(boxShadow: customShadow, color: baseColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 60,
                child: MyAvatar(
                  icon: Icon(
                    Icons.people,
                    color: Colors.pink,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Text("Clients"),
                  SizedBox(
                    width: 20,
                  ),
                  StreamBuilder<List<Client>>(
                      stream: agentBloc.clientStream,
                      builder: (context, snapshot) {
                        var total = 0;
                        if (snapshot.hasData) {
                          total = snapshot.data.length;
                        }
                        return Text(
                          '$total',
                          style: Styles.blueBoldMedium,
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
