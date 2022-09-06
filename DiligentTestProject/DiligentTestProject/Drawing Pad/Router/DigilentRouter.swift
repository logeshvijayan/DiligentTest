//
//  DigilentRouter.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-01.
//

import UIKit

//MARK: - Class 
class DrawingPadRouter:PresenterToRouterProtocol{
    
    //MARK: - Function to create Drawing pad view and create connection among them 
    static func createModule(with imageData: Image?) -> DrawingPadViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "DrawingPadViewController") as! DrawingPadViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = DrawingPadPresenter()
        let interactor: PresenterToInteractorProtocol = DrawingPadInteractor()
        let router:PresenterToRouterProtocol = DrawingPadRouter()
        
        // Instance function to establish all the necessary connection
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        presenter.imageToPresent = imageData
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    //MARK: - Function to pop back to root view controller(PaintingList ViewController)
    func pushToListScreen(navigationConroller: UINavigationController) {
       navigationConroller.popToRootViewController(animated: true)
    }
}

