//  
//  GameDetailViewModel.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//

import Foundation
import UIKit

class GameDetailViewModel {

    private let service: GameDetailServiceProtocol

    private var model: [GameDetailModel] = [GameDetailModel]() {
        didSet {
            self.count = self.model.count
        }
    }

    /// Count your data in model
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var count: Int = 0
    var gameId: Int = 0
    var gameDetailData = GameDetailModel()
    var favoriteModel = [GamesFavorite]()
    
    var isFavorite = false

    //MARK: -- Network checking

    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()

    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }

    //MARK: -- UI Status

    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    /// Define selected model
    var selectedObject: GameDetailModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?
    var didCheckFavorite: (() -> ())?

    init(withGameDetail serviceProtocol: GameDetailServiceProtocol = GameDetailService() ) {
        self.service = serviceProtocol

    }

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    
    func getGameDetail(id: String) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            service.getGameDetail(id: id) { [weak self] result in
                let data = result
                
                self?.gameDetailData = data
                self?.didGetData?()
            } onFailure: { [weak self] error in
                guard self != nil else {return}
                print(error)
            }
        default:
            break
        }
    }
    
    func saveFavoriteGame() {
        var count = 0
        var devString = ""
        isFavorite = true
        for dev in self.gameDetailData.developers ?? [] {
            if count == 0 {
                devString = devString + (dev.name ?? "")
            } else {
                devString = devString + " & \(dev.name ?? "")"
            }
            count += 1
        }
        
        let newItem = GamesFavorite(context: self.context)
        newItem.gameId = Int16(self.gameId)
        newItem.name = self.gameDetailData.name
        newItem.released = self.gameDetailData.released
        newItem.rating = self.gameDetailData.rating ?? 0
        newItem.playtime = Int16(self.gameDetailData.playtime ?? 0)
        newItem.desc = self.gameDetailData.description
        newItem.background_image = self.gameDetailData.background_image
        newItem.developers = devString
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func checkFavorite() {
        do {
            favoriteModel = try context.fetch(GamesFavorite.fetchRequest())
            for n in favoriteModel {
                if n.gameId == self.gameId {
                    isFavorite = true
                    didCheckFavorite?()
                }
            }
        }
        catch {}
    }
    
    func deleteFavorite() {
        do {
            favoriteModel = try context.fetch(GamesFavorite.fetchRequest())
            for n in favoriteModel {
                if n.gameId == self.gameId {
                    isFavorite = false
                    didCheckFavorite?()
                    context.delete(n)
                    do {
                        try context.save()
                    } catch {}
                }
            }
        }
        catch {}
    }


}

extension GameDetailViewModel {

}
