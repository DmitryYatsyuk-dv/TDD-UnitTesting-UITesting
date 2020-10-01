//
//  String + Extensions.swift
//  ToDoListWithCoverage
//
//  Created by Lucky on 01.10.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation

extension String {
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "~!@#$%^&*()-+=[]\\}{,./?><").inverted
        guard
            let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters ) else {
                fatalError()
        }
        return encodedString
    }
}
