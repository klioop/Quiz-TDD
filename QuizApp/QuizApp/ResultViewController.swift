//
//  ResultViewController.swift
//  QuizApp
//
//  Created by klioop on 2022/01/16.
//

import UIKit
import PinLayout


struct PresentableAnswer {
    let question: String
    let answer: String
    var wrongAnswer: String?
}



class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    let tableView = UITableView()
    
    private var summary = ""
    private var answers = [PresentableAnswer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [headerLabel, tableView].forEach { view.addSubview($0) }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(type: CorrectAnswerCell.self)
        tableView.register(type: WrongAnswerCell.self)
        tableView.tableHeaderView = headerLabel
        
        headerLabel.text = summary
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerLabel.pin.height(44)
        tableView.pin.all(view.pin.safeArea)
    }
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.wrongAnswer == nil {
            return correctAnswerCell(for: answer)
        }
        return wrongAnswerCell(for: answer)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        answers[indexPath.row].wrongAnswer == nil ? 50 : 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - helpers

private extension ResultViewController {
    func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)!
        cell.configure(with: answer)
        return cell
    }
    
    func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WrongAnswerCell.self)!
        cell.configure(with: answer)
        return cell
    }
}
