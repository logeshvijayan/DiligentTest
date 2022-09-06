//
//  PainitingListProtocol.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-02.
//

import UIKit

//MARK: - Presenter Protocol for View to access
protocol ViewToPresenterListProtocol: AnyObject {
    var view: PresenterToViewListProtocol? {get set}
    var interactor: PresenterToInteractorListProtocol? {get set}
    var router: PresenterToRouterListProtocol? {get set}
    func viewdidLoaded()
    var images: [Image]? { get set }
    
    func pushDrawingPad(inside navigationController: UINavigationController,imageId : String?)
    func deletePainting(with imageId: String)
}

//MARK: - View Protocol for Presenter to communicate back to the View
protocol PresenterToViewListProtocol: AnyObject {
    func onPaintingFetchResponseSuccess()
    func onFetchPainitngResponseFailed(error:String)
}

//MARK: - Router Protocols for Presenter to communicate back to the Router
protocol PresenterToRouterListProtocol: AnyObject {
    static func createPaintingListModule()->PainitingListViewController
    func pushToDrawingPadScreen(navigationConroller:UINavigationController,with imageData:Image?)

}

//MARK: - Interactor Protocols for Presenter to communicate to the Interactor
protocol PresenterToInteractorListProtocol: AnyObject{
    var presenter:InteractorToPresenterListProtocol? {get set}
    func fetchPaintingList()
    func deleteThePainiting(with imageData:Image?)
    
}

//MARK: - Preseter Protocols for Interactor to communicate to the Presenter
protocol InteractorToPresenterListProtocol: AnyObject{
    func paintingListFetchSuccess(images: [Image]?)
    func paintingListFetchFailed()
}
