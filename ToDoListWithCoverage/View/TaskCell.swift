//
//  TaskCell.swift
//  ToDoListWithCoverage
//
//  Created by Lucky on 09.09.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var dateFormatter: DateFormatter {
        let dF = DateFormatter()
        dF.dateFormat = "dd.MM.yy"
        return dF
    }
    
    func configure(withTask task: Task, done: Bool = false) {
                
        if done {
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            dateLabel = nil
            locationLabel = nil
        } else {
            if let date = task.date {
                let dateString = dateFormatter.string(from: date)
                dateLabel.text = dateString
            }
            self.titleLabel.text = task.title
            self.locationLabel.text = task.location?.name
        }
    }
}
