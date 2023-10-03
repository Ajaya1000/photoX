//
//  ViewController.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import UIKit

class HomeViewController: BaseTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension HomeViewController {
    func setup(with items: [UIViewController]) {
        self.setViewControllers(items, animated: true)
    }
}
