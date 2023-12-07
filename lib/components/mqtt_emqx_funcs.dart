// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// String switchState = '';
final client = MqttServerClient.withPort(
    'broker.emqx.io', 'nurowapp_client123456789', 1883);
var pongCount = 0, connStatus = 0;
const pubTopic = 'Nurowapp/Appcommand';
final builder = MqttClientPayloadBuilder();
const subTopic = 'Nurowapp/Appresponse';

Future<void> mqttConnect() async {
  Completer<MqttServerClient> completer = Completer();
  
  client.logging(on: true);
  client.autoReconnect = true;
  client.onAutoReconnect = onAutoReconnect;
  client.keepAlivePeriod = 60;
  client.onDisconnected = onDisconnected;
  client.onConnected = onConnected;
  client.onAutoReconnected = onAutoReconnected;
  client.onSubscribed = onSubscribed;
  client.pongCallback = pong;

  final connMess = MqttConnectMessage().withWillQos(MqttQos.atMostOnce);
  print('EMQX client connecting....');
  client.connectionMessage = connMess;

  try {
    await client.connect();
  } on NoConnectionException catch (e) {
    print('NUROW::client exception - $e');
    client.disconnect();
  } on SocketException catch (e) {
    print('NUROW::socket exception - $e');
    client.disconnect();
  }

  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    connStatus = 1;
    print('EMQX client connected');
    completer.complete(client);
  } else {
    connStatus = 0;
    print(
        'EMQX client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
  }

  print('Subscribing to Nurowm/Nresponse topic');
  client.subscribe(subTopic, MqttQos.atMostOnce);

  client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print(
            'NUROW::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      }) ??
      client.published?.listen((MqttPublishMessage message) {
        print(
            'NUROW::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
      }) ??
      1;

  return;
}

//------------------------------------------------------------------------------ *

void mqttSubscribe() {
  print('Subscribing to the Nurow/command topic');
  client.subscribe(subTopic, MqttQos.atMostOnce);
}

void mqttPublish(String msg) {
  builder.clear();
  builder.addString(msg);

  print('NUROW::Publishing our topic');
  client.publishMessage(pubTopic, MqttQos.atMostOnce, builder.payload!);
}

void mqttUnsubscribe() {
  client.unsubscribe('Nurow/response');
}

void mqttDisconnect() {
  client.disconnect();
}

//******************************************************************************/

void onConnected() {
  print('Connected');
}

void onDisconnected() {
  print('Disconnected');
}

void onSubscribed(String topic) {
  print('Subscribed topic: $topic');
}

void onSubscribeFail(String topic) {
  print('Failed to subscribe $topic');
}

void onUnsubscribed(String topic) {
  print('Unsubscribed topic: $topic');
}

void pong() {
  print('Ping response client callback invoked');
}

void onAutoReconnect() {
  print(
      'NUROW::onAutoReconnect client callback - Client auto reconnection sequence will start');
}

void onAutoReconnected() {
  print(
      'NUROW::onAutoReconnected client callback - Client auto reconnection sequence has completed');
}
