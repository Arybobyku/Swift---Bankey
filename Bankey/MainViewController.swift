//
//  MainViewController.swift
//  Bankey
//
//  Created by Ary Boby Siregar on 07/09/22.
//

import UIKit

class MainViewController:UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpBar()
    }
    
    private func setUpViews(){
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()
        
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        summaryNC.navigationBar.barTintColor = appColor
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC, moneyNC, moreNC]
        
        viewControllers = tabBarList
        
    }
    
    private func hideNavigationBarLine(_ navigationBar:UINavigationBar){
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setUpBar(){
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}

class AccountSummaryViewController:UIViewController{
    override func viewDidLoad() {
        view.backgroundColor = .systemGreen
    }
}

class MoveMoneyViewController:UIViewController{
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}
class MoreViewController:UIViewController{
    override func viewDidLoad() {
        view.backgroundColor = .systemRed
    }
}
