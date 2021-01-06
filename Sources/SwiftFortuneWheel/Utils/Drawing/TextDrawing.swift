//
//  TextDrawing.swift
//  SwiftFortuneWheel-iOS
//
//  Created by Sherzod Khashimov on 7/3/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Curved text drawing protocol
protocol TextDrawing: CurveTextDrawing {}

extension TextDrawing {
    /// Available text rectangles for the specified position
    /// - Parameters:
    ///   - yPosition: Y Position
    ///   - preferences: Text preferences
    ///   - topOffset: Top offset
    ///   - radius: radius
    ///   - sliceDegree: slice degree
    ///   - margins: content margins
    /// - Returns: Available text rectangles
    private func availableTextRect(yPosition: CGFloat, preferences: TextPreferences, topOffset: CGFloat, radius: CGFloat, sliceDegree: CGFloat, margins: SFWConfiguration.Margins) -> [CGRect] {
        
        /// Max. available height from Y position
        let maxHeight = abs(yPosition) - margins.bottom
        
        /// Max. available lines for String
        let maxLines = preferences.numberOfLines == 0 ? Int((maxHeight / (preferences.font.pointSize + preferences.spacing)).rounded(.up)) : preferences.numberOfLines
        
        /// Text rectangles
        var textRects: [CGRect] = []
        
        /// Creates rectangle for each line
        for line in 1...maxLines {
            /// Height offset
            let heightOffset = preferences.font.pointSize * CGFloat(line)
            /// Spacing
            let spacing = line == 1 ? 0 : preferences.spacing * CGFloat(line)
            /// Y position of the rectangle bottoms
            let bottomYPosition = -(radius - preferences.verticalOffset - topOffset - heightOffset - spacing)
            /// Width
            let width = min(preferences.maxWidth, self.width(forYPosition: bottomYPosition,
                                   sliceDegree: sliceDegree,
                                   leftMargin: margins.left,
                                   rightMargin: margins.right))
            /// Text rectangle
            let textRect = CGRect(x: 0, y: 0, width: width, height: preferences.font.pointSize)
            textRects.append(textRect)
        }
        return textRects
    }
    
    
    /// Width for Y postion
    /// - Parameter yPosition: Y position
    /// - Returns: new width
    private func width(forYPosition yPosition: CGFloat, sliceDegree: CGFloat, leftMargin: CGFloat, rightMargin: CGFloat) -> CGFloat {
        let width = .circularSegmentHeight(radius: -yPosition, from: sliceDegree) - leftMargin - rightMargin
        return width
    }
}

extension TextDrawing {
    /// Draws curved text
    /// - Parameters:
    ///   - text: text
    ///   - context: context where to draw
    ///   - preferences: text preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    ///   - radius: radius
    ///   - sliceDegree: slice degree
    ///   - contextPositionCorrectionOffsetDegree: Context position correction offset degree
    ///   - margins: content margins
    /// - Returns: Height of the drawn text
    func drawCurved(text: String, in context:CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat, radius: CGFloat, sliceDegree: CGFloat, contextPositionCorrectionOffsetDegree: CGFloat, margins: SFWConfiguration.Margins) -> CGFloat {
        
        let textColor = preferences.color(for: index)
        
        /// Y start position
        let yPosition = -(radius - preferences.verticalOffset - topOffset - margins.top) + preferences.font.pointSize / 2
        
        /// Text rectangles for multiline text
        let textRects = availableTextRect(yPosition: yPosition,
                                          preferences: preferences,
                                          topOffset: topOffset,
                                          radius: radius,
                                          sliceDegree: sliceDegree,
                                          margins: margins)
        
        /// String with multiline
        let multilineString = text.split(font: preferences.font, lineWidths: textRects.map({ $0.width }), lineBreak: preferences.lineBreakMode)
        
        
        /// Height for al text lines
        let height = preferences.font.pointSize * CGFloat(multilineString.count) + preferences.spacing * max(0, CGFloat(multilineString.count - 1))
        
        for index in 0..<multilineString.count {
            
            /// The string that will be drawn
            let string = multilineString[index]
            /// Space between lines
            let spacing = index == 0 ? 0 : preferences.spacing * CGFloat(index)
            
            /// Current text rectangle
            let textRect = textRects[index]
            
            /// Y position of the current line
            let yPos = yPosition + textRect.height * CGFloat(index) + spacing
            context.saveGState()
            
            let angleRotation = -(rotation + contextPositionCorrectionOffsetDegree) * CGFloat.pi/180
            
            self.centreArcPerpendicular(text: string,
                                        context: context,
                                        radius: -yPos,
                                        angle: angleRotation,
                                        colour: textColor,
                                        font: preferences.font,
                                        clockwise: preferences.flipUpsideDown,
                                        preferedSize: textRect.size)
            
            context.restoreGState()
        }
        
        return height + preferences.verticalOffset
        
    }
    
