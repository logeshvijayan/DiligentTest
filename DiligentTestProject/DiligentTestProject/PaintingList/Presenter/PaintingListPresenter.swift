//
//  PaintingListPresenter.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-02.
//

import UIKit

//MARK: - Class
class PainitingListPresenter:ViewToPresenterListProtocol {
 
    //MARK: - Protocol Variables
    var interactor: PresenterToInteractorListProtocol?
    var router: PresenterToRouterListProtocol?
    var view: PresenterToViewListProtocol?
    var images: [Image]?
    
    //MARK: - Function to fetch data from core Data
    func viewdidLoaded() {
        interactor?.fetchPaintingList()
    }
}

//MARK: - Presenter to Interactor Functionality
extension PainitingListPresenter:InteractorToPresenterListProtocol {
    func paintingListFetchSuccess(images: [Image]?) {
        guard let images = images else {
            return
        }
        self.images = images
        view?.onPaintingFetchResponseSuccess()
    }

    func paintingListFetchFailed() {
        //communicates to the view for failure response
    }
}

//MARK: - Presenter to Router Functionality
extension PainitingListPresenter {
    func pushDrawingPad(inside navigationController: UINavigationController, imageId: String?) {
        let image = images?.first { $0.id == imageId }
        router?.pushToDrawingPadScreen(navigationConroller: navigationController, with: image)
    }
    
    func deletePainting(with imageId: String) {
        if  let index = images?.firstIndex(where: { $0.id == imageId }) {
            interactor?.deleteThePainiting(with: images?[index] )
            images?.remove(at: index)
        }
    }
}
