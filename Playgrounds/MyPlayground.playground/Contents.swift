//: A UIKit based Playground for presenting user interface

// This playground used for development and testing purpose only
  
import UIKit
import PlaygroundSupport
import SwiftFortuneWheel

class MyViewController : UIViewController {

    var fortuneWheel: SwiftFortuneWheel!

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        var slices: [Slice] = []

        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment

        for index in 1...4 {
            let headerContent = Slice.ContentType.text(text: "\(index)", preferences: .amountTextPreferences)
            let descriptionContent = Slice.ContentType.text(text: "1qwewew 2qwewe 3qwewewew", preferences: .descriptionTextPreferences)
            let slice = Slice(contents: [descriptionContent])
            slices.append(slice)
        }

//        let headerContent = Slice.ContentType.text(text: "\(index)", preferences: .amountTextPreferences)
//        let descriptionContent = Slice.ContentType.text(text: "1qwewew 2qwewe 3qwewewew", preferences: .descriptionTextPreferences)
//        let slice = Slice(contents: [headerContent,
//                                     descriptionContent, headerContent])
//        slices.append(slice)

        let frame = CGRect(x: 35, y: 100, width: 300, height: 300)

        fortuneWheel = SwiftFortuneWheel(frame: frame, slices: slices, configuration: .defaultConfiguration)

        fortuneWheel.isPinHidden = true
        fortuneWheel.isSpinHidden = true
        
        view.addSubview(fortuneWheel)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