    /// Draws text
    /// - Parameters:
    ///   - text: text
    ///   - context: context where to draw
    ///   - preferences: text preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    ///   - radius: radius
    ///   - sliceDegree: slice degree
    ///   - margins: content margins
    /// - Returns: Height of the drawn text
    func drawHorizontal(text: String, in context:CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat, radius: CGFloat, sliceDegree: CGFloat, margins: SFWConfiguration.Margins) -> CGFloat {
        
        /// Text attributes
        let textFontAttributes = preferences.textAttributes(for: index)
        
        /// Y start position
        let yPosition = -(radius - preferences.verticalOffset - topOffset - margins.top)
        
        /// Text rectangles for multiline text
        var textRects = availableTextRect(yPosition: yPosition,
                                          preferences: preferences,
                                          topOffset: topOffset,
                                          radius: radius,
                                          sliceDegree: sliceDegree,
                                          margins: margins)
        
        /// If text not flipped, reverse text rectangle to start crop from the bottom
        if !preferences.flipUpsideDown {
            textRects.reverse()
        }
        
        /// String with multiline
        var multilineString = text.split(font: preferences.font, lineWidths: textRects.map({ $0.width }), lineBreak: preferences.lineBreakMode)
        
        /// Height for al textl lines
        let height = preferences.font.pointSize * CGFloat(multilineString.count) + preferences.spacing * max(0, CGFloat(multilineString.count - 1))
        
        /// If text not flipped, reverse text and text rectangle
        if !preferences.flipUpsideDown {
            multilineString.reverse()
            textRects.reverse()
        }
        
        /// Start draw each string line
        for index in 0..<multilineString.count {
            
            /// The string that will be drawn
            let string = multilineString[index]
            /// Space between lines
            let spacing = index == 0 ? 0 : preferences.spacing * CGFloat(index)
            
            /// Current text rectangle
            let textRect = textRects[index]
            /// X position of the current line
            let xPos = -(textRect.width / 2) - preferences.horizontalOffset
            /// Y position of the current line
            let yPos = yPosition + textRect.height * CGFloat(index) + spacing
            
            context.saveGState()
            context.rotate(by: rotation * CGFloat.pi/180)
            
            context.translateBy(x: xPos, y: yPos)
            
            if !preferences.flipUpsideDown {
                context.rotate(by: .flipRotation)
                context.translateBy(x: -textRect.width, y: -textRect.height)
            }
            
            string.draw(in: CGRect(x: 0, y: 0, width: textRect.width, height: CGFloat.infinity), withAttributes: textFontAttributes)
            
            context.restoreGState()
        }
        
        return height + preferences.verticalOffset
        
    }
    
