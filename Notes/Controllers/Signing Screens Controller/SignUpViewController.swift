//
//  SignUpViewController.swift
//  Notes
//
//  Created by Hany Kh on 18/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit
import SCLAlertView

class SignUpViewController: UIViewController {
    
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var userController:UserController!
    var userManager:UserManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        initalization()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func initalization() {
        removeBackgroungNavBar()
        userManager = UserManager()
        userController = UserController()
    }
    
    func removeBackgroungNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SigninAction(_ sender: Any) {
        performSignUp()
    }
}

extension SignUpViewController{
    
    func performSignUp() {
        if cheackData(){
            if !thereIsASameEmail(){
                saveData()
                goToCategoriesScreen()
                clear()
                
            }else{
                SCLAlertView().showError("Error", subTitle: "There is a User with the same email, please enter a vaild email")
            }
        }
    }
    
    func cheackData() -> Bool{
        if !firstNameTextField.text!.isEmpty &&
            !lastNameTextField.text!.isEmpty &&
            !phoneTextField.text!.isEmpty &&
            !emailTextField.text!.isEmpty &&
            !password.text!.isEmpty {
            return true
        }
        SCLAlertView().showError("Error", subTitle: "Fill all the fields, There is empty fields")
        return false
    }
    
    func thereIsASameEmail()->Bool{
        let users = userController.read().toArray(ofType: User.self) as [User]
        for user in users {
            if user.email == emailTextField.text!{
                return true
            }
        }
        return false
    }
    
    func saveData() {
        let user = User()
        user.id = UUID().uuidString
        user.firstName = firstNameTextField.text!
        user.lastName = lastNameTextField.text!
        user.password = password.text!
        user.phoneNumber = phoneTextField.text!
        user.email = emailTextField.text!
        userController.create(user: user)
        userManager.create(user: user)
    }
    
    func clear(){
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        phoneTextField.text = ""
        password.text = ""
    }
    func goToCategoriesScreen()  {
        let vc = storyboard?.instantiateViewController(identifier: "SecondNC") as! UINavigationController
        present(vc, animated: true)
    }
    
    
}
