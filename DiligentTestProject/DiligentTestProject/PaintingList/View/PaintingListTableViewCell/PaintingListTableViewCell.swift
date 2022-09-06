//
//  PaintingListTableViewCell.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-03.
//

import UIKit

//MARK: - Class
class PaintingListTableViewCell: UITableViewCell,ReusableView,NibLoadableView {

    //MARK: - outlet Variables
    @IBOutlet weak var drawnImage: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    
    //MARK: - Setup cell function
    func setupCell(with image:Image?) {
        guard let image = image else { return }
        drawnImage.image =  UIImage(data: image.drawing!)
        imageName.text = image.name
    }
}
