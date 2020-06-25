//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import SwiftFortuneWheel

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        var slices: [Slice] = []

        for index in 1...4 {
            let headerContent = Slice.ContentType.text(text: "\(index)", preferenes: .amountTextPreferences)
            let descriptionContent = Slice.ContentType.text(text: "DESCRIPTION", preferenes: .descriptionTextPreferences)
            let slice = Slice(contents: [headerContent, descriptionContent])
            slices.append(slice)
        }

        let frame = CGRect(x: 35, y: 100, width: 300, height: 300)

        let fortuneWheel = SwiftFortuneWheel(frame: frame, slices: slices, configuration: .defaultConfiguration)

        fortuneWheel.isPinHidden = true
        fortuneWheel.isSpinHidden = true
        
        view.addSubview(fortuneWheel)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
