import 'package:stellar_anchor_admin_app/models/balance.dart';

class Balances {
  /*
    List<AccountResponse.Balance> balances;
        String account;
        private Long sequenceNumber;
   */
  String account;
  int sequenceNumber;
  List<Balance> balances;

  Balances(this.account, this.sequenceNumber, this.balances); //

  Balances.fromJson(Map data) {
    this.account = data['account'];
    this.sequenceNumber = data['sequenceNumber'];
    balances = List();
    if (data['balances'] != null) {
      List mBalances = data['balances'];
      mBalances.forEach((element) {
        balances.add(Balance.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() {
    List<Map> mMap = List();
    balances.forEach((element) {
      mMap.add(element.toJson());
    });
    Map<String, dynamic> map = Map();
    map['account'] = account;
    map['sequenceNumber'] = sequenceNumber;
    map['balances'] = mMap;
    return map;
  }
}
