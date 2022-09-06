//
//  ViewController.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-08-31.
//

import UIKit
import Combine

//MARK: Class
class DrawingPadViewController: UIViewController,PaintBrushProtocol {
    
    //MARK: - Oulet Variables
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var colorChangeControl: UISegmentedControl!
    var timer = Timer()
    @Published var touchCoordinates : [CGPoint] = []
    
    
    var swipeEnded = false
    var cancellable :AnyCancellable?
    
    //MARK: - Protocol Variables
    var presenter: ViewToPresenterProtocol?
    var startingPoint = CGPoint.zero
    var color = UIColor.red
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    
    //MARK: - View did load funciton
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationbar()
        loadTheCanvas()
    }
    
    //TODO: - Update the function
    @IBAction func brushParameterChanged(_ sender: Any) {
        presenter?.changeColour(index: colorChangeControl.selectedSegmentIndex)
        guard let colorParameter = presenter?.colourParameter else { return }
        color = colorParameter.color
    }
    
    //MARK: - Function to draw line
    func drawLine(from fromPoint: CGPoint?, to toPoint: CGPoint?) {
        guard let fromPoint = fromPoint,let toPoint = toPoint else {
            return
        }
        
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: view.bounds)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        context.strokePath()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        
        UIGraphicsEndImageContext()
    }
    
    //MARK: - Configure Navigation Bar
    func configureNavigationbar() {
        self.title = "Drawing Pad"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveImage))
    }
    
    //MARK: - Load the canvas with drawn image
    func loadTheCanvas() {
        if let image = presenter?.imageToPresent,let drawing = image.drawing {
            mainImageView.image = UIImage(data: drawing)
            title = image.name
        }
    }
    
    @objc func startDrawing() {
        cancellable = $touchCoordinates
            .sink(receiveValue: { [weak self]  values in
                var previousValue: CGPoint? = self?.startingPoint
                for value in values where self?.swipeEnded == true {
                    self?.drawLine(from: previousValue, to: value)
                    previousValue = value
                }
                if previousValue == self?.touchCoordinates.last {
                    self?.touchCoordinates = []
                    self?.mergeImage()
                }
            })
    }
    
    private func runTimer() {
        self.timer = Timer.scheduledTimer(timeInterval:  presenter?.colourParameter?.timeDelay ?? 1, target: self, selector: #selector(self.startDrawing), userInfo: nil, repeats: false)
    }
    
    func mergeImage() {
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tempImageView.image = nil
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

extension DrawingPadViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        startingPoint = touch.location(in: view)
        swipeEnded = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: view)
        self.touchCoordinates.append(currentPoint)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        runTimer()
        swipeEnded = true
    }
}

extension DrawingPadViewController:PresenterToViewProtocol {
    
    func ImageSavedSuccessfully() {
        //save Success
    }
    
    func showError() {
        //Save Failed
    }
}

extension DrawingPadViewController {
    
    @objc func saveImage() {
        let ac = UIAlertController(title: "Hurray....", message: "You have created an amazing art,Let's name it.Shall We?", preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?.first?.text = presenter?.imageToPresent?.name
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            guard let image = self.mainImageView.image?.pngData(),let navigationController = self.navigationController else { return }
            if let imageId = self.presenter?.imageToPresent?.id {
                let imageData = ImageData(id: imageId, name: ac.textFields?.first?.text, drawing: image)
                self.presenter?.updatetheDrawing(with: imageData, with: navigationController)
            } else  {
                let answer = ac.textFields?.first?.text
                let imageData = ImageData(id: UUID().uuidString, name: answer, drawing: image)
                self.presenter?.saveDrawingToDataBase(with: imageData, with: self.navigationController! )
            }
        }
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
}

