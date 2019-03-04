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

    public var time: TimeInterval {
        return animations.first?.time ?? 0
    }

    public var playing: Bool {
        return animations.first?.playing ?? false
    }

    // MARK: - Initializers

    public init(view: UIView, animations: [Animation], sounds: [(sound: AVAudioPlayer, delay: TimeInterval)], duration: TimeInterval) {
        self.view = view
        self.animations = animations
        self.duration = duration
        self.sounds = sounds
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
