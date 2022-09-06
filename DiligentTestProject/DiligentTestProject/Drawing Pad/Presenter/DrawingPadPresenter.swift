//
//  DrawingPadPresenter.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-01.
//

import UIKit

//MARK: - Class
class DrawingPadPresenter: ViewToPresenterProtocol {

    //MARK: - Protocol Variables
    var colourParameter: ColorParameter?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    var view: PresenterToViewProtocol?
    var imageToPresent: Image? 
    
    //MARK: - Presenter functions
    func changeColour(index: Int)  {
        colourParameter = ColorParameter(rawValue: index)
    }
    
    func saveDrawingToDataBase(with imageData: ImageData, with controller: UINavigationController) {
          interactor?.saveDrawing(with: imageData)
          router?.pushToListScreen(navigationConroller: controller)
    }
    
    func updatetheDrawing(with imageData: ImageData, with controller: UINavigationController) {
        interactor?.updateDrawing(with: imageData)
        router?.pushToListScreen(navigationConroller: controller)
    }
    
}

//MARK: - Interactor function.
extension DrawingPadPresenter: InteractorToPresenterProtocol {
    func imagesaveFailed() {
        view?.showError()
    }
    
    func imageSaveSuccess() {
        view?.ImageSavedSuccessfully()
    }
}
