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
            baseFile.attributedText = decorateText(with: file.patch!).base
            currFile.attributedText = decorateText(with: file.patch!).curr
        }
    }

    func decorateText(with originalText: String) -> (base: NSMutableAttributedString, curr: NSMutableAttributedString) {
        let lines = originalText.split(separator: "\n")
        let baseContent = NSMutableAttributedString()
        let currContent = NSMutableAttributedString()
        let emptyLine = NSAttributedString(string: String("\n"), attributes: [:])
        var removalsSoFar = 0

        for line in lines {
            if line.prefix(2) == "@@" && line.suffix(2)  == "@@" {
                let changeHeader = NSAttributedString(string: String(line + "\n"), attributes: [NSAttributedStringKey.strokeColor : UIColor.gray])
                baseContent.append(changeHeader)
                currContent.append(emptyLine)
            } else if line.contains("-") {
                let removed = NSAttributedString(string: String(line + "\n"), attributes: [NSAttributedStringKey.backgroundColor : CONSTANTS.FADED_RED])
                baseContent.append(removed)
                removalsSoFar += 1
            } else if line.contains("+") {
                let added = NSAttributedString(string: String(line + "\n"), attributes: [NSAttributedStringKey.backgroundColor : CONSTANTS.FADED_GREEN])
                currContent.append(added)
                removalsSoFar -= 1
                if removalsSoFar < 0 { baseContent.append(emptyLine) }
            } else {
                baseContent.append(NSAttributedString(string: String(line + "\n"), attributes: [:]))
                currContent.append(NSAttributedString(string: String(line + "\n"), attributes: [:]))
            }

        }
        return (baseContent, currContent)
    }
}
