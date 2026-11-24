import Level
import Numeric
import Testing

enum `Level Tests` {}

/// A reference kind for the tests: a pressure-like amplitude, in its own unit.
enum Probe: Quantity.Kind {
    static var dimension: Quantity.Dimension { Quantity.Dimension(length: -1, mass: 1, time: -2) }
}

func close(_ lhs: Double, _ rhs: Double) -> Bool {
    abs(lhs - rhs) <= 1e-12 * max(1, abs(rhs))
}

extension `Level Tests` {
    @Suite struct `A power level is ten decibels per decade of power` {
        @Test func `Its dimension is one`() {
            #expect(Level.Power.dimension == Quantity.Dimension.one)
        }

        @Test func `An amount given in decibels keeps its scalar`() {
            #expect(Level.Power.amount(-3.0).underlying == -3.0)
        }

        @Test func `A ratio's level`() {
            #expect(Level.Power.ratio(1.0) == Level.Power.amount(0.0))
            #expect(Level.Power.ratio(100.0) == Level.Power.amount(20.0))
            #expect(Level.Power.ratio(0.001) == Level.Power.amount(-30.0))
        }

        @Test func `A level's ratio`() {
            #expect(Level.Power.amount(0.0).ratio == 1)
            #expect(close(Level.Power.amount(20.0).ratio, 100))
            #expect(close(Level.Power.amount(-30.0).ratio, 0.001))
            #expect(close(Level.Power.amount(3.0).ratio, 1.9952623149688795))
        }

        @Test func `A ratio's level, and back`() {
            for ratio in [0.25, 0.5, 2.0, 7.0, 1e6] {
                #expect(close(Level.Power.ratio(ratio).ratio, ratio))
            }
        }

        @Test func `Against an explicit reference`() {
            let reference = Probe.amount(2e-5)
            #expect(close(Level.Power.of(Probe.amount(2e-3), against: reference).underlying, 20))
            #expect(close(Level.Power.amount(20.0).value(against: reference).underlying, 2e-3))
        }
    }

    @Suite struct `An amplitude level is twenty decibels per decade of amplitude` {
        @Test func `Its dimension is one`() {
            #expect(Level.Amplitude.dimension == Quantity.Dimension.one)
        }

        @Test func `An amount given in decibels keeps its scalar`() {
            #expect(Level.Amplitude.amount(-6.0).underlying == -6.0)
        }

        @Test func `A ratio's level`() {
            #expect(Level.Amplitude.ratio(1.0) == Level.Amplitude.amount(0.0))
            #expect(Level.Amplitude.ratio(100.0) == Level.Amplitude.amount(40.0))
            #expect(Level.Amplitude.ratio(0.1) == Level.Amplitude.amount(-20.0))
        }

        @Test func `A level's ratio`() {
            #expect(Level.Amplitude.amount(0.0).ratio == 1)
            #expect(close(Level.Amplitude.amount(40.0).ratio, 100))
            #expect(close(Level.Amplitude.amount(-20.0).ratio, 0.1))
            #expect(close(Level.Amplitude.amount(6.0).ratio, 1.9952623149688795))
        }

        @Test func `A ratio's level, and back`() {
            for ratio in [0.25, 0.5, 2.0, 7.0, 1e6] {
                #expect(close(Level.Amplitude.ratio(ratio).ratio, ratio))
            }
        }

        @Test func `Against an explicit reference`() {
            let reference = Probe.amount(2e-5)
            #expect(close(Level.Amplitude.of(Probe.amount(2e-3), against: reference).underlying, 40))
            #expect(close(Level.Amplitude.amount(40.0).value(against: reference).underlying, 2e-3))
        }

        @Test func `One ratio is twice as many decibels of amplitude as of power`() {
            for ratio in [0.5, 3.0, 1e4] {
                #expect(close(Level.Amplitude.ratio(ratio).underlying, 2 * Level.Power.ratio(ratio).underlying))
            }
        }
    }
}

extension `Level Tests` {
    @Suite struct `A level's ratio is a power of ten` {
        @Test func `Taken as pow, to the bit`() {
            for decibels in stride(from: -60.0, through: 30.0, by: 0.37) {
                #expect(Level.Amplitude.amount(decibels).ratio == Double.math.pow(10, decibels / 20))
                #expect(Level.Power.amount(decibels).ratio == Double.math.pow(10, decibels / 10))
            }
        }
    }
}
