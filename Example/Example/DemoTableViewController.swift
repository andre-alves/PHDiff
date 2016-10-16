//
//  DemoTableViewController.swift
//  Example
//
//  Created by Andre Alves on 10/12/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import UIKit
import PHDiff

final class DemoTableViewController: UITableViewController {
    private var colors: [DemoColor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    @IBAction func didTapShuffleButton(_ sender: UIBarButtonItem) {
        shuffle()
    }

    private func shuffle() {
        updateTableView(newColors: RandomDemoColors().randomColors())
    }

    private func updateTableView(newColors: [DemoColor]) {
        let steps = PHDiff.steps(fromArray: self.colors, toArray: newColors)

        if steps.count > 0 {
            tableView.beginUpdates()
            self.colors = newColors // update your model here

            var insertions: [IndexPath] = []
            var deletions: [IndexPath] = []
            var reloads: [IndexPath] = []

            steps.forEach { step in
                switch step {
                case let .insert(_, index):
                    insertions.append(IndexPath(row: index, section: 0))
                case let .delete(_, index):
                    deletions.append(IndexPath(row: index, section: 0))
                case let .move(_, fromIndex, toIndex):
                    deletions.append(IndexPath(row: fromIndex, section: 0))
                    insertions.append(IndexPath(row: toIndex, section: 0))
                case let .update(_, index):
                    reloads.append(IndexPath(row: index, section: 0))
                }
            }

            tableView.insertRows(at: insertions, with: .automatic)
            tableView.deleteRows(at: deletions, with: .automatic)
            tableView.reloadRows(at: reloads, with: .automatic)
            
            tableView.endUpdates()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoCell", for: indexPath)
        let color = colors[indexPath.row]
        cell.textLabel?.text = color.name
        cell.backgroundColor = color.toUIColor()
        return cell
    }
}
