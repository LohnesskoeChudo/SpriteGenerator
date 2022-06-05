//
//  Created by VasiliyKlyotskin
//

import Foundation

public struct Point {
    
    let x: Double
    let y: Double
    
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func distanceTo(point: Point) -> Double {
        let xDistance = point.x - x
        let yDistance = point.y - y
        return hypot(xDistance, yDistance)
    }
}
