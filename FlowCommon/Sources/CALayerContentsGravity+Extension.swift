// Copyright © 2016-2019 JABT. All rights reserved.
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


extension CALayerContentsGravity {
    /// Returns a CALayerContentsGravity flipped about the vertical axis
    var flipped: CALayerContentsGravity {
        switch self {
        case .center:
            return .center
        case .top:
            return .bottom
        case .bottom:
            return .top
        case .left:
            return .left
        case .right:
            return .right
        case .topLeft:
            return .bottomLeft
        case .topRight:
            return .bottomRight
        case .bottomLeft:
            return .topLeft
        case .bottomRight:
            return .topRight
        case .resize:
            return .resize
        case .resizeAspect:
            return .resizeAspect
        case .resizeAspectFill:
            return .resizeAspectFill
        default:
            return self
        }
    }
}
