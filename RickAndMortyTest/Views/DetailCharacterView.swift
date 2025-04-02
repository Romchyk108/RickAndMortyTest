//
//  DetailCharacterView.swift
//  RickAndMortyTest
//
//  Created by Roman Shestopal on 02.04.2025.
//

import Foundation
import UIKit

class DetailCharacterView: UIViewController {
    
    let textName: String?
    let dataImage: Data?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let labelName: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let dataImage {
            imageView.image = UIImage(data: dataImage)
        }
        labelName.text = textName
        view.addSubview(imageView)
        view.addSubview(labelName)
        setupScrollView()
    }
    
    init(textName: String, dataImage: Data?) {
        self.textName = textName
        self.dataImage = dataImage
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(labelName)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            labelName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            labelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labelName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
