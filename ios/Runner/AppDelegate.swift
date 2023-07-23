import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var methodChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // FlutterViewControllerを取得
    guard let controller = window?.rootViewController as? FlutterViewController else {
      return false
    }

    // MethodChannelの定義
    methodChannel = FlutterMethodChannel(name: "samples.flutter.dev/dateAndTime", binaryMessenger: controller.binaryMessenger)

    // MethodChannelのメソッドコールのリスナー設定
    methodChannel?.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      // getDateAndTimeメソッドの実行
      if call.method == "getDateAndTime" {
        self?.getDateAndTime(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // 現在の日付と時刻を取得するメソッド
  private func getDateAndTime(result: FlutterResult) {
    let now = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .medium
    let dateTimeString = formatter.string(from: now)
    result(dateTimeString)
  }
}
