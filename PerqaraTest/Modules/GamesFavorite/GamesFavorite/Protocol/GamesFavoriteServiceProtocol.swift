//  
//  GamesFavoriteServiceProtocol.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//

import Foundation

protocol GamesFavoriteServiceProtocol {
    func removeThisFuncName(success: @escaping(_ data: GamesFavoriteModel) -> (), failure: @escaping() -> ())

}
