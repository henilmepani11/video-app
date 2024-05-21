import 'package:flutter/cupertino.dart';

class InterestedProvider extends ChangeNotifier {
  List localInterestList = [];
  void localInterestListFunction({String? id}) {
    localInterestList.add(id);
    notifyListeners();
  }
}
