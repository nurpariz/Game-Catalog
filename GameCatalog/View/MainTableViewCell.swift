//
//  MainTableViewCell.swift
//  GameCatalog
//
//  Created by Nurpariz Muhammad on 10/08/21.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    var formatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupImage()
        
    }
    
    func setupImage() {
        coverImageView.layer.cornerRadius = 15
        coverImageView.layer.borderWidth = 1
        coverImageView.layer.borderColor = #colorLiteral(red: 0.913613975, green: 0.9137097001, blue: 0.9176982641, alpha: 1)
        coverImageView.layer.masksToBounds = true
    }
    
    func setupTableViewCell(with game: Game) {
        nameLabel.text = game.name
        releasedLabel.text = formatter.convertDateFormat(game.released)
        genresLabel.text = "\(game.genres.map({$0.name}).joined(separator: ", "))"
        ratingLabel.text = "\(game.rating)"
        coverImageView.sd_setImage(with: URL(string: game.image ?? ""), completed: nil)
    }
}
