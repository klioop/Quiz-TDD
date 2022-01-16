//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by klioop on 2022/01/16.
//

import UIKit
import PinLayout


class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let headerLabel = UILabel()
    let tableView = UITableView()
    
    private var question = ""
    private var options = [String]()
    private var selection: (([String]) -> Void)? = nil
    private let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        [headerLabel, tableView].forEach { view.addSubview($0) }
        headerLabel.text = question
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerLabel.pin.top(view.pin.safeArea).hCenter()
    }
    
    convenience init(
        question: String,
        options: [String],
        selection: @escaping ([String]) -> Void
    ) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeue(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(optionsSelected(in: tableView))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selection?(optionsSelected(in: tableView))
    }
    
    private func optionsSelected(in tableView: UITableView) -> [String] {
        guard let indexPaths = tableView.indexPathsForSelectedRows else {
            return []
        }
        return indexPaths.map { options[$0.row] }
    }
    
    
    private func dequeue(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    }
}
