//
//  GmailResponse.swift
//  Webscrape Tutorial
//
//  Created by Will Ducharme on 6/16/18.
//  Copyright © 2018 DuCharme. All rights reserved.
//

import Foundation
import SwiftSoup

enum HTMLError: Error {
    case badInnerHTML
}



struct GmailResponse {
    
    let emails: [Email]
    
    init(_ innerHTML: Any?) throws {
        guard let htmlString = innerHTML as? String else { throw
            HTMLError.badInnerHTML }
        
        let doc = try SwiftSoup.parse(htmlString)
        let authorList = try doc.getElementsByClass("Mg Jl").array()
        let titleList = try doc.getElementsByClass(" Mg Kl").array()
        
        var emails = [Email]()
        for i in 0..<titleList.count
        {
            let author = try authorList[i].text()
            let title = try titleList[i].text()
            
            print(author)
            print(title)
            print("")
            
            let email = Email(author: author, title: title)
            emails.append(email)
        }
        self.emails = emails
    }
}

