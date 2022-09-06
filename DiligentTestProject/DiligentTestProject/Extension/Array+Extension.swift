//
//  Array+Extension.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-09-03.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
