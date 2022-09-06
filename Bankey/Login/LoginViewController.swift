//
//  ViewController.swift
//  Bankey
//
//  Created by Ary Boby Siregar on 01/09/22.
//

import UIKit

protocol LoginViewControllerDelegate:AnyObject{
    func didLogin()
}

protocol LogoutDelegate:AnyObject{
    func didLogout()
}

class LoginViewController: UIViewController {

    let titleView = UILabel()
    let subTitleView = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate:LoginViewControllerDelegate?
    
    var username:String?{
        return loginView.usernameTextField.text
    }
    
    var password:String?{
        return loginView.passwordTextField.text
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        signInButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension LoginViewController{
    private func style(){
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.textAlignment = .center
        titleView.text = "Bankey"
        titleView.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        subTitleView.translatesAutoresizingMaskIntoConstraints = false
        subTitleView.textAlignment = .center
        subTitleView.font = UIFont.preferredFont(forTextStyle: .title3)
        subTitleView.numberOfLines = 0
        subTitleView.text = "Your premium source for all things banking!"
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        
    }
    
    private func layout(){
        view.addSubview(titleView)
        view.addSubview(subTitleView)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        //Title View
        NSLayoutConstraint.activate([
            subTitleView.topAnchor.constraint(equalToSystemSpacingBelow: titleView.bottomAnchor, multiplier: 2),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        //subtitle View
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subTitleView.bottomAnchor, multiplier: 3),
            subTitleView.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subTitleView.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //loginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        //button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //error message
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        
    }
}


extension LoginViewController{
    @objc func signInTapped(sender:UIButton){
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login(){
//        guard let username = username,let password = password else{
//            assertionFailure("username / password should never be nil")
//            return
//        }
        
        delegate?.didLogin()
        
//        if username.isEmpty || password.isEmpty{
//            configureMessage(withMessage: "Username / password cannot be blank")
//            return
//        }
//
//        if username == "Boby" && password == "123"{
//            signInButton.configuration?.showsActivityIndicator = true
//            delegate?.didLogin()
//        }else{
//            configureMessage(withMessage: "Incorrect username / password")
//            return
//        }
        
    }
    
    private func configureMessage(withMessage message:String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
}
