//
//  Created by VasiliyKlyotskin
//

struct RGB {
    
    let r: Double
    let g: Double
    let b: Double
    
    static func hsv(r: Double, g: Double, b: Double) -> HSV {
        let min = r < g ? (r < b ? r : b) : (g < b ? g : b)
        let max = r > g ? (r > b ? r : b) : (g > b ? g : b)
        
        let v = max
        let delta = max - min
        
        guard delta > 0.00001 else { return HSV(h: 0, s: 0, v: max) }
        guard max > 0 else { return HSV(h: -1, s: 0, v: v) }
        let s = delta / max
        
        let hue: (Double, Double) -> Double = { max, delta -> Double in
            if r == max { return (g-b) / delta }
            else if g == max { return 2 + (b-r) / delta }
            else { return 4 + (r-g) / delta }
        }
        
        let h = hue(max, delta) * 60
        return HSV(h: (h < 0 ? h+360 : h) , s: s, v: v)
    }
    
    static func hsv(rgb: RGB) -> HSV {
        return hsv(r: rgb.r, g: rgb.g, b: rgb.b)
    }
    
    var hsv: HSV {
        return RGB.hsv(rgb: self)
    }
}
