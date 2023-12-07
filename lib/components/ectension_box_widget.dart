// import 'dart:ffi';

// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:nurow_devp/components/mqtt_emqx_funcs.dart';

class ExtensionBoxWidget extends StatefulWidget {
  final String? deviceName;
  final String? deviceID;

  const ExtensionBoxWidget({
    key,
    this.deviceName,
    this.deviceID,
  }) : super(key: key);

  @override
  State<ExtensionBoxWidget> createState() => _ExtensionBoxWidgetState();
}

class _ExtensionBoxWidgetState extends State<ExtensionBoxWidget> {
  int? commandDigit = 0;
  String commandMessage = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.teal.shade500,
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      width: size.width - 10.0,
      height: 60.0,
      child: ListTile(
        leading: Text(
          widget.deviceName!,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
        trailing: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 35.0,
            child: LiteRollingSwitch(
              textSize: 10.0,
              width: 75,
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
                commandMessage = '$commandDigit-${widget.deviceID}';
                mqttPublish(commandMessage);
                print(commandMessage);
              },
              onSwipe: () {},
              onDoubleTap: () {},
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
