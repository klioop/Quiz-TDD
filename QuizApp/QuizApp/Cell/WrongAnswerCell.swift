//
//  WrongAnswerCell.swift
//  QuizApp
//
//  Created by klioop on 2022/01/16.
//

import UIKit
import PinLayout


class WrongAnswerCell: UITableViewCell {
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let correctAnswerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGreen
        return label
    }()
    let wrongAnswerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemRed
        return label
    }()
    
    private let padding: CGFloat = 10
    
    convenience init() {
        self.init()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [questionLabel, correctAnswerLabel, wrongAnswerLabel].forEach { contentView.addSubview($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with answer: PresentableAnswer) {
        questionLabel.text = answer.question
        correctAnswerLabel.text = answer.answer
        wrongAnswerLabel.text = answer.wrongAnswer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        questionLabel.pin.top().horizontally().margin(padding).sizeToFit(.width)
        correctAnswerLabel.pin.below(of: questionLabel).horizontally().marginHorizontal(padding).sizeToFit(.width)
        wrongAnswerLabel.pin.below(of: correctAnswerLabel).horizontally().marginHorizontal(padding).bottom(padding)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return CGSize(width: contentView.frame.width, height: wrongAnswerLabel.frame.maxY + padding * 2)
    }
}
