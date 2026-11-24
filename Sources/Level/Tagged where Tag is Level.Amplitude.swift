public import Quantity

extension Tagged::Tagged where Tag == Level.Amplitude, Underlying: Exponential.`Protocol` {
    /// The ratio of amplitudes this level stands for, 10^(L / 20).
    @inlinable
    public var ratio: Underlying { Underlying.exp(underlying / 20 * Underlying.log(10)) }

    /// The amount this level stands for against `reference`: `reference` × 10^(L / 20).
    @inlinable
    public func value<Kind: Quantity.Kind>(against reference: Tagged<Kind, Underlying>) -> Tagged<Kind, Underlying> {
        reference * ratio
    }
}
