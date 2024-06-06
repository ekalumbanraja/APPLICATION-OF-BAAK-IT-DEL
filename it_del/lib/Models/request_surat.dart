import 'package:it_del/Models/user.dart';

class RequestSurat {
  int? id;
  User? user;
  int? approverId;
  String? reason;
  String? status;

  RequestSurat({
    this.id,
    this.user,
    this.approverId,
    this.reason,
    this.status,
  });
  factory RequestSurat.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return RequestSurat();
    }

    return RequestSurat(
      id: json['id'] as int?,
      approverId: json['approver_id'] as int?,
      reason: json['reason'] as String?,
      status: json['status'] as String?,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}
