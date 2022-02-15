//
//  Created by VasiliyKlyotskin
//

import Foundation

public struct Position: Hashable {
    public let x: Int
    public let y: Int
    
    var point: Point {
        Point(x: Double(x) + 0.5, y: Double(y) + 0.5)
    }
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    public init() {
        x = 0
        y = 0
    }

    func distanceTo(position: Position) -> Double {
        let xDistance = Double(position.x - x)
        let yDistance = Double(position.y - y)
        return hypot(xDistance, yDistance)
    }
}
