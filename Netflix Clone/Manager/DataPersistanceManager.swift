//
//  DataPersistanceManager.swift
//  Netflix Clone
//
//  Created by Admin on 13/01/23.
//

import Foundation
import UIKit
import CoreData

class DataPersistanceManager {
    
    enum DatabaseError {
        case failedToSaveData
        case failToFeatchData
        case failedtoDeleteData
    }
    
    static let shared = DataPersistanceManager()
    
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>)-> Void) {
        
        //we required the reference of persistance and save contex
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
//
       let context = appDelegate.persistentContainer.viewContext
//
        let item = TitleItem(context: context)

        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
//
        // saving data
        
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToSaveData as! Error))
            print(error.localizedDescription)
        }
    }
    
    func fetchingItemFromDataBase(completion: (Result<[TitleItem], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do{
            
            let title = try context.fetch(request)
            completion(.success(title))
        }catch {
            completion(.failure(DatabaseError.failToFeatchData as! Error))
            print(error.localizedDescription)
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model) //asking database manager to delete certain object
        
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedtoDeleteData as! Error))
        }
    }
}
