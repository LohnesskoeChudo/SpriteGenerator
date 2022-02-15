//
//  Created by VasiliyKlyotskin
//

import SpriteGeneratorCore

final class Table<T> {
    
    private var values: [[T]]
    var width: Int { values.first?.count ?? 0 }
    var height: Int { values.count }
    
    var positions: [Position] {
        values
        .enumerated()
        .flatMap { outerIndex, innerSequence in
            innerSequence
            .enumerated()
            .map { innerIndex, _ in Position(x: innerIndex, y: outerIndex) }
        }
    }
    
    init() { values = [[]] }

    init?(values: [[T]]) {
        self.values = values
        if !tableIsValid { return nil }
    }
    
    init(xSize: Int, ySize: Int, value: T) {
        let innerArray = Array(repeating: value, count: xSize)
        let values = Array(repeating: innerArray, count: ySize)
        self.values = values
    }
    
    subscript(position: Position) -> T? {
        get {
            guard isPositionInTable(position) else { return nil }
            return values[position.y][position.x]
        }
        set {
            guard isPositionInTable(position) else { return }
            guard let newValue = newValue else { return }
            values[position.y][position.x] = newValue
        }
    }
    
    var tableIsValid: Bool {
        let firstRowCount = values.first?.count
        return values.dropFirst().allSatisfy { row in
            firstRowCount == row.count
        }
    }
    
    private func isPositionInTable(_ position: Position) -> Bool {
        position.x < width && position.y < height &&
        position.x >= 0 && position.y >= 0
    }
}

extension Table where T: Equatable {
    
    func positionsFor(value: T) -> [Position] {
        positions.compactMap { position in
            if self[position] == value {
                return position
            } else {
                return nil
            }
        }
    }
    
    func positionsFor(values: [T]) -> [Position] {
        values.flatMap { positionsFor(value: $0) }
    }
}

extension Table: ColorOutput where T == Color {
    var positionsToOutput: [Position] {
        positions
    }
    
    func set(color: Color?, for position: Position) {
        if let color = color {
            self[position] = color
        }
    }
}

extension Color {
    static var black = Color(red: 0, green: 0, blue: 0, alpha: 1)
    static var red = Color(red: 1, green: 0, blue: 0, alpha: 1)
    static var blue = Color(red: 0, green: 0, blue: 1, alpha: 1)
    static var green = Color(red: 0, green: 1, blue: 0, alpha: 1)
    static var clear = Color(red: 0, green: 0, blue: 0, alpha: 0)
}
