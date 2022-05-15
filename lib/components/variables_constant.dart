import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
// import 'package:shared_preferences/shared_preferences.dart';

//Single devices widget
bool switchValue = true;
String commandMessage = "";
// String switchState = "OFF";
int commandDigit = 0;

//Add Devices Screen
List<String> devicesIDsTemp = <String>[];
List<String> devicesNamesTemp = <String>[];
List<String> devicesStateTemp = <String>[];

//Devices List Screen
// int index = 0;
// int devicesCount = 0;
// String msg = "Devices added";
// List<String> devicesIDs = <String>[];
// List<String> devicesNames = <String>[];
// final List<int> msgCount = <int>[];

//MQTT EMQX Functions
final client =
    MqttServerClient.withPort('broker.emqx.io', 'nurowapp_client123456789', 1883);
var pongCount = 0, connStatus = 0;
const pubTopic = 'Nurowapp/Appcommand';
final builder = MqttClientPayloadBuilder();
const subTopic = 'Nurowapp/Appresponse';
// var pt = '';
