import Foundation
import UIKit
// BatteryStatusは、シングルトンクラスとして実装する
class BatteryStatus {
    // シングルトンインスタンスを取得するためのプロパティ
    static let shared = BatteryStatus()
    // シングルトンインスタンスを取得するためのプライベートイニシャライザ
    private init() {}
    // バッテリー残量を取得するメソッド
    func getBatteryLevel() -> String {
        // バッテリー残量を取得するために、バッテリー監視を有効にする
        UIDevice.current.isBatteryMonitoringEnabled = true
        // バッテリー残量を取得する
        let batteryLevel = UIDevice.current.batteryLevel
        // バッテリー監視を無効にする
        return batteryLevel < 0.0 ? "Unknown" : String(format: "%.0f%%", batteryLevel * 100)
    }
}
