//
//  PullRequest.swift
//  ProcoreTech
//
//  Created by Vishal Bharam on 11/11/18.
//  Copyright © 2018 Vishal Bharam. All rights reserved.
//

import Foundation

public class PullRequest {

    let title: String?
    let number: Int?
    let url: String?
    let owner: String?
    let baseRef: String?

    init(title: String, number: Int, url: String, owner: String, baseRef: String) {
        self.title = title
        self.number = number
        self.url = url
        self.owner = owner
        self.baseRef = baseRef
    }

    public init(fromDictionary dictionary: [String : AnyObject]) {
        self.title = dictionary["title"] as? String
        self.number = dictionary["number"] as? Int
        self.url = dictionary["url"] as? String
        if let user = dictionary["user"] as? [String : AnyObject] {
            self.owner = user["login"] as? String
        } else {
            self.owner = "unknown"
        }
        if let base = dictionary["base"] as? [String : AnyObject] {
            self.baseRef = base["ref"] as? String
        } else {
            self.baseRef = "unknown"
        }
    }
}
