//
//  CharacterGridCell.swift
//  RickAndMortyTest
//
//  Created by Roman Shestopal on 02.04.2025.
//

import Foundation
import UIKit

class CharacterCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with text: String, dataImage: Data?) {
        label.text = text
        loadImage(from: dataImage)
    }
    
    private func loadImage(from dataImage: Data?) {
        guard let dataImage, let image = UIImage(data: dataImage) else { return }
        self.imageView.image = image
    }
}
