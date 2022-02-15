//
//  Created by VasiliyKlyotskin
//

import Foundation

struct HSV {
    
    let h: Double
    let s: Double
    let v: Double
    
    static func rgb(h: Double, s: Double, v: Double) -> RGB {
        if s == 0 { return RGB(r: v, g: v, b: v) }
        
        let angle = (h >= 360 ? 0 : h)
        let sector = angle / 60
        let i = floor(sector)
        let f = sector - i
        
        let p = v * (1 - s)
        let q = v * (1 - (s * f))
        let t = v * (1 - (s * (1 - f)))
        
        switch(i) {
        case 0:
            return RGB(r: v, g: t, b: p)
        case 1:
            return RGB(r: q, g: v, b: p)
        case 2:
            return RGB(r: p, g: v, b: t)
        case 3:
            return RGB(r: p, g: q, b: v)
        case 4:
            return RGB(r: t, g: p, b: v)
        default:
            return RGB(r: v, g: p, b: q)
        }
    }
    
    static func rgb(hsv: HSV) -> RGB {
        return rgb(h: hsv.h, s: hsv.s, v: hsv.v)
    }
    
    var rgb: RGB {
        return HSV.rgb(hsv: self)
    }
}
