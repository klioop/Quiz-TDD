//
//  ResultViewController.swift
//  QuizApp
//
//  Created by klioop on 2022/01/16.
//

import UIKit


struct PresentableAnswer {
    var isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    
}

class WrongAnswerCell: UITableViewCell {
    
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
        
        headerLabel.text = summary
    }
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        return answer.isCorrect ? CorrectAnswerCell() : WrongAnswerCell()
    }
    
}
