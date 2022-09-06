//
//  UITableView+Extension.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-02.
//

import UIKit

//MARK:  Dequeue reusable function
extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
    
    func register<T:UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
            let bundle = Bundle(for: T.self)
            let nib = UINib(nibName: T.nibName, bundle: bundle)
            self.register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
        }

}

protocol ReusableView: AnyObject {
          static var defaultReuseIdentifier: String { get }
      }

      protocol NibLoadableView: AnyObject {
          static var nibName: String { get }
      }

      extension ReusableView where Self: UIView {
          static var defaultReuseIdentifier: String {
              return String(describing: Self.self)
          }
      }
      extension NibLoadableView where Self: UIView {
          static var nibName: String {
              return String(describing: Self.self)
          }
      }
