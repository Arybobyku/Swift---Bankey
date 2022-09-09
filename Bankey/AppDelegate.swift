//
//  AppDelegate.swift
//  Bankey
//
//  Created by Ary Boby Siregar on 01/09/22.
//

import UIKit

let appColor:UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    ///memory only exist when app running if app restart memory reset
//    var hasOnBoarded = false
    
    let loginViewController = LoginViewController()
    let onBoardingContainerViewController = OnBoardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    let accountSummaryViewController = AccountSummaryViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onBoardingContainerViewController.delegate = self
        dummyViewController.delegate = self
        
        window?.rootViewController = mainViewController
        
        //        window?.rootViewController = OnBoardingContainerViewController()
        
        mainViewController.selectedIndex = 0
        
        return true
    }
    
}

extension AppDelegate:LoginViewControllerDelegate{
    func didLogin() {
        if LocalState.hasOnBoarded{
            setRootViewController(dummyViewController)
        }else{
            setRootViewController(onBoardingContainerViewController)
        }
    }
}

extension AppDelegate:OnBoardingContainerViewControllerDelegate{
    func didFinishOnBoarding() {
        LocalState.hasOnBoarded = true
        setRootViewController(dummyViewController)
    }
}

extension AppDelegate:LogoutDelegate{
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate{
    func setRootViewController(_ vc:UIViewController, animated:Bool = true){
        guard animated, let window = self.window else{
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.7, animations: nil,completion: nil)
        
    }
}

