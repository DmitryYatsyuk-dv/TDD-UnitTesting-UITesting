//
//  NewTaskViewControllerTests.swift
//  ToDoListWithCoverageTests
//
//  Created by Lucky on 30.09.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoListWithCoverage


class NewTaskViewControllerTests: XCTestCase {
    
    var sut: NewTaskViewController!
    var placemark: MockCLPlacemark!
        
    override func setUpWithError() throws {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {}

    func testHasTitleTextField() {
        XCTAssertTrue(sut.titleTextField.isDescendant(of: sut.view))
    }
    
    func testHasLocationTextField() {
        XCTAssertTrue(sut.locationTextField.isDescendant(of: sut.view))
    }
    
    func testHasDateTextField() {
        XCTAssertTrue(sut.dateTextField.isDescendant(of: sut.view))
    }
    
    func testHasAddressTextField() {
        XCTAssertTrue(sut.addressTextField.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionTextField() {
        XCTAssertTrue(sut.descriptionTextField.isDescendant(of: sut.view))
    }
    
    func testHasButtonSave() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testHasButton() {
        XCTAssertTrue(sut.cancelButton.isDescendant(of: sut.view))
    }
    
    func testSaveUsesGeocoderToConvertCoordinatefromAddress() {
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "9/30/20")
        
        sut.titleTextField.text = "Foo"
        sut.locationTextField.text = "Bar"
        sut.dateTextField.text = "9/30/20"
        sut.addressTextField.text = "Moscow"
        sut.descriptionTextField.text = "Baz"
        
        sut.taskManager = TaskManager()
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        sut.save()
        
        let coordinate = CLLocationCoordinate2D(latitude: 55.7615902, longitude: 37.60946)
        let location = Location(name: "Bar", coordinate: coordinate)
        let generatedTask = Task(title: "Foo", description: "Baz", date: date, location: location)
        
        placemark = MockCLPlacemark()
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let task = sut.taskManager.task(at: 0)
        
        XCTAssertEqual(task, generatedTask)
    }
    
    func testSaveButtonHasSaveMethod() {
        let saveButton = sut.saveButton
        
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        XCTAssertTrue(actions.contains("save"))
    }
    
    func testGeocoderFetchesCorrectCoordinate() {
        let geocoderAnswer = expectation(description: "Geocoder answer")
        let addressString = "Moscow"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemark, error) in
            
            let placemark = placemark?.first
            let location = placemark?.location
            
            guard
                let latitude = location?.coordinate.latitude,
                let longitude = location?.coordinate.longitude else {
                    XCTFail()
                    return
            }
            XCTAssertEqual(latitude, 55.7615902)
            XCTAssertEqual(longitude, 37.60946)
            geocoderAnswer.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testSaveDissmisesNewTaskViewController() {
        // given
        let mockNewTaskViewController = MockNewTaskViewController()
        mockNewTaskViewController.titleTextField = UITextField()
        mockNewTaskViewController.titleTextField.text = "Foo"
        mockNewTaskViewController.descriptionTextField = UITextField()
        mockNewTaskViewController.descriptionTextField.text = "Bar"
        mockNewTaskViewController.locationTextField = UITextField()
        mockNewTaskViewController.locationTextField.text = "Baz"
        mockNewTaskViewController.dateTextField = UITextField()
        mockNewTaskViewController.dateTextField.text = "09.30.20"
        mockNewTaskViewController.addressTextField = UITextField()
        mockNewTaskViewController.addressTextField.text = "Moscow"
        
        // when
        mockNewTaskViewController.save()
        
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            XCTAssertTrue(mockNewTaskViewController.isDissmised)
        }
    }
}

//MARK: Extension
extension NewTaskViewControllerTests {
    
    class MockCLGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    class MockCLPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D!
        
        override var location: CLLocation? {
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
    }
}

extension NewTaskViewControllerTests {
    
    class MockNewTaskViewController: NewTaskViewController {
        var isDissmised = false
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            isDissmised = true
        }
    }
    
}
