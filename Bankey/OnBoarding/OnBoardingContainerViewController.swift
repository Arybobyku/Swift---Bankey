//
//  OnBoardingContainerViewController.swift
//  Bankey
//
//  Created by Ary Boby Siregar on 01/09/22.
//

import UIKit

protocol OnBoardingContainerViewControllerDelegate:AnyObject{
    func didFinishOnBoarding()
}

class OnBoardingContainerViewController:UIViewController{
    
    let pageViewController:UIPageViewController
    var pages = [UIViewController]()
    var currentVC:UIViewController
    let closeButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    let doneButtonn = UIButton(type: .system)
    
    weak var delegate:OnBoardingContainerViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal,options: nil)
        
        let page1 = OnBoardingViewController(
        heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has brand new look and feel that will make you feel like you are back in 1898")
        let page2 = OnBoardingViewController(
        heroImageName: "world", titleText: "Bankey is faster, easier to use, and has brand new look and feel that will make you feel like you are back in 1898")
        let page3 = OnBoardingViewController(heroImageName: "thumbs", titleText: "Bankey is faster, easier to use, and has brand new look and feel that will make you feel like you are back in 1898")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        style()
        layout()
        
    }
    
    private func setUp(){
        view.backgroundColor = .systemBrown
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor)
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false,completion: nil)
        currentVC = pages.first!
    }
    
    private func style(){
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.setTitleColor(.white, for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        
        doneButtonn.translatesAutoresizingMaskIntoConstraints = false
        doneButtonn.setTitle("Done", for: [])
        doneButtonn.setTitleColor(.white, for: [])
        doneButtonn.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: [])
        backButton.setTitleColor(.white, for: [])
        backButton.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
    }
    
    private func layout(){
        view.addSubview(closeButton)
        view.addSubview(doneButtonn)
        view.addSubview(backButton)
        
        //close button
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1)
        ])
        
        //back button
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 4)
        ])
        
        //done button
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButtonn.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButtonn.bottomAnchor, multiplier: 4)
        ])
        
    }
    
}

extension OnBoardingContainerViewController:UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    
    private func getNextViewController(from viewController:UIViewController)->UIViewController?{
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else{
            return nil
        }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }
    
    private func getPreviousViewController(from viewController:UIViewController)->UIViewController?{
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else{
            return nil
        }
        currentVC = pages[index - 1]
        return pages[index-1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
    
}

extension OnBoardingContainerViewController{
    
    @objc func closeTapped(_ sender:UIButton){
        delegate?.didFinishOnBoarding()
    }
    
    @objc func doneTapped(_ sender:UIButton){
        
    }
    
    @objc func backTapped(_ sender:UIButton){
        
        guard let previousVC = getPreviousViewController(from: currentVC) else{
            return
        }
        
        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true, completion: nil)
        
    }
    
}
