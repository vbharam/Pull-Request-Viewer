//
//  ViewController.swift
//  ProcoreTech
//
//  Created by Vishal Bharam on 11/11/18.
//  Copyright © 2018 Vishal Bharam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var dataManager: DataFetchManagerProtocol!
    var pullRequests: [PullRequest] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager = DataFetchManager()
        tableView.delegate = self
        tableView.dataSource = self
        // Get initial data:
        self.fetchData()
    }

    func fetchData() {
        dataManager.fetchAllPullRequest(completion: { (data) in
            for entry in data {
                let pr = PullRequest(fromDictionary: entry)
                self.pullRequests.append(pr)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PullRequestDetailVC" {
            if let detailsVC = segue.destination as? PullRequestDetailViewController {
                if let pullRequest = sender as? PullRequest {
                    detailsVC.pullRequest = pullRequest
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequests.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pullRequestCell") as? PullRequestTableViewCell {
            let prData = pullRequests[indexPath.row]
            cell.updateUI(with: prData)
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PullRequestDetailVC", sender: pullRequests[indexPath.row])
    }
}

