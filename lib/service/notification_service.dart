import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  static const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> initialize() async {

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      _saveTokenToDatabase();
    } else {
      print('User declined or has not accepted permission');
    }

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    _showNotification(message);
  }
  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Unique channel ID
      'your_channel_name', // Channel Name
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? 'No Title', // Title
      message.notification?.body ?? 'No Body', // Body
      platformChannelSpecifics,
    );
  }
  Future<void> _saveTokenToDatabase() async {
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'fcmToken': token,
      });
    }
  }
}