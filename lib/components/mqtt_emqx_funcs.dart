// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:nurow_devp/components/variables_constant.dart';

// final client =
//     MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);

// var pongCount = 0, connStatus = 0;
// const pubTopic = 'GsmClientTest/led';
// final builder = MqttClientPayloadBuilder();
// const subTopic = 'GsmClientTest/ledStatus';
String switchState = '';
//------------------------------------------------------------------------------
Future<void> mqttConnect() async {
  // Future<String> mqttConnect() async {
  Completer<MqttServerClient> completer = Completer();

  client.logging(on: true);
  // client.setProtocolV311();
  client.autoReconnect = true; //FOR AUTORECONNECT
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
    print('EXAMPLE::client exception - $e');
    client.disconnect();
  } on SocketException catch (e) {
    // Raised by the socket layer
    print('EXAMPLE::socket exception - $e');
    client.disconnect();
  }

  /// Check we are connected
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    connStatus = 1;
    print('EMQX client connected');
    completer.complete(client);
  } else {
    /// Use status here rather than state if you also want the broker return code.
    connStatus = 0;
    print(
        'EMQX client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
  }

  /// Ok, lets try a subscription
  print('Subscribing to Nurowm/Nresponse topic');
  client.subscribe(subTopic, MqttQos.atMostOnce);

  client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print(
            'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');

        // if (pt == "0") {
        //   switchState = "OFF";
        // } else {
        //   switchState = "ON";
        // }
        // devicesStateTemp.insert(devicesStateTemp.length, switchState);
        // print(devicesStateTemp[0]);
        //
      }) ??
      client.published?.listen((MqttPublishMessage message) {
        print(
            'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
      }) ??
      1;

  // return switchState;
    return;

}

//------------------------------------------------------------------------------ *

void mqttSubscribe() {
  /// Subscribe to GsmClientTest/ledStatus
  print('Subscribing to the Nurow/command topic');
  client.subscribe(subTopic, MqttQos.atMostOnce);
}

// String mqttPublish(String msg) {
void mqttPublish(String msg) {
  builder.clear();
  builder.addString(msg);

  /// Publish it
  print('EXAMPLE::Publishing our topic');
  client.publishMessage(pubTopic, MqttQos.atMostOnce, builder.payload!);
  // print(devicesStateTemp[0]);
  // return switchState;
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

// unconnected
void onDisconnected() {
  print('Disconnected');
}

// subscribe to topic succeeded
void onSubscribed(String topic) {
  print('Subscribed topic: $topic');
}

// subscribe to topic failed
void onSubscribeFail(String topic) {
  print('Failed to subscribe $topic');
}

// unsubscribe succeeded
void onUnsubscribed(String topic) {
  print('Unsubscribed topic: $topic');
}

// PING response received
void pong() {
  print('Ping response client callback invoked');
}

/// The pre auto re connect callback
void onAutoReconnect() {
  print(
      'EXAMPLE::onAutoReconnect client callback - Client auto reconnection sequence will start');
}

/// The post auto re connect callback
void onAutoReconnected() {
  print(
      'EXAMPLE::onAutoReconnected client callback - Client auto reconnection sequence has completed');
}
