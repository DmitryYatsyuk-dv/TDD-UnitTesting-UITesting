//
//  ToDoListWithCoverageTests.swift
//  ToDoListWithCoverageTests
//
//  Created by Lucky on 04.09.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import XCTest
@testable import ToDoListWithCoverage

class ToDoListWithCoverageTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testInitialViewControllerIsTaskListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers.first as! TaskListViewController
        
        XCTAssertTrue(rootViewController is TaskListViewController)
    }

}
