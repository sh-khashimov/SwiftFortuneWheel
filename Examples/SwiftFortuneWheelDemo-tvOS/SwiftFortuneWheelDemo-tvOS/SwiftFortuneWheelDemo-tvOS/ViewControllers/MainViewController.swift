//
//  MainViewController.swift
//  SwiftFortuneWheelDemo-tvOS
//
//  Created by Sherzod Khashimov on 7/12/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var menus = Menu.menus

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "SwiftFortuneWheel"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menus.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let menu = menus[indexPath.row]
        cell.textLabel?.text = menu.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menu = menus[indexPath.row]
        switch menu {
        case .dynamic:
            break
        case .more:
            showAlert()
        default:
            break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showAlert() {
        let ac = UIAlertController(title: "More detailed examples are available in the SwiftFortuneWheelDemo-iOS project",
                                   message: nil, preferredStyle: .alert)

        let submitAction = UIAlertAction(title: "OK", style: .default) { [weak ac] action in
            ac?.dismiss(animated: true, completion: nil)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }

}

extension MainViewController {
    enum Menu {
        case dynamic
        case rotation
        case withoutStoryboard
        case more
        
        var name: String {
            switch self {
            case .dynamic:
                return "Dynamic Content Example"
            case .rotation:
                return "Rotation and Animated Rotation API Example"
            case .withoutStoryboard:
                return "Without Storyboard Example"
            case .more:
                return "More Examples"
            }
        }
        
        static var menus: [Menu] {
            return [.dynamic, .more]
        }
    }
}
