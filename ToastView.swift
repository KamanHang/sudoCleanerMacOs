import SwiftUI

struct ToastView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.foreground)
            
            Text(description)
                .font(.system(size: 12))
                .foregroundColor(.mutedForeground)
        }
        .padding()
        .background(Color.card)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        .padding(.top, 20)
        .frame(maxWidth: .infinity, alignment: .top)
    }
}

#Preview {
    ToastView(title: "Cleaning Mode Activated! 🧹", description: "Press ESC 3 times quickly to stop")
        .padding()
        .background(Color.background)
}

