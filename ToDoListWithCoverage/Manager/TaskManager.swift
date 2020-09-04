//
//  TaskManager.swift
//  ToDoListWithCoverage
//
//  Created by Lucky on 04.09.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation


class TaskManager {
    
    var tasksCount = 0
    let doneTasksCount = 0
    
    func add(task: Task) {
        tasksCount += 1
    }
}
