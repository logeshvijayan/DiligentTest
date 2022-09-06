//
//  DrawingPadProtocols.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-01.
//

import UIKit

//MARK: - Presenter Protcol, Presenter methods for view to access
protocol ViewToPresenterProtocol: AnyObject{
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    var imageToPresent: Image? {get set}
    var colourParameter: ColorParameter? { get set }
    func changeColour(index: Int)
    func saveDrawingToDataBase(with imageData: ImageData,with controller: UINavigationController)
    func updatetheDrawing(with imageData: ImageData,with controller: UINavigationController)
}

//MARK: - View Functions,Function methods for presenter to update the view
protocol PresenterToViewProtocol: AnyObject {
    func showError()
    func ImageSavedSuccessfully()
}

//MARK: - Router methods,Function methods for presenter to communicate to the router.
protocol PresenterToRouterProtocol: AnyObject {
    func pushToListScreen(navigationConroller:UINavigationController)
}

//MARK: - Interactor methods,Function methods for presenter to communicate to the Interactor.
protocol PresenterToInteractorProtocol: AnyObject {
    var presenter:InteractorToPresenterProtocol? {get set}
    func saveDrawing(with image: ImageData)
    func updateDrawing(with image: ImageData)
}

//MARK: - Presenter methods,Function methods for interactor to communicate to the presenter.
protocol InteractorToPresenterProtocol: AnyObject {
    func imagesaveFailed()
    func imageSaveSuccess()
}

//MARK: - Paint Brush paramters
protocol PaintBrushProtocol: AnyObject {
    var startingPoint: CGPoint { get set }
    var color: UIColor { get set }
    var brushWidth: CGFloat { get set }
    var opacity: CGFloat { get set }
    func drawLine(from fromPoint: CGPoint?, to toPoint: CGPoint?)
}
