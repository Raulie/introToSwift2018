//
//  ColorManager.swift
//  Homework5_RMC
//
//  Created by Raúl Mora-Colón on 4/13/18.
//  Copyright © 2018 Raúl Mora-Colón. All rights reserved.
//

import UIKit

struct ColorManager {
    static let maxRGBValue: UInt32 = 255
    static let maxRGBFloatValue: CGFloat = CGFloat(maxRGBValue)
}

extension ColorManager {
    static var randomRGBValue: CGFloat {
        return CGFloat(arc4random_uniform(maxRGBValue + 1))
    }
}

extension ColorManager {
//    static func generateRedColors(desired numberOfColors: Int) -> [ColorViewModel] {
//        var randomRedValues = [CGFloat]()
//        for _ in 0 ..< numberOfColors {
//            randomRedValues.append(randomRGBValue)
//        }
//
//        var redColors = [ColorViewModel]()
//
//        for redValue in randomRedValues {
//            let color = UIColor(red: redValue / maxRGBFloatValue, green: 0.0, blue: 0.0, alpha: 1.0)
//            let colorName = String(format: "R: %.0f, G: %.0f, B: %.0f, A: %.0f", arguments: [redValue, 0, 0, 1])
//            let colorViewModel = ColorViewModel(name: colorName, color: color, isSelected: false)
//            redColors.append(colorViewModel)
//        }
//
//        return redColors
//    }
    
    static func generateColors(desired numberOfColors: Int, red: Bool, green: Bool, blue: Bool) -> [ColorViewModel] {
        var colors = [ColorViewModel]()
        
        for _ in 0 ..< numberOfColors {
            let redValue = red ? randomRGBValue: 0.0
            let greenValue = green ? randomRGBValue: 0.0
            let blueValue = blue ? randomRGBValue: 0.0
            let color = UIColor(red: redValue / maxRGBFloatValue, green: greenValue / maxRGBFloatValue, blue: blueValue / maxRGBFloatValue, alpha: 1.0)
            let colorName = String(format: "R: %.0f, G: %.0f, B: %.0f, A: %.0f", arguments: [redValue, greenValue, blueValue, 1.0])
            let colorViewModel = ColorViewModel(name: colorName, color: color, isSelected: false)
            colors.append(colorViewModel)
        }
        return colors
    }
}
