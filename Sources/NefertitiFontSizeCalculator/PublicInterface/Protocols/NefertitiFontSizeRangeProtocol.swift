//
//  FontSizeRangeProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation

public protocol NefertitiFontSizeRangeProtocol {
    var minFontSize: CGFloat { get }
    var maxFontSize: CGFloat { get }
    
    var diff: CGFloat { get }
}
