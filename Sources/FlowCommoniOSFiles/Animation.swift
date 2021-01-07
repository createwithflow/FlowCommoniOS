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

import UIKit

open class Animation: NSObject, CAAnimationDelegate {
    /// Key frame animations which animate the properties of `layer`.
    fileprivate var keyframeAnimations: [CAKeyframeAnimation]

    /// The CALayer whose properties are animated.
    open var layer: CALayer

    /// Specifies whether or not the animation should autoreverse.
    var autoreverses: Bool

    /// Determines the number of times the animation will repeat.
    ///
    /// May be fractional. If the repeatCount is 0, it is ignored.
    /// Setting this property to greatestFiniteMagnitude will cause the animation to repeat forever.
    var repeatCount: Float

    weak var delegate: AnimationDelegate?

    /// The current time of the animation. i.e. what time is being displayed.
    var time: TimeInterval {
        return layer.timeOffset
    }

    /// True if the animation is playing.
    var playing: Bool {
        return layer.speed != 0.0
    }

    // MARK: - Initializers

    public init(layer: CALayer, keyframeAnimations: [CAKeyframeAnimation], autoreverses: Bool = false, repeatCount: Float = 0) {
        self.layer = layer
        self.keyframeAnimations = keyframeAnimations
        self.autoreverses = autoreverses
        self.repeatCount = repeatCount

        super.init()
        keyframeAnimations.forEach(configure)
        reset()
    }

    private func configure(keyframeAnimation: CAKeyframeAnimation) {
        keyframeAnimation.delegate = self
        keyframeAnimation.isRemovedOnCompletion = false
        keyframeAnimation.fillMode = .both
        keyframeAnimation.autoreverses = autoreverses
        keyframeAnimation.repeatCount = repeatCount
    }

    // MARK: - Playing & Resetting Animation

    /// Resumes the animation from where it was paused.
    open func play() {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime

        for keyframeAnimation in keyframeAnimations {
            keyframeAnimation.timeOffset = 0
        }
        layer.beginTime = timeSincePause
    }

    /// Pauses the animation.
    open func pause() {
        offset(to: layer.convertTime(CACurrentMediaTime(), from: nil))
        layer.speed = 0
    }

    /// Resets the animation to time 0,
    /// and asychronously executes the completion block when the animation is ready to be played.
    open func reset(onCompletion: ((Animation) -> Void)? = nil) {
        CATransaction.suppressAnimations {
            layer.removeAllAnimations()
            
            for keyframeAnimation in keyframeAnimations {
                layer.setValue(keyframeAnimation.values?.first, forKeyPath: keyframeAnimation.keyPath!)
            }

            offset(to: 0)

            DispatchQueue.main.async { [weak self] in
                self?.addAllAnimations(onCompletion: onCompletion)
            }

            layer.speed = 0
        }
    }

    /// Adds all the animations to `layer` so they can be played.
    private func addAllAnimations(onCompletion: ((Animation) -> Void)? = nil) {
            for keyframeAnimation in keyframeAnimations {
                layer.add(keyframeAnimation, forKey: keyframeAnimation.keyPath)
            }

            onCompletion?(self)
    }

    // MARK: - Driving Animation

    /// Shows the animation at time `time`.
    public func offset(to newTime: TimeInterval) {
        layer.beginTime = layer.convertTime(CACurrentMediaTime(), from: nil) - newTime
        layer.timeOffset = newTime
        for keyframeAnimation in keyframeAnimations {
            keyframeAnimation.timeOffset = newTime
            keyframeAnimation.repeatDuration = keyframeAnimation.duration - keyframeAnimation .timeOffset
        }
    }

    // MARK: - CAAnimationDelegate

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag else {
            return
        }

        let newTime = autoreverses ? 0 : (keyframeAnimations.first?.duration ?? 0)
        offset(to: newTime)

        if let keyframeAnimation = anim as? CAKeyframeAnimation,
            keyframeAnimations.first?.keyPath == keyframeAnimation.keyPath {
            delegate?.didStop(animation: self)
        }
    }
}

public extension Animation {
    var reversed: Animation {
        let reversedKeyFrameAnimations = keyframeAnimations.map { $0.reversed }
        return Animation(layer: layer, keyframeAnimations: reversedKeyFrameAnimations)
    }
}

protocol AnimationDelegate: class {
    func didStop(animation: Animation)
}
