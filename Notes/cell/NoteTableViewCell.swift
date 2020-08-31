//
//  categoriesNameTableViewCell.swift
//  Notes
//
//  Created by Hany Kh on 20/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var dscription: UILabel!
    
    @IBOutlet weak var doneButton: ButtonDesignable!
    var note:Note!
    var noteController:NoteController!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setNote(note:Note) {
        noteController = NoteController()
        self.note = note
        title.text = note.title
        dscription.text = note.descriptions
        doneButton.backgroundColor = note.stauts ? UIColor(named: "Done Color") : UIColor(named: "Waiting Color")
        
    }
    @IBAction func doneAction(_ sender: Any) {
        performDone()
    }
}
extension NoteTableViewCell{
    func performDone() {
        if note.stauts {
            let updatedNote = Note()
            updatedNote.id = note.id
            updatedNote.title = note.title
            updatedNote.descriptions = note.descriptions
            updatedNote.stauts = false
            noteController.update(updatedNote: updatedNote)
            doneButton.backgroundColor = UIColor(named: "Waiting Color")
            
        }else{
             let updatedNote = Note()
             updatedNote.id = note.id
             updatedNote.title = note.title
             updatedNote.descriptions = note.descriptions
             updatedNote.stauts = true
             noteController.update(updatedNote: updatedNote)
             doneButton.backgroundColor = UIColor(named: "Done Color")
            
        }
    }
    
}
