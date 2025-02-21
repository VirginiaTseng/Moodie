//
//  MapView.swift
//  Moodie
//
//  Created by Virginia Zheng on 2025-02-18.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    
    @State private var searchText = ""
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 52.1332, longitude: -106.6700),
//        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    )
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if let location = locationManager.location {
                    HStack {
                        Text("Latitude: \(location.coordinate.latitude)")
                        Text("Longitude: \(location.coordinate.longitude)")
                    }
              } else {
                  Text("Fetching location...")
              }
                // 搜索栏和过滤器
                VStack(spacing: 16) {
                  
                    // 搜索栏
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search location...", text: $searchText)
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    // 过滤器按钮
                    HStack(spacing: 12) {
                        FilterButton(title: "Safe Routes", icon: "shield.fill", color: .blue)
                        FilterButton(title: "Risk Areas", icon: "exclamationmark.triangle.fill", color: .red)
                        FilterButton(title: "Help Points", icon: "cross.fill", color: .green)
                    }
                }
                .padding()
                .background(Color.white)
                
                // 地图视图
                ZStack(alignment: .trailing) {
                    Map(coordinateRegion: $locationManager.region,
                        showsUserLocation: true,
                        userTrackingMode: .constant(.follow))
                        .edgesIgnoringSafeArea(.bottom)
                    
                    // 地图控制按钮
                    VStack(spacing: 8) {
                        MapControlButton(icon: "layers.fill") {}
                        MapControlButton(icon: "location.fill") {
                            // 重新定位到用户位置
                            if let location = locationManager.location {
                                withAnimation {
                                    locationManager.region = MKCoordinateRegion(
                                        center: location.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    )
                                }
                            }
                        }
                        MapControlButton(icon: "plus") {}
                        MapControlButton(icon: "minus") {}
                    }
                    .padding(.trailing)
                }
                
                
                // 底部信息卡片
                VStack(spacing: 16) {
                    // 风险等级
                    HStack(spacing: 20) {
                        RiskLevelCard(
                            title: "Risk Level",
                            value: "Moderate",
                            subtitle: "Current Area",
                            icon: "chart.line.uptrend.xyaxis",
                            color: .orange
                        )
                        
                        RiskLevelCard(
                            title: "Incidents",
                            value: "3",
                            subtitle: "Last 24 hours",
                            icon: "exclamationmark.circle.fill",
                            color: .red
                        )
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .background(Color.white)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 15) {
                        Button(action: {}) {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.purple)
                        }
                        Button(action: {}) {
                            Image(systemName: "moon.fill")
                                .foregroundColor(.purple)
                        }
                        Button(action: {}) {
                            Image(systemName: "mic.fill")
                                .foregroundColor(.purple)
                        }
                    }
                }
            }
        }
    }
}

// 过滤器按钮
struct FilterButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                Text(title)
                    .font(.subheadline)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(color.opacity(0.1))
            .foregroundColor(color)
            .cornerRadius(20)
        }
    }
}

// 地图控制按钮
struct MapControlButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 40, height: 40)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
        }
    }
}

// 风险等级卡片
struct RiskLevelCard: View {
    let title: String
    let value: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(value)
                    .font(.headline)
                    .foregroundColor(color)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(color.opacity(0.1))
            .cornerRadius(8)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

// 预览
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
} 
