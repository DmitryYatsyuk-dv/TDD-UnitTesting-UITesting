//
//  APIClient.swift
//  ToDoListWithCoverage
//
//  Created by Lucky on 01.10.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL) -> URLSessionDataTask
    }

extension URLSession: URLSessionProtocol {}

class APIClient {
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func login(withName name: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        
        let allowedCharacters = CharacterSet.urlQueryAllowed
        /*
         URLFragmentAllowedCharacterSet  "#%<>[\]^`{|}
         URLHostAllowedCharacterSet      "#%/<>?@\^`{|}
         URLPasswordAllowedCharacterSet  "#%/:<>?@[\]^`{|}
         URLPathAllowedCharacterSet      "#%;<>?[\]^`{|}
         URLQueryAllowedCharacterSet     "#%<>[\]^`{|}
         URLUserAllowedCharacterSet      "#%/:<>?@[\]^`
         */
        guard
            //For Example: -> let name = name.percentEncoded, etc.
            let name = name.addingPercentEncoding(withAllowedCharacters: allowedCharacters),
            let password = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
                fatalError()
        }
        
        let query = "name=\(name)&password=\(password)"
        guard let url = URL(string: "https://todolistwithcoverage.com/login?\(query)") else {
            fatalError()
        }
        
        urlSession.dataTask(with: url)
        .resume()
    }
}

/*
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
*/
