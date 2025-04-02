//
//  ViewModel.swift
//  RickAndMortyTest
//
//  Created by Roman Shestopal on 02.04.2025.
//

import Foundation
import UIKit

class ViewModel {
    private var characters: [Character] = []
    
    var numberRowsInSection: Int {
        characters.count
    }
    
    func getTextCell(row: Int) -> String {
        return characters[row].name
    }
    
    func getDataImage(row: Int) -> Data? {
        return characters[row].dataImage
    }
    
    func loadCharacters(completion: @escaping () -> ()) {
        NetworkService.shared.checkConnection()
        if NetworkService.shared.isConnected {
            NetworkService.shared.fetchCharacters { fetchedCharacters in
                if let fetchedCharacters = fetchedCharacters {
                    CoreDataManager.shared.deleteAllData()
                    self.characters = fetchedCharacters.map({ character in
                        let newCahacter = Character(id: character.id, name: character.name, image: character.image, dataImage: try? Data(contentsOf: URL(string: character.image)!))
                        CoreDataManager.shared.save(character: newCahacter)
                        return newCahacter
                    })
                    completion()
                }
            }
        } else {
            self.characters = CoreDataManager.shared.getCharacters()
        }
    }
}

