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
        return (sqrt(self.a * self.a + self.c * self.c), sqrt(self.b * self.b + self.d * self.d))
    }
    var angle: CGFloat {
        return atan2(self.b, self.a)
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