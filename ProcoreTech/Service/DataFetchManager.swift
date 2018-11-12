//
//  DataFetchManager.swift
//  ProcoreTech
//
//  Created by Vishal Bharam on 11/11/18.
//  Copyright © 2018 Vishal Bharam. All rights reserved.
//

import Foundation

protocol DataFetchManagerProtocol {
    func fetchAllPullRequest(completion: @escaping ([[String: AnyObject]]) -> Void)
    func compareDiffBetween(base: String, current: String, completion: @escaping ([[String: AnyObject]]) -> Void)
}

public class DataFetchManager: DataFetchManagerProtocol {
    var dataManager: JSONService!

    public init() {
        dataManager = JSONService()
    }

    func fetchAllPullRequest(completion: @escaping ([[String : AnyObject]]) -> Void) {
        dataManager.getData(url: CONSTANTS.PULL_REQUESTS_API) { (data) in
            guard case let validData as [[String: AnyObject]] = data else {
                completion([[:]])
                return
            }
            completion(validData)
        }
    }

    func compareDiffBetween(base: String, current: String, completion: @escaping ([[String : AnyObject]]) -> Void) {
        let compareUrl = CONSTANTS.COMPARE_REQUESTS_API + "/\(base)...\(current)"
        dataManager.getData(url: compareUrl) { (data) in
            guard case let validData as [String: AnyObject] = data else {
                completion([[:]])
                return
            }

            if let files = validData["files"] as? [[String: AnyObject]] {
                completion(files)
                return
            }

            completion([[:]])
        }
    }
}
