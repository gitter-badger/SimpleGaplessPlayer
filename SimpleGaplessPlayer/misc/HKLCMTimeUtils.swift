//
//  HKLCMTimeUtils.swift
//
//  Created by Hirohito Kato on 2014/12/03.
//

import CoreMedia

// MARK: Initialization
extension CMTime: Comparable {
    public init(value: Int64, _ timescale: Int32 = 1) {
        self = CMTimeMake(value, timescale)
    }
    public init(seconds: Float64, preferredTimeScale: Int32 = 1_000_000_000) {
        self = CMTimeMakeWithSeconds(seconds, preferredTimeScale)
    }
    public init(seconds: Float, preferredTimeScale: Int32 = 1_000_000_000) {
        self = CMTime(seconds: Float64(seconds), preferredTimeScale: preferredTimeScale)
    }
}

// MARK: - Arithmetic Protocol
// MARK: Add
func + (left: CMTime, right: CMTime) -> CMTime {
    return CMTimeAdd(left, right)
}
func += (inout left: CMTime, right: CMTime) -> CMTime {
    left = left + right
    return left
}

// MARK: Subtract
func - (minuend: CMTime, subtrahend: CMTime) -> CMTime {
    return CMTimeSubtract(minuend, subtrahend)
}
func -= (inout minuend: CMTime, subtrahend: CMTime) -> CMTime {
    minuend = minuend - subtrahend
    return minuend
}

// MARK: Multiply
func * (time: CMTime, multiplier: Int32) -> CMTime {
    return CMTimeMultiply(time, multiplier)
}
func * (multiplier: Int32, time: CMTime) -> CMTime {
    return CMTimeMultiply(time, multiplier)
}
func * (time: CMTime, multiplier: Float64) -> CMTime {
    return CMTimeMultiplyByFloat64(time, multiplier)
}
func * (time: CMTime, multiplier: Float) -> CMTime {
    return CMTimeMultiplyByFloat64(time, Float64(multiplier))
}
func * (multiplier: Float64, time: CMTime) -> CMTime {
    return time * multiplier
}
func * (multiplier: Float, time: CMTime) -> CMTime {
    return time * multiplier
}
func *= (inout time: CMTime, multiplier: Int32) -> CMTime {
    time = time * multiplier
    return time
}
func *= (inout time: CMTime, multiplier: Float64) -> CMTime {
    time = time * multiplier
    return time
}
func *= (inout time: CMTime, multiplier: Float) -> CMTime {
    time = time * multiplier
    return time
}

// MARK: Divide
func / (time: CMTime, divisor: Int32) -> CMTime {
    return CMTimeMultiplyByRatio(time, 1, divisor)
}
func /= (inout time: CMTime, divisor: Int32) -> CMTime {
    time = time / divisor
    return time
}

// MARK: - Comparable protocol
public func == (time1: CMTime, time2: CMTime) -> Bool {
    return CMTimeCompare(time1, time2) == 0
}
public func < (time1: CMTime, time2: CMTime) -> Bool {
    return CMTimeCompare(time1, time2) < 0
}

// MARK: - Convenience methods
extension CMTime {
    func isNearlyEqualTo(time: CMTime, _ tolerance: CMTime=CMTimeMake(1,600)) -> Bool {
        let delta = CMTimeAbsoluteValue(self - time)
        return delta < tolerance
    }
    func isNearlyEqualTo(time: CMTime, _ tolerance: Float64=1.0/600) -> Bool {
        return isNearlyEqualTo(time, CMTime(seconds:tolerance))
    }
    func isNearlyEqualTo(time: CMTime, _ tolerance: Float=1.0/600) -> Bool {
        return isNearlyEqualTo(time, CMTime(seconds:tolerance))
    }
}
func == (time: CMTime, seconds: Float64) -> Bool {
    return time == CMTime(seconds: seconds)
}
func == (time: CMTime, seconds: Float) -> Bool {
    return time == Float64(seconds)
}
func == (seconds: Float64, time: CMTime) -> Bool {
    return time == seconds
}
func == (seconds: Float, time: CMTime) -> Bool {
    return time == seconds
}
func != (time: CMTime, seconds: Float64) -> Bool {
    return !(time == seconds)
}
func != (time: CMTime, seconds: Float) -> Bool {
    return time != Float64(seconds)
}
func != (seconds: Float64, time: CMTime) -> Bool {
    return time != seconds
}
func != (seconds: Float, time: CMTime) -> Bool {
    return time != seconds
}

public func < (time: CMTime, seconds: Float64) -> Bool {
    return time < CMTime(seconds: seconds)
}
public func < (time: CMTime, seconds: Float) -> Bool {
    return time < Float64(seconds)
}
public func <= (time: CMTime, seconds: Float64) -> Bool {
    return time < seconds || time == seconds
}
public func <= (time: CMTime, seconds: Float) -> Bool {
    return time < seconds || time == seconds
}
public func < (seconds: Float64, time: CMTime) -> Bool {
    return CMTime(seconds: seconds) < time
}
public func < (seconds: Float, time: CMTime) -> Bool {
    return Float64(seconds) < time
}
public func <= (seconds: Float64, time: CMTime) -> Bool {
    return seconds < time || seconds == time
}
public func <= (seconds: Float, time: CMTime) -> Bool {
    return seconds < time || seconds == time
}

public func > (time: CMTime, seconds: Float64) -> Bool {
    return time > CMTime(seconds: seconds)
}
public func > (time: CMTime, seconds: Float) -> Bool {
    return time > Float64(seconds)
}
public func >= (time: CMTime, seconds: Float64) -> Bool {
    return time > seconds || time == seconds
}
public func >= (time: CMTime, seconds: Float) -> Bool {
    return time > seconds || time == seconds
}
public func > (seconds: Float64, time: CMTime) -> Bool {
    return CMTime(seconds: seconds) > time
}
public func > (seconds: Float, time: CMTime) -> Bool {
    return Float64(seconds) > time
}
public func >= (seconds: Float64, time: CMTime) -> Bool {
    return seconds > time || seconds == time
}
public func >= (seconds: Float, time: CMTime) -> Bool {
    return seconds > time || seconds == time
}

// MARK: - Debugging
extension CMTime: Printable,DebugPrintable {
    public var description: String {
        return "\(CMTimeGetSeconds(self))"
    }
    public var debugDescription: String {
        return String(CMTimeCopyDescription(nil, self))
    }
}

extension CMTimeRange: Printable,DebugPrintable {
    public var description: String {
        return "{\(self.start.value)/\(self.start.timescale),\(self.duration.value)/\(self.duration.timescale)}"
    }
    public var debugDescription: String {
        return "{start:\(self.start), duration:\(self.duration)}"
    }
}