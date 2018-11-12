//
//  FileChange.swift
//  ProcoreTech
//
//  Created by Vishal Bharam on 11/11/18.
//  Copyright © 2018 Vishal Bharam. All rights reserved.
//

import Foundation

class FileChange {
    var filename: String?
    var status: String?
    var additions: Int?
    var deletions: Int?
    var changes: Int?
    var patch: String?

    public init(fromDictionary dictionary: [String : AnyObject]) {
        self.filename = dictionary["filename"] as? String
        self.status = dictionary["status"] as? String
        self.additions = dictionary["additions"] as? Int
        self.deletions = dictionary["deletions"] as? Int
        self.changes = dictionary["changes"] as? Int
        self.patch = dictionary["patch"] as? String
    }
}
