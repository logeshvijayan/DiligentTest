//
//  PaintingListInteractor.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-02.
//

import Foundation

//MARK: - Class
class PainitingListInteractor:PresenterToInteractorListProtocol{
    var presenter: InteractorToPresenterListProtocol?
    
    //MARK: - Function to interact with the DataBase
    func fetchPaintingList() {
        let imagesData = CoreDataManager.shareInstance.fetchImages()
        presenter?.paintingListFetchSuccess(images: imagesData)
    }
    
    func deleteThePainiting(with imageData:Image?) {
        guard let imageData = imageData else {
            return
        }
        CoreDataManager.shareInstance.deleteImageData(with: imageData)
    }

}
