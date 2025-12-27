import SwiftUI

struct CleaningTimer: View {
    let isActive: Bool
    let scale: CGFloat
    @State private var seconds = 0
    @State private var timer: Timer?
    
    init(isActive: Bool, scale: CGFloat = 1.0) {
        self.isActive = isActive
        self.scale = scale
    }
    
    var body: some View {
        if isActive {
            VStack(spacing: 4 * scale) {
                Text("Cleaning for")
                    .font(.system(size: max(14 * scale, 12)))
                    .foregroundColor(.mutedForeground)
                
                Text(formatTime(seconds))
                    .font(.system(size: max(36 * scale, 28), weight: .bold, design: .monospaced))
                    .foregroundColor(.primary)
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
            .onChange(of: isActive) { newValue in
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
    CleaningTimer(isActive: true, scale: 1.0)
}

