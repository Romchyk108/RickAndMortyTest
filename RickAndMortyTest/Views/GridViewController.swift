//
//  GridViewController.swift
//  RickAndMortyTest
//
//  Created by Roman Shestopal on 02.04.2025.
//

import Foundation
import UIKit

class GridViewController: UICollectionViewController {
    private var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "cell")
        setupLayout()
        viewModel.loadCharacters { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
        
    private func setupLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 180, height: 200)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberRowsInSection
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCell
        cell.configure(with: viewModel.getTextCell(row: indexPath.row), dataImage: viewModel.getDataImage(row: indexPath.row))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailCharacterView(textName: viewModel.getTextCell(row: indexPath.row), dataImage: viewModel.getDataImage(row: indexPath.row))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension GridViewController: ViewModelProtocol {
    func setupViewModel(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
