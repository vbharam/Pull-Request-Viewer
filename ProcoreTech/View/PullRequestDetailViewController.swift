//
//  PullRequestDetailViewController.swift
//  ProcoreTech
//
//  Created by Vishal Bharam on 11/11/18.
//  Copyright © 2018 Vishal Bharam. All rights reserved.
//

import UIKit

class PullRequestDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var pullRequest: PullRequest!
    var dataManager: DataFetchManagerProtocol!
    var changedFilesData: [FileChange] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "#\(pullRequest.number ?? 0)"
        dataManager = DataFetchManager()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300.0

        // Get initial data:
        self.fetchDiffData { (files) in
            self.changedFilesData = files
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func fetchDiffData(completion: @escaping ([FileChange]) -> Void) {
        if let baseBranch = pullRequest.baseBranch, let currBranch = pullRequest.currBranch {
            dataManager.compareDiffBetween(base: baseBranch, current: currBranch) { (filesData) in
                let files = filesData.map { FileChange(fromDictionary: $0) }
                completion(files)
            }
        }
    }
}


extension PullRequestDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changedFilesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pullRequestDetailCell") as? CompareTableViewCell {
            let diffData = changedFilesData[indexPath.row]
            cell.updateUI(with: diffData)
            return cell
        }

        return UITableViewCell()
    }
}
