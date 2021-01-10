public struct NonEmpty<Collection: Swift.Collection> {
    public internal(set) var rawValue: Collection
    
    public init?(rawValue: Collection) {
       guard !rawValue.isEmpty else { return nil }
       self.rawValue = rawValue
     }
}

extension NonEmpty: Sequence {
    public func makeIterator() -> AnyIterator<Collection.Element> {
        return AnyIterator(rawValue.makeIterator())
    }
}

extension NonEmpty: Equatable where Collection: Equatable {}

extension NonEmpty: Hashable where Collection: Hashable {}
