//
//  FontSizeCalculatorSourceProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation

public protocol NefertitiFontSizeCalculatorSourceProtocol {
    var text: String { get }
    var fontSizeRange: NefertitiFontSizeRange { get }
    var rectSize: CGSize { get }
    
    var currentFontSize: CGFloat { get }
    var constraintSize: CGSize { get }
    var fontSizeRangeDiff: CGFloat { get }
}
