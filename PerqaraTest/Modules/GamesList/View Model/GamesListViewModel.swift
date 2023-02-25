//  
//  GamesListViewModel.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 22/02/23.
//

import Foundation

class GamesListViewModel {

    public let service: GamesListServiceProtocol
    
    init(withGamesList serviceProtocol: GamesListServiceProtocol = GamesListService() ) {
        self.service = serviceProtocol

    }

    private var model: [GamesListModel] = [GamesListModel]() {
        didSet {
            self.count = self.model.count
        }
    }

    /// Count your data in model
    var count: Int = 0
    var next: String = ""
    var noPagination = true
    var searchState: SearchState = .success
    var gamesListData = GamesListModel()

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
    var selectedObject: GamesListModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?
    var didGetNextPage: (() -> ())?


    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }

    //MARK: -- Example Func
    func getGamesList() {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            service.getGamesListData(url: "https://api.rawg.io/api/games?key=688f6c56cc1a4fc38339d2b1f03c9107") { [weak self] result in
                let data = result
                self?.gamesListData = data
                
                if data.next == nil {
                    self?.noPagination = true
                } else {
                    self?.noPagination = false
                    self?.next = data.next ?? ""
                }
                
                self?.didGetData?()
            } onFailure: { [weak self] error in
                guard self != nil else {return}
                print(error.localizedDescription)
            }
        default:
            break
        }
    }
    
    func getNextPageGamesList(url: String) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            service.getGamesListData(url: url) { [weak self] result in
                let data = result
                
                if data.next == nil {
                    self?.noPagination = true
                    self?.gamesListData.results? += data.results ?? []
                } else {
                    self?.noPagination = false
                    self?.next = data.next ?? ""
                    self?.gamesListData.results? += data.results ?? []
                }
                
                self?.didGetNextPage?()
            } onFailure: { [weak self] error in
                guard self != nil else {return}
                print(error.localizedDescription)
            }
        default:
            break
        }
    }
    
    func getSearch(search: String) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            service.getSearchGameList(search: search) { [weak self] result in
                let data = result
                self?.gamesListData = data

                if data.next == nil {
                    self?.noPagination = true
                    if self?.gamesListData.results?.count == 0 {
                        self?.searchState = .notFound
                    }
                } else {
                    self?.searchState = .success
                    self?.noPagination = false
                    self?.next = data.next ?? ""
                }

                self?.didGetData?()
            } onFailure: { [weak self] error in
                guard self != nil else {return}
                print(error)
            }
        default:
            break
        }
    }

}

extension GamesListViewModel {

}
