import SwiftUI

struct CleaningTimer: View {
    let isActive: Bool
    @State private var seconds = 0
    @State private var timer: Timer?
    
    var body: some View {
        if isActive {
            VStack(spacing: 4) {
                Text("Cleaning for")
                    .font(.system(size: 14))
                    .foregroundColor(.mutedForeground)
                
                Text(formatTime(seconds))
                    .font(.system(size: 36, weight: .bold, design: .monospaced))
                    .foregroundColor(.primary)
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
            .onChange(of: isActive) { oldValue, newValue in
                if newValue {
                    startTimer()
                } else {
                    stopTimer()
                    seconds = 0
                }
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            seconds += 1
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func formatTime(_ totalSeconds: Int) -> String {
        let mins = totalSeconds / 60
        let secs = totalSeconds % 60
        return String(format: "%02d:%02d", mins, secs)
    }
}

#Preview {
    CleaningTimer(isActive: true)
}

