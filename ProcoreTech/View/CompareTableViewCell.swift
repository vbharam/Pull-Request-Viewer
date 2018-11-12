//
//  CompareCollectionViewCell.swift
//  ProcoreTech
//
//  Created by Vishal Bharam on 11/11/18.
//  Copyright © 2018 Vishal Bharam. All rights reserved.
//

import UIKit

class CompareTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var baseFile: UITextView!
    @IBOutlet weak var currFile: UITextView!

    func updateUI(with file: FileChange) {
        fileName.text = file.filename
        if file.filename.contains("pbxproj") {
            baseFile.text = "..."
            currFile.text = "..."
        } else {
            currFile.text = file.patch
        }
    }
}
