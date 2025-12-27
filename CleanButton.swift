import SwiftUI

struct CleanButton: View {
    let isActive: Bool
    let onClick: () -> Void
    @State private var isHovered = false
    
    var body: some View {
        Button(action: onClick) {
            HStack(spacing: 12) {
                Text(isActive ? "🧹" : "🧽")
                    .font(.system(size: 24))
                
                Text(isActive ? "Stop Cleaning" : "Start Cleaning")
                    .font(.system(size: 20, weight: .bold))
            }
            .foregroundColor(isActive ? .accentForeground : .primaryForeground)
            .padding(.horizontal, 48)
            .padding(.vertical, 20)
            .background(
                Group {
                    if isActive {
                        Color.accent
                    } else {
                        Color.primary
                    }
                }
            )
            .cornerRadius(16)
            .shadow(color: isActive ? Color.black.opacity(0.1) : Color.primary.opacity(0.2), radius: 8, x: 0, y: 4)
            .overlay(
                Group {
                    if !isActive && isHovered {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.primary.opacity(0.2))
                            .blur(radius: 20)
                            .offset(y: 0)
                    }
                }
            )
            .scaleEffect(isHovered && !isActive ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 0.3), value: isHovered)
        }
        .buttonStyle(PlainButtonStyle())
        .onHover { hovering in
            isHovered = hovering
        }
        .focusable()
    }
}

#Preview {
    VStack(spacing: 20) {
        CleanButton(isActive: false) {}
        CleanButton(isActive: true) {}
    }
    .padding()
    .background(Color.background)
}

