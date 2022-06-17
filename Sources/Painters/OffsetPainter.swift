//
//  OffsetPainter.swift
//  SpriteGenerator
//
//  Created by VasiliyKlyotskin on 17.06.2022.
//

import Foundation

final class OffsetPainter: Painter {

    private let wrapee: Painter
    private let xOffset: Int
    private let yOffset: Int

    init(x: Int, y: Int, wrapee: Painter) {
        self.wrapee = wrapee
        xOffset = x
        yOffset = y
    }

    func color(for position: Position) -> Color? {
        let offsetPosition = Position(x: position.x - xOffset, y: position.y - yOffset)
        return wrapee.color(for: offsetPosition)
    }
}
