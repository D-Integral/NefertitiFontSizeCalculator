//
//  FontSizeRange.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation

public struct NefertitiFontSizeRange: NefertitiFontSizeRangeProtocol {
    
    // MARK: - Public Interface
    
    public private(set) var minFontSize: CGFloat
    public private(set) var maxFontSize: CGFloat
    
    public var diff: CGFloat {
        return maxFontSize - minFontSize
    }
    
    public init(minFontSize: CGFloat? = nil,
         maxFontSize: CGFloat? = nil,
         minFontScale: CGFloat = Constants.defaultMinFontScale) {
        if let maxFontSize = maxFontSize {
            self.maxFontSize = maxFontSize.isNaN ? Constants.defaultMaxFontSize : maxFontSize
        } else {
            self.maxFontSize = Constants.defaultMaxFontSize
        }
        
        let reliableMinFontScale = minFontScale.isNaN ? Constants.defaultMinFontScale : minFontScale
        let defaultMinFontSize = self.maxFontSize * reliableMinFontScale
        
        if let minFontSize = minFontSize {
            self.minFontSize = minFontSize.isNaN ? defaultMinFontSize : minFontSize
        } else {
            self.minFontSize = defaultMinFontSize
        }
    }
    
    public struct Constants {
        public static let defaultMaxFontSize = 100.0
        public static let defaultMinFontScale = 0.1
        public static let minFontSizeNotProvided = -1.0
    }
}
