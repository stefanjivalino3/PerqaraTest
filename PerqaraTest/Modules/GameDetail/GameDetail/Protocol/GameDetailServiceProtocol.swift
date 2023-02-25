//  
//  GameDetailServiceProtocol.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//

import Foundation

protocol GameDetailServiceProtocol {
    
    func getGameDetail(id: String, onSuccess: (@escaping (GameDetailModel) -> Void) , onFailure: (@escaping (Error) -> Void))

}
