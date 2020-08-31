//
//  newNoteViewController.swift
//  Notes
//
//  Created by Hany Kh on 20/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit
import SCLAlertView
class NewNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: BottomBorderTextField!
    @IBOutlet weak var descriptionTextField: BottomBorderTextField!
    @IBOutlet weak var screenTitle: UILabel!
    var isSave:Bool!
    var category:Category!
    var noteController:NoteController!
    var note:Note!
    override func viewDidLoad() {
        super.viewDidLoad()
        initlaztion()
        // Do any additional setup after loading the view.
    }
    func initlaztion() {
        clearBackgroundNavBar()
        noteController = NoteController()
        setScreenTitle()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        performSave()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func setScreenTitle() {
        if isSave{
            screenTitle.text = "New Note..."
        }else{
            screenTitle.text = "Update Note..."
            titleTextField.text = note.title
            descriptionTextField.text = note.descriptions
        }
    }
    
    func clearBackgroundNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
}
extension NewNoteViewController{
    func performSave(){
        if cheackData(){
            isSave ? save() : update()
            clear()
        }
    }
    func cheackData() -> Bool {
        if !titleTextField.text!.isEmpty &&
            !descriptionTextField.text!.isEmpty {
            return true
        }
        SCLAlertView().showError("Error", subTitle: "Fill All Field 😥 👎🏻")
        return false
    }
    
    func save()  {
        let note = Note()
        note.id = UUID().uuidString
        note.title = titleTextField.text!
        note.descriptions = descriptionTextField.text!
        note.stauts = false
        noteController.save(note: note, inCategory: category)
        noteController.create(note: note)
        SCLAlertView().showInfo("Succefully Added", subTitle: "Your Note has been created 😘😘😘")
        clear()
        
    }
    
    func update()  {
        
        let updatedNote = Note()
        updatedNote.id = note.id
        updatedNote.title = titleTextField.text!
        updatedNote.descriptions = descriptionTextField.text!
        updatedNote.stauts = note.stauts
        noteController.update(updatedNote: updatedNote)
        clear()
        SCLAlertView().showInfo("Succefully Upddated", subTitle: "Your note has been updated 😍😍😍")
        
    }
    
    func clear() {
        titleTextField.text = ""
        descriptionTextField.text = ""
    }
    
}
