//
//  VariousWheelSpikeViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/8/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class VariousWheelSpikeViewController: UIViewController {
    
    @IBOutlet weak var wrapperView: UIView!
    
    @IBOutlet weak var wheelControl: SwiftFortuneWheel! {
        didSet {
            wheelControl.configuration = .variousWheelSpikeConfiguration
            wheelControl.slices = slices
            wheelControl.pinImage = "knobs"
        }
    }
    
    lazy var slices: [Slice] = {
        return Content.contents.map({ $0.slice })
    }()
    
    var finishIndex: Int {
        return Int.random(in: 0..<wheelControl.slices.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func rotateTap(_ sender: Any) {
        wheelControl.startAnimating(indefiniteRotationTimeInSeconds: 1, finishIndex: finishIndex) { (finished) in
            print(finished)
        }
    }
    
}

extension VariousWheelSpikeViewController {
    enum Content {
        case freeQuiz
        case quiz(count: String)
        case prize(count: String)
        
        var title: String {
            switch self {
            case .freeQuiz:
                return "Free"
            case .prize:
                return ""
            case .quiz(let count):
                return count
            }
        }
        
        var description: String {
            switch self {
            case .freeQuiz:
                return "Quiz"
            case .quiz:
                return "Quiz Entries"
            case .prize(let count):
                return count
            }
        }
        
        var imageName: String {
            switch self {
            case .prize:
                return "dollarIcon"
            default:
                return ""
            }
        }
        
        var slice: Slice {
            switch self {
            case .freeQuiz:
                let textPreferences = TextPreferences(textColorType: .customPatternColors(colors: nil, defaultColor: .white), font: .systemFont(ofSize: 16, weight: .bold), verticalOffset: 5)
                let linePreferences = LinePreferences.variousWheelSpikeLinePreferences(color: #colorLiteral(red: 0.2264060676, green: 0.7361533046, blue: 0.8579927087, alpha: 1), verticalOffset: 14)
                let content: [Slice.ContentType] = [.text(text: self.title, preferences: textPreferences), .text(text: self.description, preferences: textPreferences), .line(preferences: linePreferences)]
                return Slice(contents: content, backgroundColor: #colorLiteral(red: 1, green: 0.3388558924, blue: 0.3262704611, alpha: 1))
            case .prize:
                let imagePreferences = ImagePreferences(preferredSize: CGSize(width: 20, height: 20), verticalOffset: 5)
                let textPreferences = TextPreferences(textColorType: .customPatternColors(colors: nil, defaultColor: .white), font: .systemFont(ofSize: 16, weight: .bold), verticalOffset: 5)
                let linePreferences = LinePreferences.variousWheelSpikeLinePreferences(color: #colorLiteral(red: 0.5829362273, green: 0.3479926288, blue: 0.8946967721, alpha: 1), verticalOffset: 10)
                let content: [Slice.ContentType] = [.assetImage(name: self.imageName, preferences: imagePreferences), .text(text: self.description, preferences: textPreferences), .line(preferences: linePreferences)]
                return Slice(contents: content, backgroundColor: #colorLiteral(red: 0.9916418195, green: 0.6543524861, blue: 0.006547586992, alpha: 1))
            case .quiz:
                let titleTextPreferences = TextPreferences(textColorType: .customPatternColors(colors: nil, defaultColor: .white), font: .systemFont(ofSize: 16, weight: .bold), verticalOffset: 5)
                let descriptionTextPreferences = TextPreferences(textColorType: .customPatternColors(colors: nil, defaultColor: .white), font: .systemFont(ofSize: 13), verticalOffset: 5)
                let linePreferences = LinePreferences.variousWheelSpikeLinePreferences(color: #colorLiteral(red: 1, green: 0.1705371141, blue: 0.4936269522, alpha: 1), verticalOffset: 17)
                let content: [Slice.ContentType] = [.text(text: self.title, preferences: titleTextPreferences), .text(text: self.description, preferences: descriptionTextPreferences), .line(preferences: linePreferences)]
                return Slice(contents: content, backgroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1))
                
            }
        }
        
        static var contents: [Content] {
            return [.freeQuiz,
                    .prize(count: "\(75)"),
                    .freeQuiz,
                    .prize(count: "\(15)"),
                    .quiz(count: "\(40)"),
                    .prize(count: "\(100)")]
        }
    }
}
