//
//  GameService.swift
//  GameCatalog
//
//  Created by Nurpariz Muhammad on 10/08/21.
//

import Foundation

class GameService {
    
    static let shared = GameService()
    
    private init() {}
    
    var key: String {
        let infoPlistPath = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let dictionaryInfo = NSDictionary(contentsOfFile: infoPlistPath)
        return dictionaryInfo!["key"] as! String
    }
    
    func getGameResponse (page: Int, search: String,completion: @escaping (Result<(GameResponse), Error>) -> Void) {
        
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "page_size", value: "\(20)"),
            URLQueryItem(name: "search", value: search)
        ]
        
        let request = URLRequest(url: components.url!, timeoutInterval: 10)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                if response.statusCode == 200 {
                    do {
                        let results = try JSONDecoder().decode(GameResponse.self, from: data)
                        let games = results
                        completion(.success(games))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    print("Error : \(data), HTTP Status : \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
    
    func detailGameResponse(id: Int, completion: @escaping (Result<(Game), Error>) -> Void) {
        
        var components = URLComponents(string: "https://api.rawg.io/api/games/\(id)")!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: key)
        ]
        
        let url = URLRequest(url: components.url!, timeoutInterval: 10)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                if response.statusCode == 200 {
                    do {
                        let results = try JSONDecoder().decode(Game.self, from: data)
                        let games = results
                        completion(.success(games))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    print("Error : \(data), HTTP Status : \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
}
