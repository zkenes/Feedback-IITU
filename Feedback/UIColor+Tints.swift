//
//  UIColor+Tints.swift
//  MedicineQuizApp
//
//  Created by Zhanserik on 11/10/15.
//  Copyright © 2015 Nurdaulet Bolatov. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    #if os(iOS)
    public typealias OSColor = UIColor
    #elseif os(OSX)
    public typealias OSColor = NSColor
    #endif
    
    /**
     Generates an NS- or UIColor from a hex color string.
     - parameter hex: The hex color string from which to create the color object.  '#' sign is optional.
     */
    public static func colorFromHexCode(hex:String) -> OSColor!
    {
        var colorString: String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if colorString.hasPrefix("#") {
            colorString = colorString.fui_substringFromIndex(1)
        }
        
        let stringLength = colorString.characters.count
        if stringLength != 6 && stringLength != 8 {
            return nil
        }
        
        let rString = colorString.fui_substringToIndex(2)
        let gString = colorString.fui_substringFromIndex(2).fui_substringToIndex(2)
        let bString = colorString.fui_substringFromIndex(4).fui_substringToIndex(2)
        var aString : String?
        if stringLength == 8 { aString = colorString.fui_substringFromIndex(6).fui_substringToIndex(2) }
        
        var r: CUnsignedInt = 0
        var g: CUnsignedInt = 0
        var b: CUnsignedInt = 0
        var a: CUnsignedInt = 1
        
        NSScanner(string:rString).scanHexInt(&r)
        NSScanner(string:gString).scanHexInt(&g)
        NSScanner(string:bString).scanHexInt(&b)
        if let aString = aString {
            NSScanner(string:aString).scanHexInt(&a)
        }
        
        let red     = CGFloat(r) / 255.0
        let green   = CGFloat(g) / 255.0
        let blue    = CGFloat(b) / 255.0
        let alpha   = CGFloat(a) / 255.0
        return OSColor(red:red, green:green, blue:blue, alpha:alpha)
    }
    //
    private static func alphaHEX(alpha: CGFloat) -> String {
    
        if alpha <= 1 {
            return String(Int(alpha * 255), radix: 16, uppercase: true)
        } else { return "FF" }
    }
    
    public static func turquoiseColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.turquoise + alphaHEX(alpha))
    }
    public static func greenSeaColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.greenSea + alphaHEX(alpha))
    }
    public static func emeraldColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.emerald + alphaHEX(alpha))
    }
    public static func nephritisColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.nephritis + alphaHEX(alpha))
    }
    public static func peterRiverColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.peterRiver + alphaHEX(alpha))
    }
    public static func belizeHoleColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.belizeHole + alphaHEX(alpha))
    }
    public static func amethystColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.amethyst + alphaHEX(alpha))
    }
    public static func wisteriaColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.wisteria + alphaHEX(alpha))
    }
    public static func wetAsphaltColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.wetAsphalt + alphaHEX(alpha))
    }
    public static func midnightBlueColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.midnightBlue + alphaHEX(alpha))
    }
    public static func sunflowerColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.sunflower + alphaHEX(alpha))
    }
    public static func tangerineColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.tangerine + alphaHEX(alpha))
    }
    public static func carrotColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.carrot + alphaHEX(alpha))
    }
    public static func pumpkinColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.pumpkin + alphaHEX(alpha))
    }
    public static func alizarinColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.alizarin + alphaHEX(alpha))
    }
    public static func pomegranateColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.pomegranate + alphaHEX(alpha))
    }
    public static func cloudsColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.clouds + alphaHEX(alpha))
    }
    public static func silverColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.silver + alphaHEX(alpha))
    }
    public static func concreteColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.concrete + alphaHEX(alpha))
    }
    public static func asbestosColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.asbestos + alphaHEX(alpha))
    }
    public static func appGreenColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.saualMedGreen + alphaHEX(alpha))
    }
    public static func masalaColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.masala + alphaHEX(alpha))
    }
    public static func mineShaftColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.mineShaft + alphaHEX(alpha))
    }
    public static func salemColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.salem + alphaHEX(alpha))
    }
    public static func merlotColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.merlot + alphaHEX(alpha))
    }
    public static func seaBuckthornColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.seaBuckthorn + alphaHEX(alpha))
    }
    public static func ceruleanColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.cerulean + alphaHEX(alpha))
    }
    public static func jasperColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.jasper + alphaHEX(alpha))
    }
    public static func gravelColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.gravel + alphaHEX(alpha))
    }
    public static func athensGrayColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.athensGray + alphaHEX(alpha))
    }
    public static func tapaColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.tapa + alphaHEX(alpha))
    }
    public static func puertoRicoColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.puertoRico + alphaHEX(alpha))
    }
    public static func spectraColor(alpha: CGFloat = 1.0) -> OSColor! {
        return self.colorFromHexCode(ColorCodes.spectra + alphaHEX(alpha))
    }
    
    public struct ColorCodes
    {
        public static let turquoise = "1abc9c"
        public static let greenSea  = "16a085"
        public static let emerald  = "2ecc71"
        public static let nephritis = "27ae60"
        public static let peterRiver = "3498D8"
        public static let belizeHole = "2980b9"
        public static let amethyst = "9b59b6"
        public static let wisteria = "8e44ad"
        public static let wetAsphalt = "34495e"
        public static let midnightBlue = "2C3E50"
        public static let sunflower = "F1C40F"
        public static let tangerine = "F39C12"
        public static let carrot = "E67E22"
        public static let pumpkin = "D35400"
        public static let alizarin = "E74C3C"
        public static let pomegranate = "C0392B"
        public static let clouds = "F5F6F7"
        public static let silver = "BDC3C7"
        public static let concrete = "95A5A6"
        public static let asbestos = "7F8C8D"
        public static let saualMedGreen = "15C077"
        public static let masala = "3C3C3C"
        public static let mineShaft = "313131"
        public static let salem = "007E42"
        public static let merlot = "861F23"
        public static let seaBuckthorn = "F5A623"
        public static let cerulean = "01A6D2"
        public static let jasper = "CE3D42"
        public static let gravel = "4A4A4A"
        public static let athensGray = "EFEFF4"
        public static let tapa = "737373"
        public static let puertoRico = "42C5AA"
        public static let spectra = "25685A"
    
    }
}


private extension String
{
    func fui_substringFromIndex(index: Int) -> String
    {
        let newStart = startIndex.advancedBy(index)
        return self[newStart ..< endIndex]
    }
    
    
    
    func fui_substringToIndex(index: Int) -> String
    {
        let newEnd = startIndex.advancedBy(index)
        return self[startIndex ..< newEnd]
    }
}