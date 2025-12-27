import SwiftUI

struct CleanButton: View {
    let isActive: Bool
    let onClick: () -> Void
    let scale: CGFloat
    @State private var isHovered = false
    @State private var isPressed = false
    
    init(isActive: Bool, scale: CGFloat = 1.0, onClick: @escaping () -> Void) {
        self.isActive = isActive
        self.scale = scale
        self.onClick = onClick
    }
    
    var body: some View {
        HStack(spacing: 12 * scale) {
            Text(isActive ? "🧹" : "🧽")
                .font(.system(size: max(24 * scale, 20)))
            
            Text(isActive ? "Stop Cleaning" : "Start Cleaning")
                .font(.system(size: max(20 * scale, 16), weight: .bold))
        }
        .foregroundColor(isActive ? .primaryForeground : .accentForeground)
        .padding(.horizontal, 48 * scale)
        .padding(.vertical, 20 * scale)
        .background(
            Group {
                if isActive {
                    Color.primary
                } else {
                    Color.accent
                }
            }
        )
        .cornerRadius(16 * scale)
        .shadow(color: isActive ? Color.primary.opacity(0.2) : Color.black.opacity(0.1), radius: 8 * scale, x: 0, y: 4 * scale)
        .overlay(
            Group {
                if !isActive && isHovered {
                    RoundedRectangle(cornerRadius: 16 * scale)
                        .fill(Color.accent.opacity(0.2))
                        .blur(radius: 20 * scale)
                        .offset(y: 0)
                }
            }
        )
        .scaleEffect(isPressed ? 0.95 : (isHovered && !isActive ? 1.05 : 1.0))
        .animation(.easeInOut(duration: 0.3), value: isHovered)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .contentShape(Rectangle())
        .onHover { hovering in
            isHovered = hovering
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    isPressed = true
                }
                .onEnded { _ in
                    isPressed = false
                    onClick()
                }
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        CleanButton(isActive: false, scale: 1.0) {}
        CleanButton(isActive: true, scale: 1.0) {}
    }
    .padding()
    .background(Color.background)
}

