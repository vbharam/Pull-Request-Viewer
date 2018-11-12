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
    func fetchPRDetailOf(number: Int, completion: @escaping ([String: AnyObject]) -> Void)
}

public class DataFetchManager: DataFetchManagerProtocol {
    var dataManager: JSONService!

    public init() {
        dataManager = JSONService()
    }

    func fetchAllPullRequest(completion: @escaping ([[String : AnyObject]]) -> Void) {
        dataManager.getData(url: CONSTANTS.PULL_REQUESTS_API) { (data) in
            guard let validData = data else {
                completion([[:]])
                return
            }
            completion(validData)
        }
    }

    func fetchPRDetailOf(number: Int, completion: @escaping ([String : AnyObject]) -> Void) {
        let detailUrl = CONSTANTS.PULL_REQUESTS_API + "/\(number)"
    }
}