    /// Draws text
    /// - Parameters:
    ///   - text: text
    ///   - context: context where to draw
    ///   - preferences: text preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    ///   - radius: radius
    ///   - sliceDegree: slice degree
    ///   - margins: content margins
    /// - Returns: Height of the drawn text
    func drawVertical(text: String, in context: CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat, radius: CGFloat, sliceDegree: CGFloat, margins: SFWConfiguration.Margins) -> CGFloat {
        
        /// Text attributes
        let textAttributes = preferences.textAttributes(for: index)
        
        /// Available words
        let wordsCount = text.split(separator: " ".first!).count
        
        /// Maximum available width in slice
        let maxWidth: CGFloat = .circularSegmentHeight(radius: radius - preferences.verticalOffset - topOffset, from: sliceDegree)
        
        /// Maximum available lines in slice
        let maxLinesInSlice = (maxWidth / (preferences.font.pointSize + preferences.spacing)).rounded(.up)
        
        /// Available text rectangles
        var availableTextRects: [CGRect] = []
        
        /// Counts max available vertical lines and create for each line a max text rectangle
        for line in 1..<Int(maxLinesInSlice) {
            /// Spacing between lines
            let spacing = line > 1 ? preferences.spacing : 0
            
            /// Height of text rectangle
            let _height = preferences.font.pointSize * CGFloat(line) + preferences.spacing * (CGFloat(line) - 1)
            /// Maximum circular segment height (chord) for current line (rectangle)
            let _maxCircularSegmentHeight = _height - margins.top - margins.bottom
            /// Bottom radius offset
            let _bottomRadiusOffset = max(margins.bottom, .radius(circularSegmentHeight: _maxCircularSegmentHeight, from: sliceDegree))
            /// Available width in slice
            let _availableWidthInSlice = radius - preferences.verticalOffset - topOffset - _bottomRadiusOffset
            /// Current line space
            let _currentLineSpace = (_availableWidthInSlice * _height)
            
            /// Height of the next text rectangle
            let _nextHeight = preferences.font.pointSize * CGFloat(line + 1) + preferences.spacing * (CGFloat(line))
            /// Maximum circular segment height (chord) for current line (rectangle)
            let _nextMaxCircularSegmentHeight = _nextHeight + spacing - margins.top - margins.bottom
            /// Bottom radius offset for next line
            let _nextBottomRadiusOffset = max(margins.bottom, .radius(circularSegmentHeight: _nextMaxCircularSegmentHeight, from: sliceDegree))
            /// Available width in slice for next line
            let _nextAvailableWidthInSlice = radius - preferences.verticalOffset - topOffset - _nextBottomRadiusOffset
            /// Next line space
            let _nextLineSpace = (_nextAvailableWidthInSlice * _nextHeight)
            
            availableTextRects.append(CGRect(x: 0, y: 0, width: _availableWidthInSlice, height: _height))
            
            if _currentLineSpace > _nextLineSpace {
                break
            }
        }
        
        /// String with multiline
        var multilineString: [String] = []
        
        /// Text rectangles for multiline text
        var textRects: [CGRect] = []
        
        /// creates text rectangles from available max text rectangle
        for index in 0..<availableTextRects.count {
            textRects = []
            multilineString = []
            
            /// Text rectangle
            let textRect = availableTextRects[index]
            /// Current line
            let line = index + 1
            
            /// split the availableTextRect to the text rectangles
            textRects = Array(repeating: CGRect(x: 0, y: 0, width: textRect.width, height: preferences.font.pointSize), count: line)
            multilineString = text.split(font: preferences.font, lineWidths: textRects.map({ min(preferences.maxWidth, $0.width) }), lineBreak: preferences.lineBreakMode)
            
            /// Word count for text in the current line
            let _wordCount = max(multilineString.joined().split(separator: " ".first!).count, line)
            
            if wordsCount == _wordCount {
//                break
            }
        }
        
        
        /// Line count
        let lineCount = multilineString.count
        
        /// Spacing between lines
        let spacing = lineCount > 1 ? preferences.spacing : 0
        
        /// Context widths
        let contextWidth = preferences.font.pointSize * CGFloat(lineCount) + spacing * max(0, (CGFloat(lineCount) - 1))
        
        /// Context height
        let contextHeight = textRects.first?.width ?? 0
        
        /// Y start position
        let yPosition = -(radius - preferences.verticalOffset - topOffset - margins.top)
        
        /// If text not flipped, reverse text
        if !preferences.flipUpsideDown {
            multilineString.reverse()
        }
        
        /// Start draw each string line
        for index in 0..<multilineString.count {
            
            /// The string that will be drawn
            let string = multilineString[index]
            /// Space between lines
            let spacing = index == 0 ? 0 : preferences.spacing * CGFloat(index)
            
            /// Current text rectangle
            let textRect = textRects[index]
            /// X position of the current line
            let xPos = textRect.height * CGFloat(index + 1) + spacing - contextWidth / 2 - preferences.horizontalOffset
            
            context.saveGState()
            context.rotate(by: rotation * CGFloat.pi/180)
            
            context.translateBy(x: xPos, y: yPosition)
            context.rotate(by: 90 * CGFloat.pi/180)
            
            if preferences.flipUpsideDown {
                context.rotate(by: .flipRotation)
                context.translateBy(x: -textRect.width, y: -textRect.height)
            }
            
            //         For Debugging purposes
//                        context.addRect(textRect)
//                        UIColor.red.setStroke()
//                        context.drawPath(using: .fillStroke)
            
            string.draw(in: CGRect(x: 0, y: 0, width: textRect.width, height: CGFloat.infinity), withAttributes: textAttributes)
            
            context.restoreGState()
        }
        
        return contextHeight + preferences.verticalOffset
        
    }
}
