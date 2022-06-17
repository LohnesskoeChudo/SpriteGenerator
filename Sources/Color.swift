//
//  Created by VasiliyKlyotskin
//

public struct Color {
    
    private let hsv: HSV
    public let alpha: Double

    public init(red: Double, green: Double, blue: Double, alpha: Double = 1) {
        hsv = RGB(r: red, g: green, b: blue).hsv
        self.alpha = alpha
    }
    
    public init(hue: Double, saturation: Double, value: Double, alpha: Double = 1) {
        hsv = HSV(h: hue, s: saturation, v: value)
        self.alpha = alpha
    }
    
    public init() {
        hsv = HSV(h: 0, s: 0, v: 0)
        self.alpha = 0
    }
    
    public func getRgb() -> (Double, Double, Double) {
        let rgb = hsv.rgb
        return (rgb.r, rgb.g, rgb.b)
    }
    
    public func getHsv() -> (Double, Double, Double) {
        return (hsv.h, hsv.s, hsv.v)
    }
}

extension Color {
    
    static func randomReadable() -> Color {
        let hue = Double.random(in: 0..<360)
        return Color(hue: hue, saturation: 0.5, value: 0.9)
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

    func getSepia() -> Color {
        let (r, g, b) = getRgb()
        let sr = (0.393*r + 0.769*g + 0.189*b).limitFromZeroToOne
        let sg = (0.349*r + 0.686*g + 0.168*b).limitFromZeroToOne
        let sb = (0.272*r + 0.534*g + 0.131*b).limitFromZeroToOne
        return Color(red: sr, green: sg, blue: sb, alpha: alpha)
    }

    func getGrayscale() -> Color {
        let (_, _, v) = getHsv()
        return Color(hue: 0, saturation: 0, value: v, alpha: alpha)
    }
}
