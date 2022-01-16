//
//  CorrectAnswerCell.swift
//  QuizApp
//
//  Created by klioop on 2022/01/16.
//

import UIKit


class CorrectAnswerCell: UITableViewCell {
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let answerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGreen
        return label
    }()
    
    let padding: CGFloat = 10
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [questionLabel, answerLabel].forEach { contentView.addSubview($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with answer: PresentableAnswer) {
        questionLabel.text = answer.question
        answerLabel.text = answer.answer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        questionLabel.pin.top().horizontally().marginHorizontal(padding).marginTop(padding).sizeToFit(.width)
        answerLabel.pin.below(of: questionLabel).horizontally().bottom(padding).marginHorizontal(padding).sizeToFit(.width)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return CGSize(width: contentView.frame.width, height: answerLabel.frame.maxY + padding)
    }
}
