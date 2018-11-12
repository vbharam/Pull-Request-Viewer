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
    let currBranch: String?
    let baseBranch: String?

    public init(fromDictionary dictionary: [String : AnyObject]) {
        self.title = dictionary["title"] as? String
        self.number = dictionary["number"] as? Int
        self.url = dictionary["url"] as? String

        if let user = dictionary["user"] as? [String : AnyObject] {
            self.owner = user["login"] as? String
        } else {
            self.owner = "unknown"
        }

        if let head = dictionary["head"] as? [String : AnyObject] {
            self.currBranch = head["label"] as? String
        } else {
            self.currBranch = ""
        }

        if let base = dictionary["base"] as? [String : AnyObject] {
            self.baseBranch = base["label"] as? String
        } else {
            self.baseBranch = ""
        }
    }
}
