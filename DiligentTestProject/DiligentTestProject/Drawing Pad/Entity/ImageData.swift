//
//  ImageData.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-02.
//

import UIKit

//MARK: - Stuct to hold Image Data
struct ImageData: Equatable {
    var id: String
    var name: String?
    var drawing: Data
}

//MARK: - Enum to hold color parameters
enum ColorParameter: Int {
    case Red = 0
    case Blue
    case Green
    case Eraser
    
    var color: UIColor  {
        switch self {
        case .Red:
            return .red
        case .Blue:
            return .blue
        case .Green:
            return .green
        case .Eraser:
            return .white
        }
    }
    
    var timeDelay: TimeInterval {
        switch self {
        case .Red:
            return 2
        case .Blue:
            return 3
        case .Green:
            return 5
        case .Eraser:
            return 2
        }
    }
}
