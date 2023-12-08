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
  List<int> commandDigits = [0, 0, 0, 0];
  String commandMessage = "";

  sendCommandMessage() {
    String ebCommandData =
        "${commandDigits[0]}${commandDigits[1]}${commandDigits[2]}${commandDigits[3]}";
    commandMessage = '$ebCommandData-${widget.deviceID}';
    mqttPublish(commandMessage);
    print(commandMessage);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.teal.shade500,
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      width: size.width - 10.0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.deviceName!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 45.0,
                  child: ElevatedButton(
                    onPressed: () {
                      // Off/On all sockets
                      if (commandDigits[0] == 0 &&
                          commandDigits[1] == 0 &&
                          commandDigits[2] == 0 &&
                          commandDigits[3] == 0) {
                        print("On all func called");
                        commandMessage = '1111-${widget.deviceID}';
                        mqttPublish(commandMessage);
                        commandDigits = [1, 1, 1, 1];
                      } else {
                        print("Off all func called");
                        commandMessage = '0000-${widget.deviceID}';
                        mqttPublish(commandMessage);
                        commandDigits = [0, 0, 0, 0];
                      }
                      setState(() {});
                    },
                    child: Text(
                      commandDigits[0] == 0 &&
                              commandDigits[1] == 0 &&
                              commandDigits[2] == 0 &&
                              commandDigits[3] == 0
                          ? "On All"
                          : "Off All",
                      style: TextStyle(
                        fontSize: 14,
                        color: (commandDigits[0] == 0 &&
                                commandDigits[1] == 0 &&
                                commandDigits[2] == 0 &&
                                commandDigits[3] == 0)
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red;
                        }
                        return Colors.white;
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.teal.shade500,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            height: 65.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LiteRollingSwitch(
                  textSize: 10.0,
                  width: 80,
                  // value: false,
                  value: commandDigits[0] == 1 ? true : false,
                  textOn: "ON",
                  textOff: "OFF",
                  colorOn: Colors.green,
                  colorOff: Colors.red,
                  textOnColor: Colors.white,
                  iconOn: Icons.lightbulb_outline,
                  iconOff: Icons.power_settings_new,
                  onTap: () {
                    if (commandDigits[0] == 0) {
                      commandDigits[0] = 1;
                    } else {
                      commandDigits[0] = 0;
                    }
                    sendCommandMessage();
                  },
                  onSwipe: () {},
                  onDoubleTap: () {},
                  onChanged: (bool states) {
                    states != states;
                  },
                ),
                LiteRollingSwitch(
                  textSize: 10.0,
                  width: 80,
                  value: commandDigits[1] == 1 ? true : false,
                  textOn: "ON",
                  textOff: "OFF",
                  colorOn: Colors.green,
                  colorOff: Colors.red,
                  textOnColor: Colors.white,
                  iconOn: Icons.lightbulb_outline,
                  iconOff: Icons.power_settings_new,
                  onTap: () {
                    if (commandDigits[1] == 0) {
                      commandDigits[1] = 1;
                    } else {
                      commandDigits[1] = 0;
                    }
                    sendCommandMessage();
                  },
                  onSwipe: () {},
                  onDoubleTap: () {},
                  onChanged: (bool states) {
                    states != states;
                  },
                ),
                LiteRollingSwitch(
                  textSize: 10.0,
                  width: 80,
                  // value: true,
                  value: commandDigits[2] == 1 ? true : false,
                  textOn: "ON",
                  textOff: "OFF",
                  colorOn: Colors.green,
                  colorOff: Colors.red,
                  textOnColor: Colors.white,
                  iconOn: Icons.lightbulb_outline,
                  iconOff: Icons.power_settings_new,
                  onTap: () {
                    if (commandDigits[2] == 0) {
                      commandDigits[2] = 1;
                    } else {
                      commandDigits[2] = 0;
                    }
                    sendCommandMessage();
                  },
                  onSwipe: () {},
                  onDoubleTap: () {},
                  onChanged: (bool states) {
                    states != states;
                  },
                ),
                LiteRollingSwitch(
                  textSize: 10.0,
                  width: 80,
                  // value: false,
                  value: commandDigits[3] == 1 ? true : false,
                  textOn: "ON",
                  textOff: "OFF",
                  textOnColor: Colors.white,
                  colorOn: Colors.green,
                  colorOff: Colors.red,
                  iconOn: Icons.lightbulb_outline,
                  iconOff: Icons.power_settings_new,
                  onTap: () {
                    if (commandDigits[3] == 0) {
                      commandDigits[3] = 1;
                    } else {
                      commandDigits[3] = 0;
                    }
                    sendCommandMessage();
                  },
                  onSwipe: () {},
                  onDoubleTap: () {},
                  onChanged: (bool states) {
                    states != states;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
