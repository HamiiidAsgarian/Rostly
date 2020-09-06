import 'package:shared_preferences/shared_preferences.dart';

class EntryCounter {
  static Future<int> load() async {
    final pres = await SharedPreferences.getInstance();
    final stNum = pres.getInt("myvalue");
    if (stNum == null) {
      return 0;
    } else {
      return stNum;
    }
  }

  static run() async {
    final pres = await SharedPreferences.getInstance();
    int lastStartUpnum = await load();
    int currentNumber = ++lastStartUpnum;
    await pres.setInt("myvalue", currentNumber);

    // setState(() {
    //   counter = currentNumber;
    // });
    print("Entry number is $currentNumber");
    return currentNumber;
  }
}
