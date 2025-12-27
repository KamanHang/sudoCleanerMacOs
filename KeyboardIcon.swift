import SwiftUI

struct KeyboardIcon: View {
    let isActive: Bool
    
    var body: some View {
        ZStack {
            // Keyboard body
            RoundedRectangle(cornerRadius: 8)
                .fill(isActive ? Color.primary : Color.muted)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isActive ? Color.primary : Color.border, lineWidth: 2)
                )
                .frame(width: 256, height: 171)
            
            // Keys
            VStack(spacing: 0) {
                // Row 1
                HStack(spacing: 0) {
                    ForEach(0..<12, id: \.self) { _ in
                        KeyView(isActive: isActive)
                    }
                }
                .padding(.horizontal, 16)
                
                // Row 2
                HStack(spacing: 0) {
                    ForEach(0..<11, id: \.self) { _ in
                        KeyView(isActive: isActive)
                    }
                }
                .padding(.horizontal, 32)
                
                // Row 3
                HStack(spacing: 0) {
                    ForEach(0..<10, id: \.self) { _ in
                        KeyView(isActive: isActive)
                    }
                }
                .padding(.horizontal, 48)
                
                // Bottom row with spacebar
                HStack(spacing: 0) {
                    KeyView(isActive: isActive, width: 64)
                    KeyView(isActive: isActive, width: 144) // Spacebar
                    KeyView(isActive: isActive, width: 64)
                }
                .padding(.horizontal, 16)
            }
            .frame(width: 256, height: 171)
            
            // Sparkles when active
            if isActive {
                SparkleView()
            }
        }
        .rotationEffect(.degrees(isActive ? 2 : 0))
        .animation(
            isActive ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default,
            value: isActive
        )
    }
}

struct KeyView: View {
    let isActive: Bool
    var width: CGFloat = 16
    
    var body: some View {
        RoundedRectangle(cornerRadius: 1)
            .fill(isActive ? Color.primaryForeground.opacity(0.3) : Color.background)
            .frame(width: width, height: 16)
    }
}


struct SparkleView: View {
    @State private var sparkleOpacity: [Double] = [0, 0, 0, 0, 0]
    @State private var sparkleScale: [CGFloat] = [0, 0, 0, 0, 0]
    
    let positions: [CGPoint] = [
        CGPoint(x: 64, y: -8),
        CGPoint(x: 192, y: -16),
        CGPoint(x: -16, y: 85),
        CGPoint(x: 272, y: 85),
        CGPoint(x: 85, y: 179),
    ]
    
    let delays: [Double] = [0.0, 0.5, 0.25, 0.75, 1.0]
    
    var body: some View {
        ZStack {
            ForEach(0..<5, id: \.self) { index in
                Text("✨")
                    .font(.system(size: 20))
                    .position(positions[index])
                    .opacity(sparkleOpacity[index])
                    .scaleEffect(sparkleScale[index])
            }
        }
        .onAppear {
            for index in 0..<5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + delays[index]) {
                    withAnimation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true)
                    ) {
                        sparkleOpacity[index] = 1.0
                        sparkleScale[index] = 1.0
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        KeyboardIcon(isActive: false)
        KeyboardIcon(isActive: true)
    }
    .padding()
    .background(Color.background)
}

