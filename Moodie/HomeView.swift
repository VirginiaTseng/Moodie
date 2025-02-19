import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 安全状态卡片
                    SafetyStatusCard()
                    
                    // 快速操作按钮
                    QuickActionsView()
                    
                    // 天气和安全信息
                    WeatherSafetyCard()
                    
                    // 最近活动
                    RecentActivityCard()
                }
                .padding()
            }
//            .navigationTitle("Moodie")
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

// 安全状态卡片组件
struct SafetyStatusCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Safety Status")
                    .font(.title2)
                    .bold()
                Spacer()
                Text("Protected")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.purple.opacity(0.2))
                    .foregroundColor(.purple)
                    .cornerRadius(20)
            }
            
            Text("Last updated 5 min ago")
                .foregroundColor(.gray)
            
            HStack(spacing: 15) {
                StatusBox(title: "Safety Score", value: "85%", icon: "shield.fill")
                StatusBox(title: "Contacts", value: "5 active", icon: "person.2.fill")
                StatusBox(title: "Safe Zones", value: "3 zones", icon: "location.fill")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

// 状态框组件
struct StatusBox: View {
    var title: String
    var value: String
    var icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.purple)
            Text(value)
                .font(.title2)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(12)
    }
}

// 快速操作按钮组件
struct QuickActionsView: View {
    var body: some View {
        HStack(spacing: 15) {
            ActionButton(
                title: "SOS Alert",
                subtitle: "Emergency help",
                icon: "exclamationmark.triangle.fill",
                backgroundColor: Color.red.opacity(0.1),
                iconColor: .red
            )
            
            ActionButton(
                title: "Safe Walk",
                subtitle: "Track journey",
                icon: "figure.walk",
                backgroundColor: Color.purple.opacity(0.1),
                iconColor: .purple
            )
        }
    }
}

struct ActionButton: View {
    var title: String
    var subtitle: String
    var icon: String
    var backgroundColor: Color
    var iconColor: Color
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(iconColor)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(12)
        }
    }
}

// 天气和安全信息卡片
struct WeatherSafetyCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Weather & Safety")
                    .font(.title2)
                    .bold()
                Spacer()
                HStack {
                    Text("Updated 5 min ago")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.purple)
                }
            }
            
            HStack(spacing: 15) {
                // 天气警报
                VStack(alignment: .leading, spacing: 8) {
                    Text("Weather Alert")
                        .font(.headline)
                    HStack {
                        Image(systemName: "snowflake")
                        Text("-2°C")
                            .font(.title2)
                            .bold()
                    }
                    Text("Light Snow")
                    
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                        Text("Icy Roads")
                            .font(.caption)
                        
                        Image(systemName: "eye.slash")
                            .foregroundColor(.gray)
                        Text("Low Visibility")
                            .font(.caption)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                
                // 安全等级
                VStack(alignment: .leading, spacing: 8) {
                    Text("Safety Level")
                        .font(.headline)
                    Image(systemName: "shield.fill")
                        .foregroundColor(.green)
                    Text("Safe")
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        Image(systemName: "checkmark.shield.fill")
                            .foregroundColor(.green)
                        Text("Protected")
                            .font(.caption)
                        
                        Image(systemName: "house.fill")
                            .foregroundColor(.purple)
                        Text("Home Zone")
                            .font(.caption)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)
            }
            
            // 环境指标
            HStack(spacing: 20) {
                EnvironmentIndicator(icon: "sun.max.fill", title: "UV Index", value: "Low", iconColor: .orange)
                EnvironmentIndicator(icon: "leaf.fill", title: "Air Quality", value: "Good", iconColor: .green)
                EnvironmentIndicator(icon: "eye.fill", title: "Visibility", value: "Clear", iconColor: .blue)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct EnvironmentIndicator: View {
    var icon: String
    var title: String
    var value: String
    var iconColor: Color
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
            Text(value)
                .font(.subheadline)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

// 最近活动卡片
struct RecentActivityCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Recent Activity")
                .font(.title2)
                .bold()
            
            ForEach(0..<3) { _ in
                HStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                    Text("Safe zone check-in")
                        .font(.subheadline)
                    Spacer()
                    Text("2 min ago")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
} 
