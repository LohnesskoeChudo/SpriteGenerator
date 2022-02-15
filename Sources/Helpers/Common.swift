//
//  Created by VasiliyKlyotskin
//

extension RandomAccessCollection where Index == Int {
    var second: Element? {
        count > 0 ? self[1] : nil
    }
}

extension Dictionary {
    mutating func value(for key: Key, setResultIfNotFound value: () -> Value) -> Value {
        if let value = self[key] {
            return value
        } else {
            let value = value()
            self[key] = value
            return value
        }
    }
}

extension FloatingPoint {
    var limitFromZeroToOne: Self {
        min(1, max(0, self))
    }
}
