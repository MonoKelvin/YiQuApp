import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:yiqu/data/User.dart';

void main() {
  test("test login", () async {
    try {
      var str = await File("assets/datas/user.json").readAsString();
      var user = User.fromJson(json.decode(str));
      print(user.getPassword);
      expect(user.getPassword, equals("WarMachineCoolX"));
    } catch (err) {
      print(err);
    }
  });
}
