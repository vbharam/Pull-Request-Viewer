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
            currFile.attributedText = decorateText(with: file.patch!)
        }
    }

    func decorateText(with originalText: String) -> NSMutableAttributedString {
        let lines = originalText.split(separator: "\n")
        let diffData = NSMutableAttributedString()
        for line in lines {
            if line.contains("+") {
                let added = NSAttributedString(string: String(line + "\n"), attributes: [NSAttributedStringKey.backgroundColor : UIColor.green])
                diffData.append(added)
            } else if line.contains("-") {
                let removed = NSAttributedString(string: String(line + "\n"), attributes: [NSAttributedStringKey.backgroundColor : UIColor.red])
                diffData.append(removed)
            } else {
                diffData.append(NSAttributedString(string: String(line), attributes: [:]))
            }
        }
        return diffData
    }
}
