# Flow Common Files for iOS
A major goal behind our efforts here at Flow is to produce the cleanest code possible. For any platform, this means conforming to industry standards. For iOS, in particular, it means staying away from 3rd party libraries.

To make things as clean as possible, we include with every export a few files that extend the native functionality of iOS classes.

## Installation

### CocoaPods
To install `FlowCommoniOS` using CocoaPods add `pod 'FlowCommoniOS'` to your projects Podfile and run `pod install` in your projects directory.
If you've never used CocoaPods before refer to https://guides.cocoapods.org/using/getting-started.html.

## Classes

There are 6 classes that are required for running any iOS project that uses Flow timelines. A few of these are relatively small subclasses, such as `TextView`. There are also a few larger classes, such as `Animation` and `Timeline` that are critical for bringing lovely Flow functionality to your apps.

You can find all of the common files in any iOS project exported from Flow. From the XCode project navigator, you can find them in the `FlowCommon` directory.

![Flow Common Files in Xcode](https://createwithflow.com/assets/images/api/flowcommon/xcodeFlowCommon.png)

### Animation
An `Animation` object represents the details of a specific animation, including timing, the layer being animated, as well as methods for playback and control. 

> Our [Animation](https://createwithflow.com/api/flowcommon/animation/) doc is an in-depth view of this class.

### Timeline
A `Timeline` object represents a set of animations associated with a view. It contains references to the main view being animated, as well as the duration, sounds, and other options such as repeat. This class is responsible for initiating and controlling the playback for all animations associated with the view.

> Our [Timeline](https://createwithflow.com/api/flowcommon/timeline) doc is an in-depth view of this class.

### SVG Parser
The `SVGPathStringParser` class is responsible for converting an SVG string into a `CGPath`. It is super useful, and you can even use it on its own outside of a Flow project. 

> Our [SVGPathStringParser](https://createwithflow.com/api/flowcommon/svgpathstringparser) doc is an in-depth view of this class.

There is also an `SVGPathStringTokenizer` class that breaks down an SVG string into its component (i.e. token) elements, so that it can be accurately rebuilt as a `CGPath`.

With these classes, parsing an SVG string is as simple as:

`let string = CGPathCreateWithSVGString("M0...")`

> Our [SVGPathStringTokenizer](https://createwithflow.com/api/flowcommon/svgpathstringparser) doc is an in-depth view of this class.

### Shape View
A `ShapeView` object is a simple subclass of `UIView` that includes variables for:

* `shapeLayer: CAShapeLayer`
* `gradientLayer: CAGradientLayer?`
* `path: CGPath?`

> Our [Shape View](https://createwithflow.com/api/flowcommon/shapeview) doc is an in-depth view of this class.

### Text View
A `TextView` is a simple subclass of `UILabel` that exposes a `textLayer` variable.

> Our [Text View](https://createwithflow.com/api/flowcommon/textview) doc is an in-depth view of this class.

### Sound
A `Sound` object contains an `AVAudioPlayer`, once created it will play a sound after a specific `TimeInterval` has elapsed.

> Our [Sound](https://createwithflow.com/api/flowcommon/sound) doc is an in-depth view of this class.

## Extensions
There are a few simple extensions to native iOS classes that are necessary for running Flow animations in an iOS project. Many of these bring a lot of power and functionality that can be used outside of Flow-related projects.

### CAKeyframeAnimation
This extension defines a variable called `reversed` that reverses the timing and values of a standard `CAKeyframeAnimation` object.

> Our [CAKeyframeAnimation](https://createwithflow.com/api/flowcommon/cakeyframeanimation) doc is an in-depth view of this extension.

### CAMediaTimingFunction
This extension adds new variables and options to the standard iOS timing functions. For example, it defines a `var reversed` that returns the reversed version of the current timing function.

> Our [CAMediaTimingFunction](https://createwithflow.com/api/flowcommon/camediatimingfunction) doc is an in-depth view of this extension.

### CATransaction
This extension adds an incredibly handy function responsible for suppressing animations. This is super handy for anyone who uses Core Animation.

> Our [CATransaction](https://createwithflow.com/api/flowcommon/catransaction) doc is an in-depth view of this extension.

### CharacterSet
This extension adds a useful function for determining if a particular character is part of the current character set.

> Our [CharacterSet](https://createwithflow.com/api/flowcommon/characterset) doc is an in-depth view of this extension.

### NSMutableParagraphStyle
This extension adds a handy initialization method for creating paragraph styles.

> Our [NSMutableParagraphStyle](https://createwithflow.com/api/flowcommon/nsmutableparagraphstyle) doc is an in-depth view of this extension.

### NSShadow
This extension adds a handy initialization method for creating shadows.

> Our [NSShadow](https://createwithflow.com/api/flowcommon/nsshadow) doc is an in-depth view of this extension.

### UIImage
This extension adds a convenient method for resizing images.

> Our [UIImage](https://createwithflow.com/api/flowcommon/uiimage) doc is an in-depth view of this extension.

### UIView
This extension adds a convenient method for setting the `transform` property on a view.

> Our [UIView](https://createwithflow.com/api/flowcommon/uiview) doc is an in-depth view of this extension.
