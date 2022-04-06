//
//  Created by VasiliyKlyotskin on 06.04.2022.
//

typealias PositionCache<V> = Cache<Position, V>

struct Cache<K,V> where K: Hashable {

    private var storage = [K: V]()

    func get(with key: K) -> V? {
        guard let value = storage[key] else { return nil }
        return value
    }

    mutating func set(with key: K, value: V) {
        storage[key] = value
    }

    mutating func get(with key: K, defaultValueProvider: () -> V) -> V {
        if let value = storage[key] {
            return value
        } else {
            let value = defaultValueProvider()
            storage[key] = value
            return value
        }
    }
}
