//
//  Created by VasiliyKlyotskin
//

import Darwin

typealias LinearGradientKeyPoint = (painter: Painter, relativeOffset: Double)

struct NearestPoints {
    var first: LinearGradientKeyPoint
    var second: LinearGradientKeyPoint
    
    mutating func orderByRelativeOffset() {
        if second.relativeOffset < first.relativeOffset {
            swap(&first, &second)
        }
    }
}


final class LinearGradientPainter: ProvidedValueForPositionPainter<Color> {
    
    private let keyPoints: [LinearGradientKeyPoint]
    private let startPoint: Point
    private let endPoint: Point
    
    private lazy var planePointsForKeyPoints: [Point] = {
        return keyPoints.map {
            let x = Double(startPoint.x) + $0.relativeOffset * Double(endPoint.x - startPoint.x)
            let y = Double(startPoint.y) + $0.relativeOffset * Double(endPoint.y - startPoint.y)
            return Point(x: x, y: y)
        }
    }()
    
    private lazy var edgePositionsDistance: Double = {
        let xDistance = Double(endPoint.x - startPoint.x)
        let yDistance = Double(endPoint.y - startPoint.y)
        return hypot(xDistance, yDistance)
    }()

    init(keyPoints: [LinearGradientKeyPoint],
         startPoint: Point,
         endPoint: Point) {
        self.keyPoints = keyPoints
        self.startPoint = startPoint
        self.endPoint = endPoint
        super.init()
    }
    
    override func provideValue(for position: Position) -> Color {
        var keyPoints = getNearestKeyPoints(for: position)
        keyPoints.orderByRelativeOffset()
        let colorPercent = colorPercantageFor(position: position, keyPoints: keyPoints)
        let color = keyPoints.first.painter.color(for: position) ?? Color()
        let targetColor = keyPoints.second.painter.color(for: position) ?? Color()
        return color.toColor(targetColor, percentage: colorPercent)
    }
    
    override func color(for position: Position) -> Color? {
        guard colorNeeds(for: position) else { return nil }
        return valueFor(position: position)
    }
    
    private func colorNeeds(for position: Position) -> Bool {
        keyPoints.allSatisfy { $0.painter.applied(to: position) }
    }
    
    private func colorPercantageFor(position: Position, keyPoints: NearestPoints) -> Double {
        let relativeOffsetForPosition = relativeOffset(for: position)
        let relativeOffsetForFirstKeyPoint = keyPoints.first.relativeOffset
        let relativeOffsetForSecondKeyPoint = keyPoints.second.relativeOffset
        let colorPercent = (relativeOffsetForPosition - relativeOffsetForFirstKeyPoint) / (relativeOffsetForSecondKeyPoint - relativeOffsetForFirstKeyPoint)
        return colorPercent
    }
    
    private func relativeOffset(for position: Position) -> Double {
        let pointOnGradientLine = findPointOnGradientLine(for: position)
        let offset = pointOnGradientLine.distanceTo(point: startPoint)
        return (offset / edgePositionsDistance).limitFromZeroToOne
    }
    
    private func findPointOnGradientLine(for position: Position) -> Point {
        let (x1, y1) = (startPoint.x, startPoint.y)
        let (x2, y2) = (endPoint.x, endPoint.y)
        let (x3, y3) = (position.point.x, position.point.y)
        let k = ((y2-y1)*(x3-x1) - (x2-x1)*(y3-y1)) / ((y2-y1)*(y2-y1) + (x2-x1)*(x2-x1))
        let x4 = x3 - k * (y2-y1)
        let y4 = y3 + k * (x2-x1)
        return Point(x: x4, y: y4)
    }
    
    private func getNearestKeyPoints(for position: Position) -> NearestPoints {
        let positionPoint = position.point
        let keyPointsSortedByDistances = keyPointsSortedByDistance(to: positionPoint)
        guard let firstKeyPoint = keyPointsSortedByDistances.first else {
            let keyPoint = LinearGradientKeyPoint(painter: VoidPainter(), relativeOffset: 0)
            return NearestPoints(first: keyPoint, second: keyPoint)
        }
        guard let secondKeyPoint = keyPointsSortedByDistances.second else {
            return NearestPoints(first: firstKeyPoint, second: firstKeyPoint)
        }
        return NearestPoints(first: firstKeyPoint, second: secondKeyPoint)
    }
    
    private func keyPointsSortedByDistance(to point: Point) -> [LinearGradientKeyPoint] {
        zip(keyPoints, planePointsForKeyPoints)
        .map { (gradientKeyPoint, planePointForGradientPoint) in
            (gradientKeyPoint, point.distanceTo(point: planePointForGradientPoint))
        }
        .sorted { $0.1 < $1.1 }
        .map { $0.0 }
    }
}
