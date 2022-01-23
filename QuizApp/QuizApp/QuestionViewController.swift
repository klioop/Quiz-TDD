//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by klioop on 2022/01/16.
//

import UIKit
import PinLayout

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let tableView = UITableView()
    
    private(set) var question = ""
    private(set) var options = [String]()
    private var selection: (([String]) -> Void)? = nil
    private let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [headerLabel, tableView].forEach { view.addSubview($0) }
        headerLabel.text = question
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableHeaderView = headerLabel
        tableView.rowHeight = 44
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerLabel.pin.height(44)
        tableView.pin.all(view.pin.safeArea)
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
    
    // dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeue(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    // delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(optionsSelected(in: tableView))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            selection?(optionsSelected(in: tableView))
        }
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
