enum CallStatus {
  incoming,
  outgoing,
  answered,
  missed,
}

class CallModel {
  final String id;
  final String callerId;
  final String receiverId;
  final DateTime timestamp;
  final CallStatus status;
  final String callerName; // Add this property
  final String callerImage;

  CallModel({
    required this.id,
    required this.callerId,
    required this.receiverId,
    required this.timestamp,
    required this.status,
    required this.callerName,
    required this.callerImage,
  });
}
