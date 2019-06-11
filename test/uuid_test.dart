import 'package:flutter_test/flutter_test.dart';
import 'package:yiqu/data/User.dart';

void main() {
  test("test uuid", () async {
    try {
      User user = new User();
      print(user.getUuid);
    } catch (err) {
      print(err);
    }
  });
}
