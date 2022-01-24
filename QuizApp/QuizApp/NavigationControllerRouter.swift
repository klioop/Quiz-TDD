//  Created by klioop on 2022/01/19.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
            
    func routeTo(question: Question<String>, answerCallBack: @escaping ([String]) -> Void) {
        switch question {
        case .singleAnswer:
            show(factory.questionViewController(for: question, answerCallBack: answerCallBack))
        case .multipleAnswers:
            let button = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
            let buttonController = SubmitButtonController(button, answerCallBack)
            let controller = factory.questionViewController(for: question, answerCallBack: { selection in
                buttonController.update(selection)
            })
            controller.navigationItem.rightBarButtonItem = button
            show(controller)
        }
        
    }
    
    func routeTo(result: ResultOfQuiz<Question<String>, [String]>) {
        show(factory.resultViewController(for: result))
    }
    
    func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}

private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callBack: ([String]) -> Void
    private var model: [String] = []
    
    init(_ button: UIBarButtonItem, _ callBack: @escaping ([String]) -> Void) {
        self.button = button
        self.callBack = callBack
        super.init()
        self.setup()
    }
    
    func update(_ model: [String]) {
        self.model = model
        updateState()
        
    }
    
    private func setup() {
        button.target = self
        button.action = #selector(fireCallBack)
        updateState()
    }
    
    private func updateState() {
        button.isEnabled = model.count > 0
    }
    
    @objc private func fireCallBack(_ model: [String]) {
        self.callBack(model)
    }
}
