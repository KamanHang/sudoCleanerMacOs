import SwiftUI

struct ToastView: View {
    let title: String
    let description: String
    let scale: CGFloat
    
    init(title: String, description: String, scale: CGFloat = 1.0) {
        self.title = title
        self.description = description
        self.scale = scale
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4 * scale) {
            Text(title)
                .font(.system(size: max(14 * scale, 12), weight: .semibold))
                .foregroundColor(.foreground)
            
            Text(description)
                .font(.system(size: max(12 * scale, 10)))
                .foregroundColor(.mutedForeground)
        }
        .padding(16 * scale)
        .background(Color.card)
        .cornerRadius(8 * scale)
        .shadow(color: Color.black.opacity(0.2), radius: 8 * scale, x: 0, y: 4 * scale)
        .padding(.bottom, 20 * scale)
        .padding(.trailing, 32 * scale)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
}

#Preview {
    ToastView(title: "Cleaning Mode Activated! 🧹", description: "Press ESC 3 times quickly to stop", scale: 1.0)
        .padding()
        .background(Color.background)
}

