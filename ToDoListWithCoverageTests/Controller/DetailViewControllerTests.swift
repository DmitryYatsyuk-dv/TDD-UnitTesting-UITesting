//
//  DetailViewControllerTests.swift
//  ToDoListWithCoverageTests
//
//  Created by Lucky on 24.09.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoListWithCoverage

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!

    override func setUpWithError() throws {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {}
    
    func testHasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }
    
    func testHasDateLabel() {
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    func testHasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    func testHasMapView() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    func setupTaskAndAppearanceTransition() {
        let coordinate = CLLocationCoordinate2D(latitude: 55.79857148, longitude: 37.61078901)
        let location = Location(name: "Boo", coordinate: coordinate)
        let date = Date(timeIntervalSince1970: 1601424000)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        sut.task = task
        
        // We simulate the work of methods: ViewWillAppear, ViewDidAppear.
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }
    
    func testSettingTaskSetsTitleLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    
    func testSettingTaskSetsDescriptionLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    func testSettingTaskSetsLocationLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.locationLabel.text, "Boo")
    }
    
    func testSettingTaskSetsDateLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.dateLabel.text, "9/30/20")
    }
    
    func testSettingTaskSetsMapView() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude,
                       55.79857148,
                       accuracy: 0.001)
        
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude,
                       37.61078901,
                       accuracy: 0.001)
    }
    
    
}
