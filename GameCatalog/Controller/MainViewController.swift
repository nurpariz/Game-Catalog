//
//  ViewController.swift
//  GameCatalog
//
//  Created by Nurpariz Muhammad on 10/08/21.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    var games: [Game] = []
    var currentPage = 1
    var querySearch = ""
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchGameResponse(page: 1, search: "")
        createSearchBar()
        
    }
    
    @IBAction func goToProfileButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToProfile", sender: self)
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        spinner.transform = transform
        spinner.center = footerView.center
        spinner.color = .systemBackground
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    private func fetchGameResponse(page: Int, search: String) {
        GameService.shared.getGameResponse(page: page, search: search) { [weak self] result in
            switch result {
            case .success(let game):
                self?.games.append(contentsOf: game.results)
                DispatchQueue.main.async {
                    self?.mainTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMore() {
        currentPage += 1
        fetchGameResponse(page: currentPage, search: querySearch)
    }
    
    private func createSearchBar() {
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search your game"
        searchController.searchBar.searchTextField.backgroundColor = .systemBackground
        searchController.searchBar.barTintColor = .black
        UITextField.appearance(whenContainedInInstancesOf: [type(of: searchController.searchBar)]).tintColor = .black
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "mainViewCell", for: indexPath) as! MainTableViewCell
        
        if indexPath.row < games.count {
            cell.setupTableViewCell(with: games[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "GameDetailViewController") as? GameDetailViewController
        
        vc?.gameId = games[indexPath.row].id
        
        mainTableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == games.count - 1 {
            loadMore()
        }
        self.mainTableView.tableFooterView = createSpinnerFooter()
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        querySearch = text
        GameService.shared.getGameResponse(page: 1, search: text) { [weak self] result in
            switch result {
            case .success(let game):
                self?.games = game.results
                self?.games.append(contentsOf: game.results)
                DispatchQueue.main.async {
                    self?.mainTableView.isHidden = game.results.isEmpty
                    self?.mainTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
