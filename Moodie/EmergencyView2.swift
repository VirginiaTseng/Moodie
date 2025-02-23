//
//  EmergencyView2.swift
//  Moodie
//
//  Created by Virginia Zheng on 2025-02-21.
//



import SwiftUI
import AVFoundation
import CoreMotion
import LocalAuthentication

struct EmergencyView2: View {
    // @StateObject private var emergencyManager = EmergencyManager()
    @State private var isRecording = false
    @State private var timeRemaining: Int = 60
    @State private var timer: Timer?
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                if isRecording {
                    ZStack {
                        Circle()
                            .stroke(Color.red.opacity(0.2), lineWidth: 6)
                            .frame(width: 160, height: 160)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(timeRemaining) / 60.0)
                            .stroke(Color.red, lineWidth: 6)
                            .frame(width: 160, height: 160)
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 1), value: timeRemaining)
                        
                        VStack {
                            Text("\(timeRemaining)")
                                .font(.system(size: 40, weight: .bold))
                            Text("seconds")
                                .font(.caption)
                        }
                        .foregroundColor(.red)
                    }
                    .padding(.bottom, 30)
                }
                
                // 紧急按钮
                EmergencyButton(
                    isRecording: $isRecording,
                    onLongPressStart: {
                        //startEmergencyMode()
                    },
                    onLongPressEnd: {
                        // 用户释放按钮，但不停止记录
                        // 只有验证成功才停止
                    }
                )
                
                Spacer()
                
                if isRecording {
                    // 验证按钮
                    Button(action: {
                        //authenticateUser()
                    }) {
                        Text("Verify to Cancel")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                
                // 说明文字
                VStack(spacing: 16) {
                    Text("Emergency Button")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Press and hold to activate emergency mode.\nVerify your identity within 1 minute to cancel.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
                .padding(.bottom, 50)
            }
        }
    }
}

