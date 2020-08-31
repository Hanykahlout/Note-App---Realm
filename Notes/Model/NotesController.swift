//
//  NotesController.swift
//  Notes
//
//  Created by Hany Kh on 29/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation
import RealmSwift
import SCLAlertView
class NoteController{
    
    var realm = try! Realm()
    
    func save(note:Note,inCategory:Category) {
        try! realm.write{
            inCategory.notes.append(note)
        }
    }
    
    func create(note:Note)  {
       try! realm.write{
            realm.add(note)
        }
    }
    
    func read() -> Results<Note>{
        let notes = realm.objects(Note.self)
        return notes
    }
    
    func update(updatedNote:Note) {
        try! realm.write{
            realm.add(updatedNote, update: .modified)
        }
    }
//    func update(noteId:String,stauts:Bool) -> Bool {
//        do{
//            let fetchR:NSFetchRequest = Note.fetchRequest()
//            fetchR.fetchLimit = 1
//            fetchR.predicate = NSPredicate(format: "id = %@", noteId)
//            let note = try context.fetch(fetchR)
//            if !note.isEmpty{
//                if let _note = note.first{
//                    _note.setValue(stauts, forKey: "stauts")
//                    try context.save()
//                    return true
//                }
//            }else{
//                SCLAlertView().showError("Error", subTitle: "Category Not Found !!")
//            }
//        }catch let error as NSError{
//            print(error)
//        }
//        return false
//    }
    func delete(note:Note)  {
        try! realm.write{
            realm.delete(note)
        }
    }
    
}
