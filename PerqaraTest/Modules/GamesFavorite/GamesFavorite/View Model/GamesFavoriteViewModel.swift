//  
//  GamesFavoriteViewModel.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//

import Foundation
import UIKit

class GamesFavoriteViewModel {

    private let service: GamesFavoriteServiceProtocol

    private var model: [GamesFavoriteModel] = [GamesFavoriteModel]() {
        didSet {
            self.count = self.model.count
        }
    }

    /// Count your data in model
    var count: Int = 0
    var fetchSuccess = false
    
    var favoriteData = [GamesFavorite]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
    var selectedObject: GamesFavoriteModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

    init(withGamesFavorite serviceProtocol: GamesFavoriteServiceProtocol = GamesFavoriteService() ) {
        self.service = serviceProtocol

    }

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }

    //MARK: -- Core Data Func
    func getAllItems() {
        do {
            fetchSuccess = true
            favoriteData = try context.fetch(GamesFavorite.fetchRequest())
            didGetData?()
        }
        catch {
            fetchSuccess = false
        }
    }
    
    

}

extension GamesFavoriteViewModel {

}
