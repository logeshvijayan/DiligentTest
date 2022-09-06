//
//  DrawingPadInteractor.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-02.
//

import Foundation

//MARK: - Class
class DrawingPadInteractor: PresenterToInteractorProtocol {

    //MARK: - Protocol method Variables
    var presenter: InteractorToPresenterProtocol?
    let manager = CoreDataManager.shareInstance
    
    //MARK: - Function to communicate to DataBase
    func saveDrawing(with image: ImageData) {
        manager.save(image: image)
        presenter?.imageSaveSuccess()
    }
    
    func updateDrawing(with image: ImageData) {
        manager.updateImage(with: image)
        presenter?.imageSaveSuccess()
    }
}
