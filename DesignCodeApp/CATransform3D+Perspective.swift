//
//  CATransform3D+Perspective.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 08/03/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import QuartzCore

fileprivate let perspective : CGFloat = -1.0/2500

func CATransform3DMakeRotationWithPerspective(_ angle : CGFloat, _ x : CGFloat, _ y : CGFloat, _ z : CGFloat) -> CATransform3D {
    var transform = CATransform3DMakeRotation(angle, x, y, z)
    transform.m34 = perspective
    return transform
}

func CATransform3DMakeTranslationWithPerspective(_ x: CGFloat, _ y : CGFloat, _ z: CGFloat) -> CATransform3D {
    var transform = CATransform3DMakeTranslation(x, y, z)
    transform.m34 = perspective
    return transform
}
