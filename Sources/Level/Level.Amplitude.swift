extension Level {
    /// Amplitude level: twenty times the decimal logarithm of a ratio of amplitudes (of pressures, velocities,
    /// any quantity whose square goes as a power), stored in decibels.
    public enum Amplitude {}
}

extension Level.Amplitude: Quantity.Kind {
    public static var dimension: Quantity.Dimension { Quantity.Dimension() }
}

extension Level.Amplitude {
    /// An amount of this kind, its scalar in decibels.
    public typealias Value<Scalar> = Tagged<Level.Amplitude, Scalar>
}

extension Level.Amplitude {
    /// The amplitude level of a ratio of amplitudes, 20 log₁₀ `ratio`.
    @inlinable
    public static func ratio<Scalar: Exponential.`Protocol`>(_ ratio: Scalar) -> Value<Scalar> {
        amount(20 * Scalar.log10(ratio))
    }

    /// The amplitude level of `value` against `reference`, 20 log₁₀ (`value` / `reference`).
    @inlinable
    public static func of<Kind: Quantity.Kind, Scalar: Exponential.`Protocol`>(
        _ value: Tagged<Kind, Scalar>,
        against reference: Tagged<Kind, Scalar>
    ) -> Value<Scalar> {
        ratio(value / reference)
    }
}
