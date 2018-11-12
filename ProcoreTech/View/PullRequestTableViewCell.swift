//
//  PullRequestTableViewCell.swift
//  ProcoreTech
//
//  Created by Vishal Bharam on 11/11/18.
//  Copyright © 2018 Vishal Bharam. All rights reserved.
//

import UIKit

class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var prTitle: UILabel!
    @IBOutlet weak var prMetadata: UILabel!

    func updateUI(with data: PullRequest) {
        prTitle.text = data.title
        let metaData = "#\(data.number ?? 0) opened by \(data.owner ?? "")"
        prMetadata.text = metaData
    }
}
