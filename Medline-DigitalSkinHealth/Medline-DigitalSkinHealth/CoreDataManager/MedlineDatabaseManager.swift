//
//  MedlineDatabaseManager.swift
//  Medline-DigitalSkinHealth
//
//  Created by Sunil Kumar Jaiswal on 22/02/21.
//

import Foundation
import EncryptedCoreData

class MedlineDatabaseManager: NSObject {
    /*
    struct DatabaseTableName {
        static let medlineWoundImageTable:String = "MedlineWoundImage"
        static let medlineUserTable:String = "MedlineUser"
    }
    
    open class func retrieveManagedObjectContext() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to get reference of App Delegate")
        }
        let nsmanagedObjectContext = appDelegate.managedObjectContext
        
        if (Thread.current.isMainThread) {
            nsmanagedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        } else {
            nsmanagedObjectContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        }
        return nsmanagedObjectContext
    }
        
    open class func saveInformation(nsmanagedObjectContext:NSManagedObjectContext?) -> Void {
        guard let retrieveManagedObjectContext = nsmanagedObjectContext else {
            fatalError("Unable to reference App Delegate, check settings and riding header")
        }
        retrieveManagedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        do {
            try retrieveManagedObjectContext.save()
        } catch {
            fatalError("Unable save data in data base")
        }
    }
    
    open class func deleteCompleteDatabaseRecords() throws -> Void {
        deleteTableRecord(tableName: DatabaseTableName.medlineWoundImageTable)
    }
    
    open class func deleteTableRecord(tableName:String?) -> Void {
        if tableName != nil && tableName?.isEmpty == false {
            let context = retrieveManagedObjectContext()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: tableName!)
            
            let result = try? context.fetch(fetchRequest)
            if(!(result?.isEmpty)! && (result?.count)! > 0){
                for object in result! {
                    context.delete(object as! NSManagedObject)
                    saveInformation(nsmanagedObjectContext: context)
                }
            }
        }
    }
    
    private class func returnWoundImageModel(nsmanagedObject: NSManagedObject?) throws -> MedlineWoundImageModel {
        var modelObject:MedlineWoundImageModel = MedlineWoundImageModel()
        if nsmanagedObject != nil {
            modelObject.isUploadedOnServer = nsmanagedObject?.value(forKey: "isUploadedOnServer") as? Int16 ?? 0
            modelObject.imageCaptureDateTime = nsmanagedObject?.value(forKey: "imageCaptureDateTime") as? Int64 ?? 0
            modelObject.imageID = nsmanagedObject?.value(forKey: "imageID") as? Int64 ?? 0
            modelObject.imageStayInLocalUpToDateTime = nsmanagedObject?.value(forKey: "imageStayInLocalUpToDateTime") as? Int64 ?? 0
            modelObject.imageUploadedOnServerDateTime = nsmanagedObject?.value(forKey: "imageUploadedOnServerDateTime") as? Int64 ?? 0
            
            modelObject.userID = retrieveProperString(retrieveString: nsmanagedObject?.value(forKey: "userID") ?? "")
            modelObject.woundImage = nsmanagedObject?.value(forKey: "woundImage") as? Data ?? nil
        }
        return modelObject
    }
    
    open class func saveWoundImage(object: MedlineWoundImageModel?) throws -> Void {
        if object != nil {
            let context = retrieveManagedObjectContext()
            
            if let entity =  NSEntityDescription.entity(forEntityName:DatabaseTableName.medlineWoundImageTable, in: context){
                let nsmanagedObject = NSManagedObject(entity: entity, insertInto: context)
                
                nsmanagedObject.setValue(object?.isUploadedOnServer, forKey: "isUploadedOnServer")
                nsmanagedObject.setValue(object?.imageCaptureDateTime, forKey: "imageCaptureDateTime")
                nsmanagedObject.setValue(object?.imageID, forKey: "imageID")
                nsmanagedObject.setValue(object?.imageStayInLocalUpToDateTime, forKey: "imageStayInLocalUpToDateTime")
                nsmanagedObject.setValue(object?.imageUploadedOnServerDateTime, forKey: "imageUploadedOnServerDateTime")
                
                nsmanagedObject.setValue(retrieveProperString(retrieveString:object?.userID), forKey: "userID")
                nsmanagedObject.setValue(object?.woundImage, forKey: "woundImage")
                
                saveInformation(nsmanagedObjectContext: context)
            }
        }
    }
    
    open class func retrieveLastWoundImage() throws -> MedlineWoundImageModel? {
        let context = retrieveManagedObjectContext()
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: DatabaseTableName.medlineWoundImageTable)
        
        let sortDescriptor = NSSortDescriptor(key: "imageID", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
    
        var woundImageModel:MedlineWoundImageModel? = nil
        if let resultArray = try? context.fetch(fetchRequest){
            if resultArray.count > 0 {
                woundImageModel = MedlineWoundImageModel()
                
                for resultObject in resultArray {
                    if let nsmanagedObject = resultObject as? NSManagedObject {
                        if let lastImage = try? returnWoundImageModel(nsmanagedObject: nsmanagedObject){
                            woundImageModel = lastImage
                        }
                    }
                }
            }
        }
        return woundImageModel ?? nil
    }
    
    open class func retrieveListOfWoundImage() throws -> [MedlineWoundImageModel] {
        let context = retrieveManagedObjectContext()
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: DatabaseTableName.medlineWoundImageTable)
        
        let sortDescriptor = NSSortDescriptor(key: "imageID", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
    
        var woundImageList:[MedlineWoundImageModel] = []
        if let resultArray = try? context.fetch(fetchRequest){
            for resultObject in resultArray {
                if let nsmanagedObject = resultObject as? NSManagedObject {
                    if let woundImageModel = try? returnWoundImageModel(nsmanagedObject: nsmanagedObject){
                        woundImageList.append(woundImageModel)
                    }
                }
            }
        }
        return woundImageList
    }
    
    open class func retrieveListOfWoundImageByUserID(userID:String?) throws -> [MedlineWoundImageModel] {
        var woundImageList:[MedlineWoundImageModel] = []
        
        if userID != nil {
            let context = retrieveManagedObjectContext()
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: DatabaseTableName.medlineWoundImageTable)
            let predicate = NSPredicate(format: "userID == %@",retrieveProperString(retrieveString: userID))
            fetchRequest.predicate = predicate
            
            let sortDescriptor = NSSortDescriptor(key: "imageID", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
        
            if let resultArray = try? context.fetch(fetchRequest){
                for resultObject in resultArray {
                    if let nsmanagedObject = resultObject as? NSManagedObject {
                        if let woundImageModel = try? returnWoundImageModel(nsmanagedObject: nsmanagedObject){
                            woundImageList.append(woundImageModel)
                        }
                    }
                }
            }
        }
        return woundImageList
    }
    
    open class func retrieveCountOfWoundImageUploadedOnServerAndLocallyExpired(isUploadedOnServer:Int, currentDateTimeInTimestamp:Int64) throws -> Int {
        var totalRecord:Int = 0
        
        if currentDateTimeInTimestamp > 0 && isUploadedOnServer == 1 {
            let context = retrieveManagedObjectContext()
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: DatabaseTableName.medlineWoundImageTable)
            
            let firstPredicate = NSPredicate(format: "isUploadedOnServer == %d", isUploadedOnServer)
            let secondPredicate = NSPredicate(format: "imageStayInLocalUpToDateTime > %d", 0)
            let thirdPredicate = NSPredicate(format: "imageStayInLocalUpToDateTime <= %ld", currentDateTimeInTimestamp)
            let predicate = NSCompoundPredicate.init(type: .and, subpredicates: [firstPredicate,secondPredicate,thirdPredicate])
            
            fetchRequest.predicate = predicate
            
            if let resultCount = try? context.count(for:fetchRequest){
                totalRecord = resultCount
            }
        }
        return totalRecord
    }
    
    open class func deleteWoundImageUploadedOnServerAndLocallyExpired(isUploadedOnServer:Int, currentDateTimeInTimestamp:Int64) -> Void {
        if currentDateTimeInTimestamp > 0 && isUploadedOnServer == 1 {
            let context = retrieveManagedObjectContext()
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: DatabaseTableName.medlineWoundImageTable)
            
            let firstPredicate = NSPredicate(format: "isUploadedOnServer == %d", isUploadedOnServer)
            let secondPredicate = NSPredicate(format: "imageStayInLocalUpToDateTime > %d", 0)
            let thirdPredicate = NSPredicate(format: "imageStayInLocalUpToDateTime <= %ld", currentDateTimeInTimestamp)
            let predicate = NSCompoundPredicate.init(type: .and, subpredicates: [firstPredicate,secondPredicate,thirdPredicate])
            
            fetchRequest.predicate = predicate

            do{
                let result = try context.fetch(fetchRequest)
                for resultObject in result {
                    context.delete(resultObject as! NSManagedObject)
                    saveInformation(nsmanagedObjectContext: context)
                }
            }catch{
                
            }
        }
    }
    
    open class func deleteWoundImageByCaptureDateTime(imageCaptureDateTime:Int64) -> Void {
        if imageCaptureDateTime > 0 {
            let context = retrieveManagedObjectContext()
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: DatabaseTableName.medlineWoundImageTable)
            let predicate = NSPredicate(format: "imageCaptureDateTime == %ld",imageCaptureDateTime)
            fetchRequest.predicate = predicate
            do{
                let result = try context.fetch(fetchRequest)
                for resultObject in result {
                    context.delete(resultObject as! NSManagedObject)
                    saveInformation(nsmanagedObjectContext: context)
                }
            }catch{
                
            }
        }
    }
    
    open class func deleteWoundImageByUserID(userID:String?) -> Void {
        if userID != nil {
            let context = retrieveManagedObjectContext()
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: DatabaseTableName.medlineWoundImageTable)
            let predicate = NSPredicate(format: "userID == %@",retrieveProperString(retrieveString: userID))
            fetchRequest.predicate = predicate
            do{
                let result = try context.fetch(fetchRequest)
                for resultObject in result {
                    context.delete(resultObject as! NSManagedObject)
                    saveInformation(nsmanagedObjectContext: context)
                }
            }catch{
                
            }
        }
    }
    
    open class func updateWoundImageByImageID(object: MedlineWoundImageModel?) -> Void {
        if object != nil {
            let context = retrieveManagedObjectContext()
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: DatabaseTableName.medlineWoundImageTable)
            
            let predicate = NSPredicate(format: "imageID == %d", object?.imageID ?? 0)
            fetchRequest.predicate = predicate
            
            if let resultArray = try? context.fetch(fetchRequest){
                for resultObject in resultArray {
                    if let nsmanagedObject = resultObject as? NSManagedObject {
                        nsmanagedObject.setValue(object?.isUploadedOnServer, forKey: "isUploadedOnServer")
                        nsmanagedObject.setValue(object?.imageCaptureDateTime, forKey: "imageCaptureDateTime")
                        nsmanagedObject.setValue(object?.imageID, forKey: "imageID")
                        nsmanagedObject.setValue(object?.imageStayInLocalUpToDateTime, forKey: "imageStayInLocalUpToDateTime")
                        nsmanagedObject.setValue(object?.imageUploadedOnServerDateTime, forKey: "imageUploadedOnServerDateTime")
                        
                        nsmanagedObject.setValue(retrieveProperString(retrieveString:object?.userID), forKey: "userID")
                        nsmanagedObject.setValue(object?.woundImage, forKey: "woundImage")
                        
                        saveInformation(nsmanagedObjectContext: context)
                    }
                }
            }
        }
    }
    
    open class func retrieveUserHavePin(userID:Int64) throws -> Int {
        var totalRecord:Int = 0
        
        if userID > 0 {
            let context = retrieveManagedObjectContext()
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: DatabaseTableName.medlineWoundImageTable)
            
            let firstPredicate = NSPredicate(format: "isUserHavePinSet == %d", 1)
            let secondPredicate = NSPredicate(format: "isUserHavePinSet == %ld", userID)
            let predicate = NSCompoundPredicate.init(type: .and, subpredicates: [firstPredicate,secondPredicate])
            
            fetchRequest.predicate = predicate
            
            if let resultCount = try? context.count(for:fetchRequest){
                totalRecord = resultCount
            }
        }
        return totalRecord
    }
 */
}
