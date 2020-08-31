//
//  ProfileViewController.swift
//  Notes
//
//  Created by Hany Kh on 21/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit
import SCLAlertView
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var characterLabel: UILabelDesignable!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var categoriesNumber: UILabel!
    @IBOutlet weak var doneNotesNumber: UILabel!
    @IBOutlet weak var waitingNotesNumber: UILabel!
    
    @IBOutlet weak var firstNameTextField: BottomBorderTextField!
    
    @IBOutlet weak var lastNameTextField: BottomBorderTextField!
    
    
    @IBOutlet weak var phoneNumberTextField: BottomBorderTextField!
    
    @IBOutlet weak var emailTextField: BottomBorderTextField!
    var categoriesController:CategoriesController!
    var userManager:UserManager!
    var user:User!
    var userController:UserController!
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func initlization() {
        categoriesController = CategoriesController()
        userManager = UserManager()
        user = userManager.read()
        userController = UserController()
        clearBackgroundNavBar()
        setUserInfo()
        
    }
    func setUserInfo() {
        fillUserInfo()
        let categories = user.categries.count
        categoriesNumber.text = String(categories)
        setDoneAndWaitingNumber()
        fillTextFields()
    }
    func fillUserInfo() {
        nameLabel.text = user.firstName + " " + user.lastName
        emailLabel.text = user.email
        characterLabel.text = String(user.firstName.prefix(1))
    }
    func fillTextFields() {
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
        phoneNumberTextField.text = user.phoneNumber
        emailTextField.text = user.email
    }
    func setDoneAndWaitingNumber() {
        var doneNotesNumber = 0
        var waitingNotesNumber = 0
        for everyCategory in user.categries{
            for everyNote in everyCategory.notes {
                if everyNote.stauts{
                    doneNotesNumber += 1
                }else{
                    waitingNotesNumber += 1
                }
            }
        }
        self.doneNotesNumber.text = String(doneNotesNumber)
        self.waitingNotesNumber.text = String(waitingNotesNumber)
    }
    @IBAction func saveAction(_ sender: Any) {
        performUpdate()
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func clearBackgroundNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        
    }
    
}
extension ProfileViewController {
    func performUpdate()  {
        if cheackData(){
            update()
        }else{
            SCLAlertView().showError("Error", subTitle: "You Should Fill All Text Fileds !! ☹️☹️☹️")
        }
    }
    func cheackData() -> Bool {
        if !firstNameTextField.text!.isEmpty &&
            !lastNameTextField.text!.isEmpty &&
            !phoneNumberTextField.text!.isEmpty &&
            !emailTextField.text!.isEmpty{
            return true
        }
        return false
    }
    
    func update() {
        let updatedUser = User()
        updatedUser.id = user.id
        updatedUser.firstName =  firstNameTextField.text!
        updatedUser.lastName = lastNameTextField.text!
        updatedUser.email = emailTextField.text!
        updatedUser.phoneNumber = phoneNumberTextField.text!
        updatedUser.password = user.password
        for category in user.categries {
        categoriesController.save(category: category , inUser: updatedUser)
        }
        userController.update(updatedUser: updatedUser)
        fillUserInfo()
        SCLAlertView().showInfo("Succefully Updated", subTitle: "The User Has Been Updated 😍😍😍")
        clear()
    }
    func clear() {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        phoneNumberTextField.text = ""
        emailTextField.text = ""
    }
}
