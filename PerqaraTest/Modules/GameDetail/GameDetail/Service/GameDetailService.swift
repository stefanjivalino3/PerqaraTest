//  
//  GameDetailService.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//

import Foundation

class GameDetailService: GameDetailServiceProtocol {
    func getGameDetail(id: String, onSuccess: @escaping ((GameDetailModel) -> Void), onFailure: @escaping ((Error) -> Void)) {
        URLSession.shared.dataTask(with: URL(string: "https://api.rawg.io/api/games/\(id)?key=688f6c56cc1a4fc38339d2b1f03c9107")!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            //have data
            var result: GameDetailModel?
            do {
                result = try JSONDecoder().decode(GameDetailModel.self, from: data)
                onSuccess(result ?? GameDetailModel())
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
