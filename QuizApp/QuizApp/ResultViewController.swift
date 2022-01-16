//
//  ResultViewController.swift
//  QuizApp
//
//  Created by klioop on 2022/01/16.
//

import UIKit


struct PresentableAnswer {
    let question: String
    let answer: String
    var wrongAnswer: String?
}


class CorrectAnswerCell: UITableViewCell {
    
    let questionLabel = UILabel()
    let answerLabel = UILabel()
    
    convenience init() {
        self.init()
        [questionLabel, answerLabel].forEach { contentView.addSubview($0) }
    }
    
    func configure(with answer: PresentableAnswer) {
        questionLabel.text = answer.question
        answerLabel.text = answer.answer
    }
}


class WrongAnswerCell: UITableViewCell {
    
    let questionLabel = UILabel()
    let correctAnswerLabel = UILabel()
    let wrongAnswerLabel = UILabel()
    
    convenience init() {
        self.init()
        [questionLabel, correctAnswerLabel, wrongAnswerLabel].forEach { contentView.addSubview($0) }
    }
    
    func configure(with answer: PresentableAnswer) {
        questionLabel.text = answer.question
        correctAnswerLabel.text = answer.answer
        wrongAnswerLabel.text = answer.wrongAnswer
    }
}



class ResultViewController: UIViewController, UITableViewDataSource {
    
    let headerLabel = UILabel()
    let tableView = UITableView()
    
    private var summary = ""
    private var answers = [PresentableAnswer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [headerLabel, tableView].forEach { view.addSubview($0) }
        tableView.dataSource = self
        tableView.register(CorrectAnswerCell.self, forCellReuseIdentifier: CorrectAnswerCell.reuseIdentifier)
        tableView.register(WrongAnswerCell.self, forCellReuseIdentifier: WrongAnswerCell.reuseIdentifier)
        
        headerLabel.text = summary
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
    
}

// MARK: - helpers

private extension ResultViewController {
    func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CorrectAnswerCell.reuseIdentifier) as! CorrectAnswerCell
        cell.configure(with: answer)
        return cell
    }
    
    func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WrongAnswerCell.reuseIdentifier) as! WrongAnswerCell
        cell.configure(with: answer)
        return cell
    }
}


extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
