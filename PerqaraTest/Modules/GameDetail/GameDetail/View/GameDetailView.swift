//  
//  GameDetailView.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//

import UIKit

class GameDetailView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.registerNIB(with: GameDetailCell.self)
        }
    }
    
    // VARIABLES HERE
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var viewModel = GameDetailViewModel()
    var gameId: Int?
    var gameModel = GamesFavorite()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        
        viewModel.gameId = gameId ?? 0
        viewModel.getGameDetail(id: "\(gameId ?? 0)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Detail"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteTapped))
        
        navigationItem.rightBarButtonItem?.tintColor = .red
        
        viewModel.checkFavorite()
        
    }
    
    func setupImage() {
        let topSafeArea: CGFloat
        let bottomSafeArea: CGFloat

        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        
        let deviceHeight = UIScreen.main.bounds.size.height
        gameImageViewHeight.constant = (deviceHeight - topSafeArea - bottomSafeArea) * (2/5)
        
        gameImageView.showImageFromUrl(url: viewModel.gameDetailData.background_image ?? "")
        
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
                self?.setupImage()
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.didCheckFavorite = { [weak self] in
            DispatchQueue.main.async {
                if self?.viewModel.isFavorite == true {
                    self?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(self?.favoriteTapped))
                    self?.navigationItem.rightBarButtonItem?.tintColor = .red
                } else {
                    self?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(self?.favoriteTapped))
                    self?.navigationItem.rightBarButtonItem?.tintColor = .red
                }
            }
        }

    }
    
    @objc func favoriteTapped() {
        var title = ""
        if self.viewModel.isFavorite == true {
            title = "Remove this game from your favorite?"
        } else {
            title = "Add this game to your favorite?"
        }
        
        
        let sheet = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            if self?.viewModel.isFavorite == true {
                self?.viewModel.deleteFavorite()
                self?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(self?.favoriteTapped))
                self?.navigationItem.rightBarButtonItem?.tintColor = .red
            } else {
                self?.viewModel.saveFavoriteGame()
                self?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(self?.favoriteTapped))
                self?.navigationItem.rightBarButtonItem?.tintColor = .red
            }
            
        }))
        
        self.present(sheet, animated: true)
    }
    
}

extension GameDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: GameDetailCell.self)!
        cell.selectionStyle = .none
        
        // GET DEVELOPER
        var count = 0
        var devString = ""
        for dev in viewModel.gameDetailData.developers ?? [] {
            if count == 0 {
                devString = devString + (dev.name ?? "")
            } else {
                devString = devString + " & \(dev.name ?? "")"
            }
            count += 1
        }
        cell.configureCell(developer: devString,
                           title: viewModel.gameDetailData.name ?? "" ,
                           release: viewModel.gameDetailData.released ?? " - " ,
                           rating: viewModel.gameDetailData.rating ?? 0 ,
                           playCount: viewModel.gameDetailData.playtime ?? 0 ,
                           description: viewModel.gameDetailData.description ?? "" )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

