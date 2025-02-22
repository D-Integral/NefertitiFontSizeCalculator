//
//  FontSizeCalculator.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation
import UIKit

public class NefertitiFontSizeCalculator: NefertitiFontSizeCalculatorProtocol {
    
    // MARK: Public Interface
    
    public init() {
        
    }
    
    public func fontSizeThatFits(_ source: NefertitiFontSizeCalculatorSourceProtocol) -> CGFloat {
        if source.text.isEmpty {
            return defaultFont.pointSize
        }
        
        return roundedFontSize(for: source)
    }
    
    // MARK: - Private Properties
    
    private var defaultFont: UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
    
    // MARK: - Private Functions
    
    private func roundedFontSize(for source: NefertitiFontSizeCalculatorSourceProtocol) -> CGFloat {
        let calculatedFontSize = fontSize(for: source)
        
        return (calculatedFontSize * 10.0).rounded(.down) / 10.0
    }
    
    private func fontSize(for source: NefertitiFontSizeCalculatorSourceProtocol) -> CGFloat {
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        attributes[NSAttributedString.Key.font] = defaultFont.withSize(source.currentFontSize)
        
        let currentFontSizeBoundingRect = source.text.boundingRect(with: source.constraintSize,
                                                           options: .usesLineFragmentOrigin,
                                                           attributes: attributes,
                                                           context: nil)
        let fitState = doesLine(currentFontSizeBoundingRect.size.width,
                                fit: source.rectSize.width)
        
        if .fit == fitState {
            return source.currentFontSize
        }
        
        if source.fontSizeRangeDiff <= 0.1 {
            switch fitState {
            case .wantedIsGreater:
                return source.fontSizeRange.maxFontSize
            default:
                return source.fontSizeRange.minFontSize
            }
        }
        
        let newMinFontSize = (.wantedIsLess == fitState) ? source.fontSizeRange.minFontSize : source.currentFontSize
        let newMaxFontSize = (.wantedIsLess == fitState) ? source.currentFontSize : source.fontSizeRange.maxFontSize
        let newFontSizeRange = NefertitiFontSizeRange(minFontSize: newMinFontSize,
                                                      maxFontSize: newMaxFontSize)
        let newSource = NefertitiFontSizeCalculatorSource(text: source.text,
                                                          fontSizeRange: newFontSizeRange,
                                                          rectSize: source.rectSize)
        
        return fontSize(for: newSource)
    }
    
    private func doesLine(_ line: Double,
                          fit lineToFit: Double) -> BinarySearchFitState {
        if (line >= lineToFit)
            && (line <= lineToFit + 10.0) {
            return .fit
        }
        
        return (line > lineToFit) ? .wantedIsLess : .wantedIsGreater
    }
}
