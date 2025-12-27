import SwiftUI

extension Color {
    // Background colors - light mode only
    static var background: Color {
        Color(red: 0.98, green: 0.98, blue: 0.98)
    }
    
    static var foreground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.22)
    }
    
    // Card colors - light mode only
    static var card: Color {
        Color.white
    }
    
    static var cardForeground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.22)
    }
    
    // Primary colors (coral)
    static let primary = Color(red: 0.98, green: 0.55, blue: 0.45)
    static let primaryForeground = Color.white
    
    // Secondary colors - light mode only
    static var secondary: Color {
        Color(red: 0.85, green: 0.94, blue: 0.98)
    }
    
    static var secondaryForeground: Color {
        Color(red: 0.2, green: 0.5, blue: 0.6)
    }
    
    // Muted colors - light mode only
    static var muted: Color {
        Color(red: 0.94, green: 0.93, blue: 0.92)
    }
    
    static var mutedForeground: Color {
        Color(red: 0.5, green: 0.5, blue: 0.52)
    }
    
    // Accent colors (teal)
    static var accent: Color {
        Color(red: 0.2, green: 0.65, blue: 0.55)
    }
    
    static let accentForeground = Color.white
    
    // Border - light mode only
    static var border: Color {
        Color(red: 0.9, green: 0.88, blue: 0.86)
    }
}

