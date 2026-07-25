/// نموذج سجل الاتصال
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_log_model.freezed.dart';
part 'connection_log_model.g.dart';

@freezed
class ConnectionLogModel with _$ConnectionLogModel {
  const factory ConnectionLogModel({
    required String id,
    required String ip,
    required int port,
    @Default('pending') String status,
    String? errorMessage,
    DateTime? timestamp,
  }) = _ConnectionLogModel;

  factory ConnectionLogModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectionLogModelFromJson(json);

  /// إنشاء نموذج فارغ
  factory ConnectionLogModel.empty() => const ConnectionLogModel(
        id: '',
        ip: '',
        port: 0,
      );

  /// إنشاء سجل اتصال جديد
  factory ConnectionLogModel.create({
    required String ip,
    required int port,
    required String status,
    String? errorMessage,
  }) =>
      ConnectionLogModel(
        id: _generateId(),
        ip: ip,
        port: port,
        status: status,
        errorMessage: errorMessage,
        timestamp: DateTime.now(),
      );
}

String _generateId() {
  return '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
}
