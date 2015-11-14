//
//  CGAffineTransformAdditions.swift
//  AnimatedReloadingTableViewExp
//
//  Created by Takeshi Tanaka on 11/1/15.
//  Copyright © 2015 p0dee. All rights reserved.
//

import Foundation
import UIKit

extension CGAffineTransform {
    var scale: (sx: CGFloat, sy: CGFloat) {
        return (sqrt(a * a + c * c), sqrt(b * b + d * d))
    }
    var angle: CGFloat {
        return atan2(b, a)
    }
}

func CGAffineTransformExtractScale(t: CGAffineTransform) -> CGAffineTransform {
    let (sx, sy) = t.scale
    return CGAffineTransformMakeScale(sx, sy)
}

func CGAffineTransformExtractRotation(t: CGAffineTransform) -> CGAffineTransform {
    let angle = t.angle
    return CGAffineTransformMakeRotation(angle)
}