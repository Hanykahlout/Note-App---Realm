//
//  SignInViewController.swift
//  Notes
//
//  Created by Hany Kh on 18/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit
import SCLAlertView

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userController:UserController!
    var userManager:UserManager!
    var user:User!
    override func viewDidLoad() {
        super.viewDidLoad()
        initalization()
    }
    
    func initalization(){
        userController = UserController()
        userManager = UserManager()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        performSignin()
        
    }
    
    @IBAction func SignupAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension SignInViewController {
    
    func performSignin() {
        if cheackData(){
            if isExist(){
                if matchPassword(){
                    userManager.create(user: user)
                    clear()
                    goToCategoriesScreen()
                }
            }
        }
    }
    
    func cheackData() -> Bool {
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty{
            return true
        }
        SCLAlertView().showError("Error", subTitle: "Fill all the fields, There is empty fields")
        return false
    }
    
    func isExist() -> Bool {
        let email = emailTextField.text!
        let allUser = userController.read().toArray(ofType: User.self) as [User]
        for myUser in allUser{
            if myUser.email == email{
                user = myUser
                return true
            }
        }
        SCLAlertView().showError("Error", subTitle: "Invaild Email")
        
        return false
        
    }
    
    func matchPassword() -> Bool {
        if user.password == passwordTextField.text!{
            return true
        }
        SCLAlertView().showWarning("Error", subTitle: "Invaild Password")
        return false
    }
    func goToCategoriesScreen()  {
        let vc = storyboard?.instantiateViewController(identifier: "SecondNC") as! UINavigationController
        present(vc, animated: true)
    }
    func clear(){
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
}

