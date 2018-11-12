//
//  PullRequestDetailViewController.swift
//  ProcoreTech
//
//  Created by Vishal Bharam on 11/11/18.
//  Copyright © 2018 Vishal Bharam. All rights reserved.
//

import UIKit

class PullRequestDetailViewController: UIViewController {
    var pullRequest: PullRequest!
    var dataManager: DataFetchManagerProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "#\(pullRequest.number ?? 0)"
        dataManager = DataFetchManager()

        // Get initial data:
        self.fetchCommitData()
    }

    func fetchCommitData() {
        
    }
}
