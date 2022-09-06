//
//  UIViewController+Extension.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-02.
//

import UIKit

extension UIViewController {
    
    /// common Alert view to be used across different view controllers
    func showAlertWithCompletion(title: String, message: String,okTitle: String,cancelTitle: String?,completionBlock: @escaping (_ okPressed:Bool)->()){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { (ok) in
            completionBlock(true)
        }
        alertController.addAction(okAction)
        if let cancelTitle = cancelTitle{
            let cancelOption = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (axn) in
                completionBlock(false)
                
            })
            alertController.addAction(cancelOption)
        }
        self.present(alertController, animated: true, completion: nil)
        
        
    }
}
