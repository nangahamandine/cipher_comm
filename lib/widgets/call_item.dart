import 'package:flutter/material.dart';

import '../models/call_model.dart';

class CallItem extends StatelessWidget {
  final CallModel call;

  const CallItem({required this.call});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(call.callerImage),
      ),
      title: Text(call.callerName),
      subtitle: Text(call.timestamp.toString()),
      trailing: Icon(
        call.status == CallStatus.outgoing ? Icons.call_made : Icons.call_received,
        color: call.status == CallStatus.outgoing ? Colors.green : Colors.red,
      ),
    );
  }
}
