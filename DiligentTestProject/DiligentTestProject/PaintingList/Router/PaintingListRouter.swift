//
//  PaintingListRouter.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-02.
//


import UIKit

//MARK: - Router Class
class PaintingListRouter:PresenterToRouterListProtocol{

    //MARK: - Function to create to ViewController and establish connection among all modules.
    static func createPaintingListModule() -> PainitingListViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "PainitingListViewController") as! PainitingListViewController
        
        let presenter: ViewToPresenterListProtocol & InteractorToPresenterListProtocol = PainitingListPresenter()
        let interactor: PresenterToInteractorListProtocol = PainitingListInteractor()
        let router:PresenterToRouterListProtocol = PaintingListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    //MARK: - Function to load the Drawing pad from list screen
    func pushToDrawingPadScreen(navigationConroller: UINavigationController, with imageData: Image?) {
        let ViewController = DrawingPadRouter.createModule(with: imageData)
        navigationConroller.pushViewController(ViewController, animated: true)
    }
    
}
