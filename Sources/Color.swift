//
//  Created by VasiliyKlyotskin
//

public struct Color {
    
    private let rgb: RGB
    public let alpha: Double

    public init(red: Double, green: Double, blue: Double, alpha: Double = 1) {
        rgb = RGB(r: red, g: green, b: blue)
        self.alpha = alpha
    }
    
    public init(hue: Double, saturation: Double, value: Double, alpha: Double = 1) {
        let hsv = HSV(h: hue, s: saturation, v: value)
        rgb = hsv.rgb
        self.alpha = alpha
    }
    
    public init() {
        rgb = RGB(r: 1, g: 1, b: 1)
        self.alpha = 1
    }
    
    public func getRgb() -> (Double, Double, Double) {
        return (rgb.r, rgb.g, rgb.b)
    }
    
    public func getHsv() -> (Double, Double, Double) {
        let hsv = rgb.hsv
        return (hsv.h, hsv.s, hsv.v)
    }
}

extension Color {
    
    static func randomReadable() -> Color {
        let range = 0.28...0.9
        let red = Double.random(in: range)
        let greed = Double.random(in: range)
        let blue = Double.random(in: range)
        return Color(red: red, green: greed, blue: blue, alpha: 1)
    }
    
    func toColor(_ color: Color, percentage: Double) -> Color {
        let percentage = max(min(percentage, 1), 0)
        let ((r1, g1, b1), a1) = (getRgb(), alpha)
        let ((r2, g2, b2), a2) = (color.getRgb(), color.alpha)
        
        return Color(red: (r1 + (r2 - r1) * percentage),
                     green: (g1 + (g2 - g1) * percentage),
                     blue: (b1 + (b2 - b1) * percentage),
                     alpha: (a1 + (a2 - a1) * percentage))
    }
    
    func with(alpha: Double) -> Color {
        let alpha = alpha.limitFromZeroToOne
        let (r, g, b) = getRgb()
        return Color(red: r, green: g, blue: b, alpha: alpha)
    }
    
    func with(alphaRate rate: Double) -> Color {
        let (r, g, b) = getRgb()
        let alpha = (alpha * rate).limitFromZeroToOne
        return Color(red: r, green: g, blue: b, alpha: alpha)
    }

    func with(brightness: Double) -> Color {
        let brightness = brightness.limitFromZeroToOne
        let (h, s, _) = getHsv()
        return Color(hue: h, saturation: s, value: brightness, alpha: alpha)
    }
    
    func with(brightnessRate rate: Double) -> Color {
        let (h, s, v) = getHsv()
        let brightness = (v * rate).limitFromZeroToOne
        return Color(hue: h, saturation: s, value: brightness, alpha: alpha)
    }
    
    func with(saturation: Double) -> Color {
        let saturation = saturation.limitFromZeroToOne
        let (h, _, v) = getHsv()
        return Color(hue: h, saturation: saturation, value: v, alpha: alpha)
    }
    
    func with(saturationRate rate: Double) -> Color {
        let (h, s, v) = getHsv()
        let saturation = (s * rate).limitFromZeroToOne
        return Color(hue: h, saturation: saturation, value: v, alpha: alpha)
    }
}
