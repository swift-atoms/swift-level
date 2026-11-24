public import Numeric
public import Quantity

extension Tagged::Tagged where Tag == Level.Power, Underlying: Numeric.Transcendental {
    /// The ratio of powers this level stands for, 10^(L / 10).
    ///
    /// Taken as `pow`, which rounds once, where exp(L / 10 · ln 10) rounds the product before the exponential.
    @inlinable
    public var ratio: Underlying { Underlying._pow(10, underlying / 10) }

    /// The amount this level stands for against `reference`: `reference` × 10^(L / 10).
    @inlinable
    public func value<Kind: Quantity.Kind>(against reference: Tagged<Kind, Underlying>) -> Tagged<Kind, Underlying> {
        reference * ratio
    }
}
