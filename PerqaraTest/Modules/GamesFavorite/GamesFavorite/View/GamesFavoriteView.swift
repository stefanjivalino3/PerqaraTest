//  
//  GamesFavoriteView.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//

import UIKit

class GamesFavoriteView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.registerNIB(with: GamesCell.self)
            tableView.registerNIB(with: EmptyViewCell.self)
        }
    }
    
    // VARIABLES HERE
    var viewModel = GamesFavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Favorite Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.viewModel.getAllItems()
    }
    
    fileprivate func setupViewModel() {

        self.viewModel.showAlertClosure = {
            let alert = self.viewModel.alertMessage ?? ""
            print(alert)
        }
        
        self.viewModel.updateLoadingStatus = {
            if self.viewModel.isLoading {
                print("LOADING...")
            } else {
                 print("DATA READY")
            }
        }

        self.viewModel.internetConnectionStatus = {
            print("Internet disconnected")
            // show UI Internet is disconnected
        }

        self.viewModel.serverErrorStatus = {
            print("Server Error / Unknown Error")
            // show UI Server is Error
        }

        self.viewModel.didGetData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

    }
    
}

extension GamesFavoriteView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.favoriteData.count == 0 {
            return 1
        }
        else {
            return viewModel.favoriteData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.favoriteData.count == 0 {
            let cell = tableView.dequeueCell(with: EmptyViewCell.self)!
            cell.selectionStyle = .none
            cell.descriptionLabel.text = "You don't have favorite games"
            
            return cell
        } else {
            let cell = tableView.dequeueCell(with: GamesCell.self)!
            cell.selectionStyle = .none
            cell.configureCell(gamesImage: viewModel.favoriteData[indexPath.row].background_image ?? "",
                               title: viewModel.favoriteData[indexPath.row].name ?? "",
                               releaseDate: viewModel.favoriteData[indexPath.row].released ?? "",
                               rating: viewModel.favoriteData[indexPath.row].rating )
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GameDetailView()
        vc.gameId = Int(self.viewModel.favoriteData[indexPath.row].gameId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.favoriteData.count == 0 {
            return 250
        } else {
            return 130
        }
        
    }
    
    
}


