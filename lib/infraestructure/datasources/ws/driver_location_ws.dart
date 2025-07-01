import 'dart:async';
import 'dart:developer';

import 'package:gtu_mobile/config/constants/api.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class DriverLocationWs {
  final String url;
  late StompClient _client;

  DriverLocationWs(this.url);

  final StreamController<String> _messages =
      StreamController<String>.broadcast();
  Stream<String> get messages => _messages.stream;

  void connect() {
    _client = StompClient(
      config: StompConfig(
        url: url,
        onConnect: onConnect,
        beforeConnect: () async {
          await Future.delayed(Duration(milliseconds: 200));
        },
        onWebSocketError: (dynamic error) => log('WebSocket error: $error'),
        onStompError: (dynamic error) => log('STOMP error: $error'),
        onDisconnect: (_) => log('Desconectado'),
        onDebugMessage: (msg) => log('DEBUG: $msg'),
      ),
    );

    _client.activate();
  }

  void onConnect(StompFrame frame) {
    _client.subscribe(
      destination: Api.subcriptionsLocation,
      callback: (StompFrame frame) {
        if (frame.body != null) {
          _messages.add(frame.body!);
        }
      },
    );
  }

  void disconnect() {
    _client.deactivate();
    _messages.close();
  }
}
