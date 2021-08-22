//
//  ProfileViewController.swift
//  GameCatalog
//
//  Created by Nurpariz Muhammad on 11/08/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var personalDataLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfile()
        
    }
    
    func setupProfile() {
        
        profileImageView.setCornerRadius()
        
        personalDataLabel.text = "PERSONAL DATA"
        nameLabel.text = "Muhammad Yusuf Nurpariz"
        emailLabel.text = "my.nurpariz@gmail.com"
        descLabel.text = "Muhammad Yusuf Nurpariz adalah seorang pria kelahiran Bekasi, Jawa Barat. Saat ini sedang mempelajari bahasa pemrograman Swift di Dicoding Indonesia untuk menjadi seorang IOS Developer."
        profileImageView.image = UIImage(named: "fotoprofile")
    }
}
