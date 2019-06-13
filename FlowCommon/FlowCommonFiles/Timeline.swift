// Copyright © 2016-2019 JABT Labs Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions: The above copyright
// notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

import Foundation
import UIKit
import AVFoundation

public class Timeline {
    public var view: UIView
    public var duration: TimeInterval
    public let animations: [Animation]
    public let sounds: [(sound: AVAudioPlayer, delay: TimeInterval)]

    /// Specifies whether or not the timeline's animations autoreverse.
    public let autoreverses: Bool

    /// Determines the number of times the timeline's animations will repeat.
    ///
    /// May be fractional. If the repeatCount is 0, it is ignored.
    /// Setting this property to greatestFiniteMagnitude will cause the timeline to repeat forever.
    public let repeatCount: Float

    public var time: TimeInterval {
        return animations.first?.time ?? 0
    }

    public var playing: Bool {
        return animations.first?.playing ?? false
    }

    // MARK: - Initializers

    public convenience init(view: UIView, animationsByLayer: [CALayer: [CAKeyframeAnimation]], sounds: [(sound: AVAudioPlayer, delay: TimeInterval)], duration: TimeInterval, autoreverses: Bool = false, repeatCount: Float = 0) {

        let animations = animationsByLayer.map {
            Animation(layer: $0.0, keyframeAnimations: $0.1, autoreverses: autoreverses, repeatCount: repeatCount)
        }

        self.init(view: view, animations: animations, sounds: sounds, duration: duration, autoreverses: autoreverses, repeatCount: repeatCount)
    }

    fileprivate init(view: UIView, animations: [Animation], sounds: [(sound: AVAudioPlayer, delay: TimeInterval)], duration: TimeInterval, autoreverses: Bool, repeatCount: Float) {
        self.view = view
        self.duration = duration
        self.sounds = sounds
        self.autoreverses = autoreverses
        self.repeatCount = repeatCount
        self.animations = animations
    }

    // MARK: - Timeline Playback controls

    /// Reset to the initial state of the timeline
    public func reset() {
        for animation in animations {
            animation.reset()
        }
    }

    /// Resume playing the timeline.
    public func play() {
        playSounds()
        for animation in animations {
            animation.play()
        }
    }

    private func playSounds() {
        for (sound, delay) in sounds {
            Sound.playAudio(sound, delay: delay)
        }
    }

    /// Pause playing of timeline.
    public func pause() {
        for animation in animations {
            animation.pause()
        }
    }

    /// Show timeline at time `time`.
    public func offset(to time: TimeInterval) {
        let time = max(min(time, duration), 0)
        for animation in animations {
            animation.offset(to: time)
        }
    }
}

public extension Timeline {
    var reversed: Timeline {
        let reversedAnimations = animations.map { $0.reversed }
        return Timeline(view: view, animations: reversedAnimations, sounds: sounds, duration: duration, autoreverses: autoreverses, repeatCount: repeatCount)
    }
}
