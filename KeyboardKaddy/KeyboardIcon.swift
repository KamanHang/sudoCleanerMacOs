import SwiftUI

struct KeyboardIcon: View {
    let isActive: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let keyboardWidth = geometry.size.width
            let keyboardHeight = geometry.size.height
            let keyWidth = keyboardWidth / 16
            let keyHeight = keyboardHeight / 12
            let keySpacing: CGFloat = 2
            
            ZStack {
                // Keyboard body
                RoundedRectangle(cornerRadius: 8)
                    .fill(isActive ? Color.primary : Color.muted)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isActive ? Color.primary : Color.border, lineWidth: 2)
                    )
                    .frame(width: keyboardWidth, height: keyboardHeight)
                
                // Keys
                VStack(spacing: keySpacing) {
                    // Row 1
                    HStack(spacing: keySpacing) {
                        ForEach(0..<12, id: \.self) { _ in
                            KeyView(isActive: isActive, width: keyWidth, height: keyHeight)
                        }
                    }
                    .padding(.horizontal, keyboardWidth * 0.0625)
                    
                    // Row 2
                    HStack(spacing: keySpacing) {
                        ForEach(0..<11, id: \.self) { _ in
                            KeyView(isActive: isActive, width: keyWidth, height: keyHeight)
                        }
                    }
                    .padding(.horizontal, keyboardWidth * 0.125)
                    
                    // Row 3
                    HStack(spacing: keySpacing) {
                        ForEach(0..<10, id: \.self) { _ in
                            KeyView(isActive: isActive, width: keyWidth, height: keyHeight)
                        }
                    }
                    .padding(.horizontal, keyboardWidth * 0.1875)
                    
                    // Bottom row with spacebar
                    HStack(spacing: keySpacing) {
                        KeyView(isActive: isActive, width: keyWidth * 4, height: keyHeight)
                        KeyView(isActive: isActive, width: keyWidth * 9, height: keyHeight) // Spacebar
                        KeyView(isActive: isActive, width: keyWidth * 4, height: keyHeight)
                    }
                    .padding(.horizontal, keyboardWidth * 0.0625)
                }
                .frame(width: keyboardWidth, height: keyboardHeight)
                .padding(.top, keyboardHeight * 0.117)
                
                // Sparkles when active
                if isActive {
                    SparkleView(keyboardWidth: keyboardWidth, keyboardHeight: keyboardHeight)
                }
            }
            .rotationEffect(.degrees(isActive ? 2 : 0))
            .animation(
                isActive ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default,
                value: isActive
            )
        }
    }
}

struct KeyView: View {
    let isActive: Bool
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 1)
            .fill(isActive ? Color.primaryForeground.opacity(0.3) : Color.background)
            .frame(width: width, height: height)
    }
}


struct SparkleView: View {
    let keyboardWidth: CGFloat
    let keyboardHeight: CGFloat
    @State private var sparkleOpacity: [Double] = [0, 0, 0, 0, 0]
    @State private var sparkleScale: [CGFloat] = [0, 0, 0, 0, 0]
    
    var positions: [CGPoint] {
        [
            CGPoint(x: keyboardWidth * 0.25, y: -keyboardHeight * 0.047),
            CGPoint(x: keyboardWidth * 0.75, y: -keyboardHeight * 0.094),
            CGPoint(x: -keyboardWidth * 0.0625, y: keyboardHeight * 0.5),
            CGPoint(x: keyboardWidth * 1.0625, y: keyboardHeight * 0.5),
            CGPoint(x: keyboardWidth * 0.33, y: keyboardHeight * 1.047),
        ]
    }
    
    let delays: [Double] = [0.0, 0.5, 0.25, 0.75, 1.0]
    
    var body: some View {
        ZStack {
            ForEach(0..<5, id: \.self) { index in
                Text("✨")
                    .font(.system(size: max(keyboardWidth * 0.078, 16)))
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
            .frame(width: 256, height: 171)
        KeyboardIcon(isActive: true)
            .frame(width: 256, height: 171)
    }
    .padding()
    .background(Color.background)
}

