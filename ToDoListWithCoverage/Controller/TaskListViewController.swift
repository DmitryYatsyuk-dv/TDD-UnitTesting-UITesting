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

    }
}


