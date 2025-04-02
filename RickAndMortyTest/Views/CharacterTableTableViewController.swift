//
//  CharacterTableViewController.swift
//  RickAndMortyTest
//
//  Created by Roman Shestopal on 01.04.2025.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadCharacters { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
        
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getTextCell(row: indexPath.row)
        if let dataImage = viewModel.getDataImage(row: indexPath.row) {
            cell.imageView?.image = UIImage(data: dataImage)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailCharacterView(textName: viewModel.getTextCell(row: indexPath.row), dataImage: viewModel.getDataImage(row: indexPath.row))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CharacterTableViewController: ViewModelProtocol {
    func setupViewModel(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
