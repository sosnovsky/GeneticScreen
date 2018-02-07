//
//  Extensions.swift
//  GeneticScreen
//
//  Created by Roma Sosnovsky on 8/2/16.
//  Copyright © 2016 Roma Sosnovsky. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    func getCenterPoint() -> CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}
