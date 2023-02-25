//  
//  GamesListServiceProtocol.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 22/02/23.
//

import Foundation

protocol GamesListServiceProtocol {
    
    func getGamesListData(url: String, onSuccess: (@escaping (GamesListModel) -> Void) , onFailure: (@escaping (Error) -> Void))
    func getSearchGameList(search: String, onSuccess: (@escaping (GamesListModel) -> Void) , onFailure: (@escaping (Error) -> Void))

}
