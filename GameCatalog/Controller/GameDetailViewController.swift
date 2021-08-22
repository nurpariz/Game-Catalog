//
//  GameDetailViewController.swift
//  GameCatalog
//
//  Created by Nurpariz Muhammad on 12/08/21.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var coverDetailImageView: UIImageView!
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var releasedDetailLabel: UILabel!
    @IBOutlet weak var genreDetailLabel: UILabel!
    @IBOutlet weak var platformDetailLabel: UILabel!
    @IBOutlet weak var ratingDetailLabel: UILabel!
    @IBOutlet weak var ratingPercentLabel: UILabel!
    
    var game: Game?
    var gameId: Int?
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = gameId {
            fetchGameDetail(id: id)
        }
        
    }
    
    func setupGameDetail() {
        
        coverDetailImageView.setCornerRadius()
        
        if let result = game {
            coverDetailImageView.sd_setImage(with: URL(string: result.image ?? ""), completed: nil)
            nameDetailLabel.text = result.name
            releasedDetailLabel.text = formatter.convertDateFormat(result.released)
            genreDetailLabel.text = "\(result.genres.map({$0.name}).joined(separator: ", "))"
            if let platforms = result.platforms {
                platformDetailLabel.text = "\(platforms.map({ $0.platform.name}).joined(separator: ", "))"
            }
            ratingDetailLabel.text = "\(result.rating)"
            ratingPercentLabel.text = result.description?.htmlString
        }
    }
    
    private func fetchGameDetail(id: Int) {
        GameService.shared.detailGameResponse(id: id) { [weak self] result in
            switch result {
            case .success(let game):
                self?.game = game
                DispatchQueue.main.async {
                    self?.setupGameDetail()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
