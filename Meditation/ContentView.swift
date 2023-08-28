//
//  ContentView.swift
//  Meditation
//
//  Created by Sion Kim on 2023/08/28.
//

import SwiftUI

struct ContentView: View {
    @State private var isRunning = false
    @State private var remainingTime = TimeInterval(0)
    
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            Circle()
                .trim(from: 0, to: (remainingTime)/(60*10))
                .stroke(.blue, lineWidth: 4)
                .frame(width: 300)
            
            VStack {
                if remainingTime > 0 {
                    let minutes = Int(remainingTime) / 60 % 60
                    let seconds = Int(remainingTime) % 60
                    let timeString = String(format:"%02i:%02i", minutes, seconds)
                    
                    Text(timeString)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                } else {
                    Text("10 Minute \n Meditation Session")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                }

                HStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        isRunning = false
                        remainingTime = TimeInterval(0)
                    } label: {
                        Circle()
                            .frame(width: 70)
                            .foregroundColor(.gray)
                            .overlay {
                                Text("Cancel")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                            }
                    }
                    
                    Spacer()
                    
                    Button {
                        if isRunning {
                            isRunning = false
                        } else {
                            isRunning = true
                            remainingTime = TimeInterval(60*10)
                        }
                        
                        
                    } label: {
                        Circle()
                            .frame(width: 70)
                            .foregroundColor(.green)
                            .overlay {
                                Text(isRunning ? "Pause" : "Start")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                            }
                    }
                    
                    Spacer()
                }
            }
        }
        .onReceive(timer) { _ in
            if isRunning {
                if remainingTime > 0 {
                    remainingTime -= 1
                } else {
                    isRunning = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
