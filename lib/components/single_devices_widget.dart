// @dart=2.9

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:nurow_devp/components/mqtt_emqx_funcs.dart';
import 'package:nurow_devp/components/variables_constant.dart';

// bool switchValue = true;
// String commandMessage, switchState = "OFF";
// int commandDigit = 0;

class SingleDeviceWidget extends StatelessWidget {
  final String deviceName;
  final String deviceID;
  // final String switchState;

  const SingleDeviceWidget({
    key,
    this.deviceName,
    this.deviceID,
    // this.switchState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.purple.shade500, // Set border color
            width: 1.0), // Set border width
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      width: size.width - 10.0,
      height: 60.0,
      child: ListTile(
        leading: Text(
          deviceName,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
        //
        trailing: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            // width: size.width / 5 + 10.0,
            height: 35.0,
            child: LiteRollingSwitch(
              textSize: 12.0,
              value: false,
              textOn: "ON",
              textOff: "OFF",
              colorOn: Colors.green,
              colorOff: Colors.red,
              iconOn: Icons.lightbulb_outline,
              iconOff: Icons.power_settings_new,
              onTap: () {
                if (commandDigit == 0) {
                  commandDigit = 1;
                } else {
                  commandDigit = 0;
                }
                commandMessage = '$commandDigit-$deviceID';
                mqttPublish(commandMessage); //Publish message to pubTopic
                // ignore: avoid_print
                print(commandMessage);
              },
              onChanged: (bool states) {
                states != states;
              },
            ),
          ),
        ),
      ),
    );
  }
}


/*
// @dart=2.9

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:nurow_devp/components/mqtt_emqx_funcs.dart';
import 'package:nurow_devp/components/variables_constant.dart';

// bool switchValue = true;
// String commandMessage, switchState = "OFF";
// int commandDigit = 0;

class SingleDeviceWidget extends StatelessWidget {
  final String deviceName;
  final String deviceID;
  // final String switchState;

  const SingleDeviceWidget({
    key,
    this.deviceName,
    this.deviceID,
    // this.switchState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.purple.shade500, // Set border color
            width: 1.0), // Set border width
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      width: size.width - 10.0,
      height: 60.0,
      child: ListTile(
        leading: Positioned(
          left: 10.0,
          child: Text(
            deviceName,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
          ),
        ),
        //
        trailing: Positioned(
          right: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              // width: size.width / 5 + 10.0,
              height: 35.0,
              child: LiteRollingSwitch(
                textSize: 12.0,
                value: false,
                textOn: "ON",
                textOff: "OFF",
                colorOn: Colors.green,
                colorOff: Colors.red,
                iconOn: Icons.lightbulb_outline,
                iconOff: Icons.power_settings_new,
                onTap: () {
                  if (commandDigit == 0) {
                    commandDigit = 1;
                  } else {
                    commandDigit = 0;
                  }
                  commandMessage = '$commandDigit:$deviceID';
                  mqttPublish(commandMessage); //Publish message to pubTopic
                  // ignore: avoid_print
                  print(commandMessage);
                },
                onChanged: (bool states) {
                  states != states;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/