//
//  MainViewController.swift
//  RickAndMortyTest
//
//  Created by Roman Shestopal on 02.04.2025.
//

import UIKit

protocol ViewModelProtocol {
    func setupViewModel(_ viewModel: ViewModel)
}

class MainViewController: UIViewController {
    private let viewModel = ViewModel()
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
        
    private let listVC = CharacterTableViewController()
    private let gridVC = GridViewController(collectionViewLayout: UICollectionViewFlowLayout())
    private var currentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listVC.setupViewModel(viewModel)
        gridVC.setupViewModel(viewModel)
        setupToggle()
        switchToViewController(listVC)
        NetworkService.shared.checkConnection()
    }
    
    private func switchToViewController(_ newVC: UIViewController) {
        currentVC?.willMove(toParent: nil)
        currentVC?.view.removeFromSuperview()
        currentVC?.removeFromParent()
            
        addChild(newVC)
        newVC.view.frame = view.bounds
        view.addSubview(newVC.view)
        newVC.didMove(toParent: self)
        view.bringSubviewToFront(toggleSwitch)
        currentVC = newVC
    }
    
    private func setupToggle() {
        view.addSubview(toggleSwitch)
        toggleSwitch.addTarget(self, action: #selector(toggleSwitched(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            toggleSwitch.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            toggleSwitch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        ])
    }
        
    @objc private func toggleSwitched(_ sender: UISwitch) {
        if sender.isOn {
            switchToViewController(gridVC)
        } else {
            switchToViewController(listVC)
        }
    }
}
