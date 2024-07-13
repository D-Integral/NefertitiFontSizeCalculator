//
//  FontSizeCalculatorProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation

public protocol NefertitiFontSizeCalculatorProtocol {
    func fontSizeThatFits(_ source: NefertitiFontSizeCalculatorSourceProtocol) -> CGFloat
}
