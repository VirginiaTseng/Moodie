//
//  LocationManager.swift
//  Moodie
//
//  Created by Virginia Zheng on 2025-02-19.
//
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation? = CLLocation(latitude: 52.1332, longitude: -106.6700) // ✅ 默认萨斯卡通市
        @Published var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 52.1332, longitude: -106.6700), // ✅ 默认萨斯卡通
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        // ✅ 使用 `requestLocation()` 只获取一次位置
        locationManager.requestLocation()
    }

    /// 📌 位置更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.location = location
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }

    /// ❌ 位置获取失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ 位置获取失败: \(error.localizedDescription)")

        if let clError = error as? CLError {
            switch clError.code {
            case .denied:
                print("⛔ 用户拒绝了定位权限，默认使用萨斯卡通市。")
            case .locationUnknown:
                print("⚠️ GPS 信号弱，默认使用萨斯卡通市。")
            default:
                print("❌ 其他错误: \(clError)")
            }
        }
        
        // ✅ 位置获取失败时，默认使用萨斯卡通
        DispatchQueue.main.async {
            self.location = CLLocation(latitude: 52.1332, longitude: -106.6700)
            self.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 52.1332, longitude: -106.6700),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }
}
