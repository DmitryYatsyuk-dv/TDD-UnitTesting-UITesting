//
//  NewTaskViewController.swift
//  ToDoListWithCoverage
//
//  Created by Lucky on 30.09.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit
import CoreLocation

class NewTaskViewController: UIViewController {
    
    var taskManager: TaskManager!
    var geocoder = CLGeocoder()

    //MARK: IBOutlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBAction func save() {
        guard let titleString = titleTextField.text else { return }
        guard let locationString = locationTextField.text else { return }
        let date = dateFormatter.date(from: dateTextField.text!)
        let descriptionString = descriptionTextField.text
        guard let addressString = addressTextField.text else { return }
        geocoder.geocodeAddressString(addressString) { [unowned self] (placemarks, error) in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            let location = Location(name: locationString, coordinate: coordinate)
            
            let task = Task(title: titleString, description: descriptionString, date: date, location: location)
            self.taskManager.add(task: task)
    }
}
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
}
