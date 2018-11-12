//
//  ViewController.swift
//  ProcoreTech
//
//  Created by Vishal Bharam on 11/11/18.
//  Copyright © 2018 Vishal Bharam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataManager: JSONService!
    var pullRequests: [PullRequest] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager = JSONService()

        // Get initial data:
        self.fetchData()

    }

    func fetchData() {
        dataManager.getData(url: CONSTANTS.GET_ALL_PULL_REQUESTS) { (data) in
            guard let data = data else { return }
            for entry in data {
                let pr = PullRequest(fromDictionary: entry)
                self.pullRequests.append(pr)
            }
        }
    }
}

