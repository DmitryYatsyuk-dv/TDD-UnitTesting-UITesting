//
//  ViewController.swift
//  ToDoListWithCoverage
//
//  Created by Lucky on 04.09.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
    
    //MARK: @IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider : DataProvider!
    
    //MARK: VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let taskManager = TaskManager()
        dataProvider.taskManager = taskManager

    }
    
    //MARK: @IBActions
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            viewController.taskManager = self.dataProvider.taskManager
            present(viewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
}


