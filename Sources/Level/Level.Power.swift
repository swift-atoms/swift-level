extension Level {
    /// Power level: ten times the decimal logarithm of a ratio of powers (or of intensities, energies, any
    /// quantity that goes as a power), stored in decibels.
    public enum Power {}
}

extension Level.Power: Quantity.Kind {
    public static var dimension: Quantity.Dimension { Quantity.Dimension() }
}

extension Level.Power {
    /// An amount of this kind, its scalar in decibels.
    public typealias Value<Scalar> = Tagged<Level.Power, Scalar>
}

extension Level.Power {
    /// The power level of a ratio of powers, 10 log₁₀ `ratio`.
    @inlinable
    public static func ratio<Scalar: Exponential.`Protocol`>(_ ratio: Scalar) -> Value<Scalar> {
        amount(10 * Scalar.log10(ratio))
    }

    /// The power level of `value` against `reference`, 10 log₁₀ (`value` / `reference`).
    @inlinable
    public static func of<Kind: Quantity.Kind, Scalar: Exponential.`Protocol`>(
        _ value: Tagged<Kind, Scalar>,
        against reference: Tagged<Kind, Scalar>
    ) -> Value<Scalar> {
        ratio(value / reference)
    }
}
