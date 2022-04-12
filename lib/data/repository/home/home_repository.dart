import 'package:flutter_app_template/data/model/result/result.dart';

abstract class HomeRepository {
  Future<Result<int>> fetch();
}
