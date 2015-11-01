//
//  ViewController.swift
//  AnimatedReloadingTableViewExp
//
//  Created by Takeshi Tanaka on 10/31/15.
//  Copyright © 2015 p0dee. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let RootCellIdentifier = "RootCellIdentifier"
    private let SubCellIdentifier = "SubCellIdentifier"
    private let extendedSections = NSMutableIndexSet()
    private let numberOfRowInSection = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(TableViewRootCell.self, forCellReuseIdentifier: RootCellIdentifier)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: SubCellIdentifier)
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }
    
    //MARK:
    private func didSelectRootCell(section: NSInteger) {
        var extended = isSectionExtended(section)
        extended = !extended
        if extended {
            extendedSections.addIndex(section)
        } else {
            extendedSections.removeIndex(section)
        }
        
        let numOfRows = numberOfRowInSection
        var paths = [NSIndexPath]()
        for i in 1..<numOfRows {
            paths.append(NSIndexPath(forRow: i, inSection: section))
        }
//        tableView.reloadData()
//        tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
        tableView.beginUpdates()
        if extended {
            tableView.insertRowsAtIndexPaths(paths, withRowAnimation: .Automatic)
        } else {
            tableView.deleteRowsAtIndexPaths(paths, withRowAnimation: .Automatic)
        }
        tableView.endUpdates()
        
        UIView.animateWithDuration(0.3) { () -> Void in
            if let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: section)) as? TableViewRootCell {
                cell.extended = extended
            }
        }
    }
    
    private func isSectionExtended(section: NSInteger) -> Bool {
        return extendedSections.containsIndex(section)
    }

    //MARK: <UITableViewDataSource>
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSectionExtended(section) ? numberOfRowInSection : 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let isRoot = indexPath.row == 0
        let identifier = isRoot ? RootCellIdentifier : SubCellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        if isRoot {
            if let cell = cell as? TableViewRootCell {
                cell.label.text = "Section \(indexPath.section)"
                cell.backgroundColor = UIColor(white: CGFloat(0.5 - 0.1 * Double(indexPath.section)), alpha: 1.0)
                cell.label.textColor = UIColor.whiteColor()
                cell.extended = isSectionExtended(indexPath.section)
            }
        } else {
            cell.textLabel?.text = "indexPath(\(indexPath.section), \(indexPath.row))";
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let isRoot = indexPath.row == 0
        if isRoot {
            return isSectionExtended(indexPath.section) ? 30 : 60
        } else {
            return 44
        }
    }
    
    //MARK: <UITableViewDelegate>
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let isRoot = indexPath.row == 0
        if isRoot {
            didSelectRootCell(indexPath.section)
        }
    }
    
}

