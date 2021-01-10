extension Decimal {
    
    public func round(scale: Int, mode: RoundingMode) -> Decimal {
        var value = self
        var result = value
        NSDecimalRound(&result, &value, scale, mode)
        return result
    }
}
