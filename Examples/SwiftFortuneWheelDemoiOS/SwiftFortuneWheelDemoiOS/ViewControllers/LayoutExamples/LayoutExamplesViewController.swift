//
//  LayoutExamplesViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/6/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit

class LayoutExamplesViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, LayoutType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, LayoutType>
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = compositionalLayout
            collectionView.delegate = self
        }
    }
    
    var layouts: [LayoutType] = LayoutType.allLayouts
    
    lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let spacing: CGFloat = 15
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var dataSource: DataSource = {
        let dataSource = DataSource(
            collectionView: self.collectionView,
            cellProvider: { (collectionView, indexPath, layout) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "\(LayoutCollectionViewCell.self)",
                    for: indexPath) as? LayoutCollectionViewCell
                cell?.configure(text: layout.name, imageName: layout.imageName, backgroundColor: layout.backgroundColor, textColor: layout.textColor)
                return cell
        })
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Various Layout Examples"
        // Do any additional setup after loading the view.
        applySnapshot(animatingDifferences: false)
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(LayoutType.allLayouts)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}

extension LayoutExamplesViewController {
    func showVC(with layout: LayoutType) {
        
        let storyboard = UIStoryboard.init(name: "Various", bundle: nil)
        var viewController: UIViewController?
        
        switch layout {
        case .simple:
            viewController = storyboard.instantiateViewController(withIdentifier: "\(VariousWheelSimpleViewController.self)") as? VariousWheelSimpleViewController
        case .jackpot:
            viewController = storyboard.instantiateViewController(withIdentifier: "\(VariousWheelJackpotViewController.self)") as? VariousWheelJackpotViewController
        case .podium:
            viewController = storyboard.instantiateViewController(withIdentifier: "\(VariousWheelPodiumViewController.self)") as? VariousWheelPodiumViewController
        case .spike:
            viewController = storyboard.instantiateViewController(withIdentifier: "\(VariousWheelSpikeViewController.self)") as? VariousWheelSpikeViewController
        }
        
        guard let _viewController = viewController else { return }
        self.navigationController?.pushViewController(_viewController, animated: true)
        viewController?.title = layout.name
    }
}

extension LayoutExamplesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let layout = dataSource.itemIdentifier(for: indexPath) else { return }
        showVC(with: layout)
    }
}

extension LayoutExamplesViewController {
    enum Section {
        case main
    }
    
    enum LayoutType {
        case simple
        case jackpot
        case podium
        case spike
        
        var name: String {
            switch self {
            case .simple:
                return "Simple Wheel Layout Example"
            case .jackpot:
                return "Jackpot Wheel Layout Example"
            case .podium:
                return "Podium Wheel Layout Example"
            case .spike:
                return "Spike Wheel Layout Example"
            }
        }
        
        var imageName: String {
            switch self {
            case .simple:
                return "variousWheelSimple"
            case .jackpot:
                return "variousWheelJackpot"
            case .podium:
                return "variousWheelPodium"
            case .spike:
                return "variousWheelSpike"
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .simple:
                return .white
            default:
                return .black
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .simple:
                return #colorLiteral(red: 0.1803680062, green: 0.1804060638, blue: 0.1803655922, alpha: 1)
            case .jackpot:
                return #colorLiteral(red: 0.4974666834, green: 0.6801372766, blue: 0.1976171136, alpha: 1)
            case .podium:
                return #colorLiteral(red: 0.9994453788, green: 0.8957717419, blue: 0.3653104603, alpha: 1)
            case .spike:
                return #colorLiteral(red: 0.9136260152, green: 0.9137827158, blue: 0.9136161208, alpha: 1)
            }
        }
        
        static var allLayouts: [LayoutType] {
            return [.simple, .jackpot, .podium, .spike]
        }
    }
    
}
