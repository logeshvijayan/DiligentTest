//
//  PaintingListViewController.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-02.
//

import UIKit

//MARK: - Class
class PainitingListViewController: UIViewController {
    
    var presenter: ViewToPresenterListProtocol?
   
    //MARK: - Outlet Variables
    @IBOutlet var listTableView: UITableView!
    
    //MARK: - View Loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewdidLoaded()
    }
        
    //MARK: - View Functionalities
    func registerTableView() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(PaintingListTableViewCell.self)
    }
    
    func setupNavigationBar() {
        self.title = "Drawing List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addImage))
    }
    
    @objc func addImage() {
        if let navigationController =  navigationController {
            presenter?.pushDrawingPad(inside: navigationController,
                                      imageId:nil)
        }
    }
}

//MARK: - Table View Delegate Functions
extension PainitingListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.images?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PaintingListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        if let image = presenter?.images?[safe: indexPath.row] {
            cell.setupCell(with: image)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let navigationController =  navigationController,
           let imageId = presenter?.images?[safe:indexPath.row]?.id  {
            presenter?.pushDrawingPad(inside: navigationController,
                                      imageId: imageId)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let imageId = presenter?.images?[safe:indexPath.row]?.id else { return }
            presenter?.deletePainting(with: imageId)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - Presenter to View Function
extension PainitingListViewController:PresenterToViewListProtocol {
   
    
    func onPaintingFetchResponseSuccess() {
        listTableView.reloadData()
    }
    
    func onFetchPainitngResponseFailed(error: String) {
        showAlertWithCompletion(title: "We hit a snag", message: "Something went wrong,We are trying to fix it..Come back Later", okTitle: "Ok", cancelTitle: nil, completionBlock: { okPressed in
            print("Ok Pressed")
        })
    }
}
