import 'dart:async';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

String notificationTitle = '';
String notificationBody = '';
int notificationId = 0;
bool enableLights = false;
Color ledColor = Colors.white;
bool enableVibration = false;
bool enableSound = false;
bool debugMode = false;
String notificationChannelKey = 'basic_channel';

bool notificationsAllowed = false;

void main() async {
  await notificationInit();
  runApp(
    ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (BuildContext context, ThemeMode currentMode, __) {
          return MaterialApp(
            home: MainPage(),
          );
        }
    ),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context){
    return Scaffold(body: Center(child: Text('allowed: $notificationsAllowed')));
  }
}

Future<void> notificationInit() async {
  await AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher',
    [
      NotificationChannel(
        channelKey: notificationChannelKey,
        channelName: 'abd',
        channelDescription: 'efg',
        enableLights: enableLights,
        defaultColor: Colors.teal,
        ledColor: ledColor,
        enableVibration: enableVibration,
        vibrationPattern: lowVibrationPattern,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        playSound: enableSound,
        defaultPrivacy: NotificationPrivacy.Public,
        onlyAlertOnce: false,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        icon: 'resource://drawable/ic_launcher',
      ),
    ],
  );
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    notificationsAllowed = isAllowed;
  });
}