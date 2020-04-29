import 'package:flutter/material.dart';
import 'package:stellar_anchor_admin_app/bloc/agent_bloc.dart';
import 'package:stellar_anchor_library/models/agent.dart';
import 'package:stellar_anchor_library/models/balance.dart';
import 'package:stellar_anchor_library/models/balances.dart';
import 'package:stellar_anchor_library/util/functions.dart';
import 'package:stellar_anchor_library/util/image_handler/currency_icons.dart';
import 'package:stellar_anchor_library/util/snack.dart';
import 'package:stellar_anchor_library/util/util.dart';
import 'package:stellar_anchor_library/widgets/balances_scroller.dart';
import 'package:stellar_anchor_library/widgets/currency_dropdown.dart';

class AgentFunderMobile extends StatefulWidget {
  final Agent agent;

  const AgentFunderMobile(this.agent);
  @override
  _AgentFunderMobileState createState() => _AgentFunderMobileState();
}

class _AgentFunderMobileState extends State<AgentFunderMobile>
    with SingleTickerProviderStateMixin
    implements CurrencyDropDownListener {
  AnimationController controller;
  Animation animation;
  bool isBusy = false;
  Balance _selectedBalance;
  var _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    assert(widget.agent != null);
    _setAnimation();
    _getBalances();
  }

  Balances currentBalances;
  _getBalances() async {
    setState(() {
      isBusy = true;
    });
    currentBalances =
        await agentBloc.getLocalBalances(widget.agent.stellarAccountId);
    p("🔵🔵🔵🔵🔵 _AgentFunderMobileState: 🔵 Balances: ${currentBalances.toJson()}");
    currentBalances =
        await agentBloc.getRemoteBalances(widget.agent.stellarAccountId);
    setState(() {
      isBusy = false;
    });
  }

  _setAnimation() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  _sendMoneyToAgent() async {
    if (amount == null || amount == 0.0) {
      AppSnackBar.showErrorSnackBar(
          scaffoldKey: _key, message: 'Please enter the amount');
      return;
    }

    p('MobileFunder: 🍊 🍊 🍊 send $amount to agent: 💚 ${widget.agent.toJson()} ');
    setState(() {
      isBusy = true;
    });
    try {
      await agentBloc.sendMoneyToAgent(
          amount: amount.toString(),
          agent: widget.agent,
          assetCode: _selectedBalance.assetCode);
    } catch (e) {
      p(e);
      AppSnackBar.showErrorSnackBar(
          scaffoldKey: _key, message: "Payment failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _key,
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text('Agent Funding'),
        backgroundColor: secondaryColor,
        elevation: 0,
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.agent == null
                        ? ''
                        : widget.agent.personalKYCFields.getFullName(),
                    style: Styles.blackBoldMedium,
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(60)),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration:
                  BoxDecoration(boxShadow: customShadow, color: baseColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    currentBalances == null
                        ? Container()
                        : Center(
                            child: CurrencyDropDown(
                                balances: currentBalances, listener: this),
                          ),
                    SizedBox(height: 20),
                    currentBalances == null
                        ? Container()
                        : Image.asset(
                            CurrencyIcons.getCurrencyImagePath(
                                _selectedBalance.assetCode),
                            height: 48,
                            width: 48),
                    SizedBox(height: 20),
                    TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 20,
                      style: Styles.blackBoldLarge,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Amount',
                          labelText: 'Amount'),
                      onChanged: _onAmountChanged,
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: _sendMoneyToAgent,
                      color: secondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('Send Money'),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 2,
            child: BalancesScroller(
              balances: currentBalances,
              direction: Axis.vertical,
            ),
          ),
        ],
      ),
    ));
  }

  @override
  onChanged(Balance value) {
    _selectedBalance = value;
    p('MobileFunder: 💚 💚 balance selected ${value.assetCode} ${value.balance}');
    setState(() {});
  }

  double amount;
  void _onAmountChanged(String value) {
    p('on amount changed: $value');
    amount = double.parse(value);
  }
}
