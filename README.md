# swift-level

Use this package when a value is a level in decibels: a power level or an amplitude level, each against its reference. `Level` is a namespace; start from `Level.Power` or `Level.Amplitude`, kinds of quantity of swift-quantity, and make an amount with `amount(_:)` in decibels, from a ratio with `ratio(_:)`, or from two amounts of one kind with `of(_:against:)`. An amount is a `Level.Power.Value<Scalar>` or `Level.Amplitude.Value<Scalar>`, a `Tagged` of its kind. The conversions need a scalar that conforms to `Exponential.Protocol` (swift-exponential). This package conforms no type; import swift-numeric, which conforms `Double`, `Float` and `Float16`.

## Laws

- An amount of either kind is stored in decibels and is laid out exactly as its scalar. Its dimension is one.
- `Level.Power` is 10 log₁₀ of a ratio of quantities that go as a power (power, intensity, energy); `Level.Amplitude` is 20 log₁₀ of a ratio of quantities whose square goes as a power (pressure, velocity, a gain applied to a signal).
- The two are distinct kinds and never add or compare with each other: the same ratio is twice as many decibels of amplitude as of power. Neither converts to the other.
- A level carries no reference of its own. The reference is named at each conversion: `of(value, against: reference)` makes a level from two amounts of one kind, and `level.value(against: reference)` is the amount it stands for, `reference` × its `ratio`.
- `ratio` is 10^(L / 10) for a power level and 10^(L / 20) for an amplitude level, the inverse of `ratio(_:)` to within rounding; 0 dB is a ratio of exactly one, and a ratio that is a power of ten gives a whole number of decibels exactly where the scalar's `log10` is exact.
- Amounts of one kind add, scale and compare as swift-quantity gives every kind. Adding two levels multiplies their ratios.
