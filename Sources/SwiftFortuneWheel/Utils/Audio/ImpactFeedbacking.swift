//
//  ImpactFeedbacking.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 11/2/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

protocol ImpactFeedbackable {
    @available(iOSApplicationExtension 10.0, *)
    var impactFeedbackgenerator: UIImpactFeedbackGenerator { get }
    var impactFeedbackOn: Bool { get set }
}

extension ImpactFeedbackable {
    func prepareImpactFeedbackIsNeeded() {
        if #available(iOSApplicationExtension 10.0, *) {
            guard impactFeedbackOn == true else { return }
            impactFeedbackgenerator.prepare()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func impactFeedback() {
        if #available(iOSApplicationExtension 10.0, *) {
            if impactFeedbackOn {
                impactFeedbackgenerator.impactOccurred()
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
