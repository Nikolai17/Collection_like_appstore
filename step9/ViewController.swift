//
//  ViewController.swift
//  step8
//
//  Created by Nikolay Volnikov on 22.05.2023.
//

import UIKit

// MARK: - CellModel

struct CellModel {

    let color: UIColor
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

class ViewController: UIViewController {

    // MARK: - Private properties

    private var dataSource: [CellModel] = [CellModel(color: .random), CellModel(color: .random), CellModel(color: .random), CellModel(color: .random), CellModel(color: .random), CellModel(color: .random), CellModel(color: .random), CellModel(color: .random), CellModel(color: .random) ]

    private enum Constants {
        static let cellWidth: CGFloat = 300
        static let cellHeight: CGFloat = 500
        static let cellSpacing: CGFloat = 10
        static let cellIdentifier: String = "cell"
    }

    private let collectionViewFlowLayout = UICollectionViewFlowLayout()

    private lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal

        collectionViewFlowLayout.minimumLineSpacing = Constants.cellSpacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        return collectionView
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: view.layoutMargins.left, bottom: 0, right: 0)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let cellWidthWithSpacing = Constants.cellWidth + Constants.cellSpacing
        let offset = targetContentOffset.pointee.x
        let index = round(offset / cellWidthWithSpacing)
        let newOffset = index * cellWidthWithSpacing

        targetContentOffset.pointee.x = newOffset + 10
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 10

        let currentData: CellModel = dataSource[indexPath.row]
        cell.backgroundColor = currentData.color
        return cell
    }
}
