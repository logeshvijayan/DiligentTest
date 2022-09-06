//
//  CoreDataManager.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-02.
//

import Foundation
import CoreData

public class NBPersistantContainer: NSPersistentContainer {}

//  MARK: - Class
/// Core data manager to handle everything related to core data
public class CoreDataManager {
    
    static let shareInstance = CoreDataManager()
    
    //  MARK: - Properties
    private lazy var persistentContainer: NSPersistentContainer? = {
        let container = NSPersistentContainer(name: "DrawingPadModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = self.persistentContainer!.viewContext
            
    //  MARK: - Life Cycle
    /// method to initialize core data manager
    public init() {}
    
    //  MARK: - Helper Methods
    private func handleFatalError(error:Error?) {
        if let nsError = error as NSError? {
            fatalError("Core Data failed \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func saveContext() {
        guard
            let context = self.persistentContainer?.viewContext,
            context.hasChanges
        else {
            return
        }
        do {
            try context.save()
        } catch {
            handleFatalError(error: error)
        }
    }
    
    func save(image: ImageData) {
        guard let context = persistentContainer?.viewContext,
              let entity = NSEntityDescription.entity(forEntityName: "Image", in: context),
                  findImage(with: image.id) == nil else {
                  updateImage(with: image)
                  return }
        let newImage = Image(entity: entity, insertInto: context)
        newImage.id = image.id
        newImage.name = image.name
        newImage.drawing = image.drawing
        saveContext()
    }
    
    func updateImage(with imageData: ImageData) {
        guard let image = findImage(with: imageData.id) else { return }
        image.id = imageData.id
        image.name = imageData.name
        image.drawing = imageData.drawing
        saveContext()
    }
    
    func fetchImages(with sortKey:String = "id") -> [Image]? {
            var images : [Image] = []
            let req: NSFetchRequest<Image> = Image.fetchRequest()
            let sortByIdentifier = NSSortDescriptor(key: sortKey, ascending: true)
            req.sortDescriptors = [sortByIdentifier]
            do {
                if let context = persistentContainer?.viewContext {
                    images = try context.fetch(req)
                }
            } catch {
                handleFatalError(error: error)
            }
            return images
        }
    
    func findImage(with id: String) -> Image? {
        let images = fetchImages()
        return images?.first { (image) -> Bool in
            image.id == id
        }
    }
    
    func deleteImageData(with image: Image?) {
        if let imageData = image {
            if let context = persistentContainer?.viewContext {
                context.delete(imageData)
                saveContext()
            }
        }
    }
    
     func deleteAllImages() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        let deleteAllRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            if let context = persistentContainer?.viewContext {
                try context.execute(deleteAllRequest)
            }
        }
        catch {
            handleFatalError(error: error)
        }
    }
}

