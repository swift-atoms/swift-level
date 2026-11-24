public import Quantity

extension Tagged::Tagged where Tag == Level.Power, Underlying: Exponential.`Protocol` {
    /// The ratio of powers this level stands for, 10^(L / 10).
    @inlinable
    public var ratio: Underlying { Underlying.exp(underlying / 10 * Underlying.log(10)) }

    /// The amount this level stands for against `reference`: `reference` × 10^(L / 10).
    @inlinable
    public func value<Kind: Quantity.Kind>(against reference: Tagged<Kind, Underlying>) -> Tagged<Kind, Underlying> {
        reference * ratio
    }
}
