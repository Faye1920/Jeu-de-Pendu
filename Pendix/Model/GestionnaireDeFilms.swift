//
//  GestionnaireDeFilms.swift
//  Pendix
//
//  Created by Faye on 2023-07-05.
//

import Foundation

class MovieDownloader {
    
    static let shared = MovieDownloader()
    
    
    private init() {}
    
    func downloadMovie(withID id: String, completion: @escaping (Film?) -> Void) {
        let urlRef = "https://www.omdbapi.com/?apikey=80d6bf3a&i=\(id)"
        guard let url = URL(string: urlRef) else {
            print("Invalid URL: \(urlRef)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let film = try decoder.decode(Film.self, from: data)
                    debugPrint(film)
                    DispatchQueue.main.async {
                        completion(film)
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }
        task.resume()
    }
}
