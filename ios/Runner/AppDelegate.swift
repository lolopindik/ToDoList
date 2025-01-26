import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Настройка уведомлений для iOS 10 и выше
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      
      let center = UNUserNotificationCenter.current()
      center.requestAuthorization(options: [.alert, .sound, .badge, .provisional]) { granted, error in
        if let error = error {
          print("Error requesting notifications permission: \(error)")
          return
        }
        
        if granted {
          print("Notification permission granted")
          DispatchQueue.main.async {
            application.registerForRemoteNotifications()
          }
        } else {
          print("Notification permission denied")
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

  // Добавляем обработку уведомлений в фоновом режиме
  override func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable : Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
  ) {
    completionHandler(.newData)
  }

  // Обработка уведомлений в foreground режиме
  @available(iOS 10.0, *)
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.alert, .badge, .sound])
  }

  // Обработка нажатия на уведомление
  @available(iOS 10.0, *)
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
