import UIKit
import Flutter
import flutter_local_notifications
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, UNUserNotificationCenterDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Настройка уведомлений для iOS 10 и выше
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
      
      let center = UNUserNotificationCenter.current()
      center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
          DispatchQueue.main.async {
            application.registerForRemoteNotifications()
          }
          print("Notification permission granted")
        } else {
          print("Notification permission denied")
        }
        
        if let error = error {
          print("Error requesting notification permission: \(error)")
        }
      }
    }

    // Регистрация плагинов Flutter
    GeneratedPluginRegistrant.register(with: self)
    
    // Настройка обработчика уведомлений Flutter
    if let controller = window?.rootViewController as? FlutterViewController {
      let notificationChannel = FlutterMethodChannel(
        name: "com.yourapp.notifications",
        binaryMessenger: controller.binaryMessenger)
      
      notificationChannel.setMethodCallHandler { [weak self] (call, result) in
        // Обработка вызовов методов из Flutter
        if call.method == "scheduleNotification" {
          // Реализация планирования уведомлений
        }
        result(nil)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Обработка уведомлений в foreground режиме
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.alert, .badge, .sound])
  }

  // Обработка нажатия на уведомление
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    let userInfo = response.notification.request.content.userInfo
    // Обработка данных уведомления
    completionHandler()
  }
}