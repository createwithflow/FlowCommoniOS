// Copyright © 2016-2019 JABT
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

import FlowCommoniOS
import QuartzCore
import XCTest

class CGPathSVGTests: XCTestCase {
    func testLine() {
        let path = CGPathCreateWithSVGString("M100,100 L200,200")
        let bounds = path!.boundingBox
        XCTAssertEqual(bounds, CGRect(x: 100, y: 100, width: 100, height: 100))
    }

    func testSquare() {
        let path = CGPathCreateWithSVGString("M-50,-50 l100,0 0,100 -100,0 0-100z")
        let bounds = path!.boundingBox
        XCTAssertEqual(bounds, CGRect(x: -50, y: -50, width: 100, height: 100))
        XCTAssertTrue(path!.contains(CGPoint()))
    }

}
