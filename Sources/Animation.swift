// Copyright © 2016-19 JABT Labs Inc.
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

import UIKit

open class Animation: NSObject, CAAnimationDelegate {
    /// Key frame animations which animate the properties of `layer`.
    fileprivate var keyframeAnimations: [CAKeyframeAnimation]

    /// The CALayer whose properties are animated.
    open var layer: CALayer

    /// The current time of the animation. i.e. what time is being displayed.
    var time: TimeInterval {
        return layer.timeOffset
    }

    /// True if the animation is playing.
    var playing: Bool {
        return layer.speed != 0.0
    }

    // MARK: - Initializers

    public init(layer: CALayer, keyframeAnimations: [CAKeyframeAnimation]) {
        self.layer = layer
        self.keyframeAnimations = keyframeAnimations
        super.init()
        keyframeAnimations.forEach(configure)
        reset()
    }

    private func configure(keyframeAnimation: CAKeyframeAnimation) {
        keyframeAnimation.delegate = self
        keyframeAnimation.isRemovedOnCompletion = false
        keyframeAnimation.fillMode = .both
    }

    // MARK: - Playing & Resetting Animation

    /// Resumes the animation from where it was paused.
    open func play() {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }

    /// Pauses the animation.
    open func pause() {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        offset(to: pausedTime)
    }

    /// Resets the animation to time 0.
    open func reset() {
        CATransaction.suppressAnimations {
            layer.removeAllAnimations()
            layer.beginTime = 0
            offset(to: 0)

            for keyframeAnimation in keyframeAnimations {
                layer.setValue(keyframeAnimation.values?.first, forKeyPath: keyframeAnimation.keyPath!)
            }

            addAllAnimations()
            layer.speed = 0
        }
    }

    /// Adds all the animations to `layer` so they can be played.
    private func addAllAnimations() {
        for keyframeAnimation in keyframeAnimations {
            layer.add(keyframeAnimation, forKey: keyframeAnimation.keyPath)
        }
    }

    // MARK: - Driving Animation

    /// Shows the animation at time `time`.
    open func offset(to time: TimeInterval) {
        layer.speed = 0.0
        layer.timeOffset = time
    }

    // MARK: - CAAnimationDelegate

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            let duration = keyframeAnimations.first?.duration ?? 0
            offset(to: duration)
        }
    }
}

extension CATransaction {
    static func suppressAnimations(actions: () -> Void) {
        begin()
        setAnimationDuration(0)
        actions()
        commit()
    }
}

extension CAMediaTimingFunction {
    public static let linear = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    public static let easeIn = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
    public static let easeOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    public static let easeInEaseOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
}
