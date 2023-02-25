//  
//  GamesListService.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 22/02/23.
//

import Foundation

class GamesListService: GamesListServiceProtocol {
    
    func getGamesListData(url: String, onSuccess: @escaping (GamesListModel) -> Void, onFailure: @escaping ((Error) -> Void)) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            //have data
            var result: GamesListModel?
            do {
                result = try JSONDecoder().decode(GamesListModel.self, from: data)
                onSuccess(result ?? GamesListModel())
            }
            catch {
                onFailure(error)
            }
            
            guard result != nil else {
                return
            }
        }).resume()
    }
    
    func getSearchGameList(search: String, onSuccess: @escaping (GamesListModel) -> Void, onFailure: @escaping ((Error) -> Void)) {
        URLSession.shared.dataTask(with: URL(string: "https://api.rawg.io/api/games?search=\(search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")&key=688f6c56cc1a4fc38339d2b1f03c9107")!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            //have data
            var result: GamesListModel?
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys

                result = try decoder.decode(GamesListModel.self, from: data)
                onSuccess(result ?? GamesListModel())
            }
            catch {
                onFailure(error)
            }
            
            guard result != nil else {
                return
            }
        }).resume()
    }

}
