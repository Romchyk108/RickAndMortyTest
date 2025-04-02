//
//  Character.swift
//  RickAndMortyTest
//
//  Created by Roman Shestopal on 01.04.2025.
//

import Foundation
import UIKit

struct CharacterResponse: Codable {
    let results: [Character]
}
struct Character: Codable {
    let id: Int64
    let name: String
    let image: String
    let dataImage: Data?
}
