//  
//  GamesListView.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 22/02/23.
//

import UIKit
import UIScrollView_InfiniteScroll

class GamesListView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView!
    
    // VARIABLES HERE
    var viewModel = GamesListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupViewModel()
        
        viewModel.getGamesList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Games For You"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupView() {
        self.hideKeyboardWhenTappedAround()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNIB(with: GamesCell.self)
        tableView.registerNIB(with: SearchBarCell.self)
        tableView.registerNIB(with: EmptyViewCell.self)
        
        tableView.addInfiniteScroll { [weak self] scrollView in
            guard let self = self else {return}
            if self.viewModel.noPagination == false {
                self.viewModel.getNextPageGamesList(url: self.viewModel.next)
                
            } else {
                scrollView.finishInfiniteScroll()
            }
        }
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
        
        self.viewModel.didGetNextPage = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.finishInfiniteScroll(completion: nil)
            }
        }

    }
    
}


extension GamesListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.searchState == .success {
            return self.viewModel.gamesListData.results?.count ?? 0 + 1
        }
        else  {
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueCell(with: SearchBarCell.self)!
            cell.selectionStyle = .none
            
            cell.didChangeSearchValue = { [weak self] in
                self?.viewModel.getSearch(search: cell.searchBar.text ?? "")
            }
            
            cell.didSearchLessThenThree = {
                self.viewModel.searchState = .lessThenThree
                self.tableView.reloadData()
            }
            
            
            
            return cell
        } else {
            switch self.viewModel.searchState {
            case .success:
                let cell = tableView.dequeueCell(with: GamesCell.self)!
                cell.selectionStyle = .none
                cell.configureCell(gamesImage: self.viewModel.gamesListData.results?[indexPath.row - 1].background_image ?? "",
                                   title: self.viewModel.gamesListData.results?[indexPath.row - 1].name ?? "",
                                   releaseDate: self.viewModel.gamesListData.results?[indexPath.row - 1].released ?? "",
                                   rating: self.viewModel.gamesListData.results?[indexPath.row - 1].rating ?? 0)
                
                return cell
            case .lessThenThree:
                let cell = tableView.dequeueCell(with: EmptyViewCell.self)!
                cell.selectionStyle = .none
                cell.descriptionLabel.text = "Please search with more then three keyword!"
                
                return cell
                
                
            case .notFound:
                let cell = tableView.dequeueCell(with: EmptyViewCell.self)!
                cell.selectionStyle = .none
                cell.descriptionLabel.text = "Sorry, we cannot find your games"
                
                return cell
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            if self.viewModel.searchState == .success {
                let vc = GameDetailView()
                vc.gameId = self.viewModel.gamesListData.results?[indexPath.row - 1].id
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        } else {
            switch viewModel.searchState {
            case .success:
                return 130
            default:
                return 200
            }
        }
        
    }
    
    
}

