import 'package:hive/hive.dart';

part 'switch_status.g.dart';

@HiveType(typeId: 1)
class SwitchStatus {
  SwitchStatus({required this.status});

  @HiveField(0)
  bool status;
}
