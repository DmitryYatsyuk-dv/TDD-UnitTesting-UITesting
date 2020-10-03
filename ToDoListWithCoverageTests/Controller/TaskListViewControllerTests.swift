//
//  TaskListViewControllerTests.swift
//  ToDoListWithCoverageTests
//
//  Created by Lucky on 09.09.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import XCTest
@testable import ToDoListWithCoverage

class TaskListViewControllerTests: XCTestCase {
    
    var sut: TaskListViewController!
    
    override func setUpWithError() throws {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        
        sut = vc as? TaskListViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {}
    
    func testwhenViewIsLoadedTableViewNotNil() {
//        let sut = TaskListViewController()
//        sut.loadViewIfNeeded() // (_ = sut.view)
        
        XCTAssertNotNil(sut.tableView)
    }
    
    func testWhenViewIsLoadedDataProviderIsNotNil() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    // Ancillary test
    func testWhenViewIsLoadedTableViewDelegateEqualsTableViewDataSource() {
        XCTAssertEqual(
            sut.tableView.delegate as? DataProvider,
            sut.tableView.dataSource as? DataProvider)
    }
    
    func testTaskListViewControllerHasAddBarButtonWithSelfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListViewController, sut)
    }
    
    func presentingNewTaskViewController() -> NewTaskViewController {
        guard
                   let newTaskButton = sut.navigationItem.rightBarButtonItem,
                   let action = newTaskButton.action else {
                   return NewTaskViewController()
               }
               // Do sut as our rootViewControlle
               UIApplication.shared.keyWindow?.rootViewController = sut
               sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
               
        let newTaskViewController = sut.presentedViewController as! NewTaskViewController
        return newTaskViewController
    }
    
    func testAddNewTaskPresentNewTaskViewController() {
        let newTaskViewController = presentingNewTaskViewController()
        XCTAssertNotNil(newTaskViewController.cancelButton)
    }
    
    func testSharesSameTaskManagerWithNewTaskViewController() {
        let newTaskViewController = presentingNewTaskViewController()
//        XCTAssertNotNil(sut.dataProvider.taskManager)
        XCTAssertTrue(newTaskViewController.taskManager === sut.dataProvider.taskManager)
    }
    
    func testWhenViewAppearedTableViewReloaded() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
    }
    
    func testTappingCellSendsNotification() {
        let task = Task(title: "Foo")
        sut.dataProvider.taskManager?.add(task: task)
        expectation(forNotification: NSNotification.Name("DidSelectRowNotification"), object: nil) { notification -> Bool in
            
            guard let taskFromNotification = notification.userInfo?["task"] as? Task else {
                return false
            }
            return task == taskFromNotification
        }
        
        let tableView = sut.tableView
        tableView?.delegate?.tableView?(tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 1, handler: nil)
    }
}

extension TaskListViewControllerTests {
    class MockTableView: UITableView {
        var isReloaded = false
        override func reloadData() {
            super.reloadData()
            isReloaded = true
        }
    }
}

