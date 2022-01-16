//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by klioop on 2022/01/16.
//

import UIKit
import PinLayout


class QuestionViewController: UIViewController, UITableViewDataSource {
    
    let headerLabel = UILabel()
    let tableView = UITableView()
    
    private var question: String = ""
    private var options: [String] = []
    
    override func viewDidLoad() {
        [headerLabel, tableView].forEach { view.addSubview($0) }
        headerLabel.text = question
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerLabel.pin.top(view.pin.safeArea).hCenter()
    }
    
    convenience init(question: String, options: [String]) {
        self.init()
        self.question = question
        self.options = options
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
}
