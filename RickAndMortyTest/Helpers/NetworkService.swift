//
//  NetworkService.swift
//  RickAndMortyTest
//
//  Created by Roman Shestopal on 01.04.2025.
//

import Foundation
import Network

class NetworkService {
    static let shared = NetworkService()
    private let monitor = NWPathMonitor()
    private let url = "https://rickandmortyapi.com/api/character"
    
    var isConnected: Bool = false
    
    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            print("Інтернет підключення: \(self.isConnected ? "є" : "немає")")
        }
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }
        
    func fetchCharacters(completion: @escaping ([Character]?) -> Void) {
        guard let requestURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let response = try? JSONDecoder().decode(CharacterResponse.self, from: data)
            completion(response?.results)
        }.resume()
    }
}
