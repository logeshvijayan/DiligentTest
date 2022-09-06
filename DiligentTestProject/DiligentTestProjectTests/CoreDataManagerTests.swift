//
//  CoreDataManagerTests.swift
//  DiligentTestProjectTests
//
//  Created by Logesh Vijayan on 2022-09-05.
//

import XCTest
@testable import DiligentTestProject

final class CoreDataManagerTests: XCTestCase {
    
    private var dataManager:CoreDataManager = CoreDataManager()
    
    override func setUp() {
        super.setUp()
        //TODO: - This will erase all the data inside DB,We need to create an mock core databse and data model for unit testing
        dataManager.deleteAllImages()
    }
    
    func test_fetchFunction() {
        let paintings = dataManager.fetchImages()
        XCTAssertEqual(paintings?.count, 0)
    }
    
    func test_AddDrawing() {
        let image = ImageData(id: "Test1", name: "Mock1", drawing: (UIImage(systemName: "bold")?.pngData()!) as! Data)
        dataManager.save(image: image)
        let fetchImage = dataManager.fetchImages()
        XCTAssertEqual(fetchImage?.count, 1)
    }
    
    func test_DeleteAll() {
        dataManager.deleteAllImages()
        let images = dataManager.fetchImages()
        XCTAssertEqual(images?.count, 0)
    }
    
    static var allTests = [
        ("testFetchFunction",test_fetchFunction ),
        ("testAddDrawing",test_AddDrawing),
        ("testDeleteAll",test_DeleteAll)
    ]
}

