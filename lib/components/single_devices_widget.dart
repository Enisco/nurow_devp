// // // import 'dart:ffi';

// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:nurow_devp/components/mqtt_emqx_funcs.dart';

class SingleDeviceWidget extends StatefulWidget {
  final String? deviceName;
  final String? deviceID;

  const SingleDeviceWidget({
    key,
    this.deviceName,
    this.deviceID,
  }) : super(key: key);

  @override
  State<SingleDeviceWidget> createState() => _SingleDeviceWidgetState();
}

class _SingleDeviceWidgetState extends State<SingleDeviceWidget> {
  int? commandDigit = 0;
  String commandMessage = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.teal.shade500,
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      width: size.width - 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.deviceName!,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
          ),
          SizedBox(
            height: 45.0,
            child: LiteRollingSwitch(
              textSize: 10.0,
              width: 80,
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
        ],
      ),
    );
  }
}
