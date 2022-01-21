
import Foundation
import XCTest
@testable import QuizApp

class QuestionTest: XCTestCase {
    
    func test_hashValue_singleAnswer_returnsTypeHash() {
        let type = "a single"
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_hashValue_multipleAnswer_returnsTypeHash() {
        let type = "multiple"
        let sut = Question.multipleAnswers(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_equatable_isEqual() {
        XCTAssertEqual(Question.singleAnswer("A string"), Question.singleAnswer("A string"))
        XCTAssertEqual(Question.multipleAnswers("A String"), Question.multipleAnswers("A String"))
    }
    
    func test_equatable_isNotEqual() {
        XCTAssertNotEqual(Question.singleAnswer("A string"), Question.singleAnswer("An another string"))
        XCTAssertNotEqual(Question.multipleAnswers("A String"), Question.multipleAnswers("An Another String"))
        XCTAssertNotEqual(Question.singleAnswer("A String"), Question.multipleAnswers("An Another String"))
        XCTAssertNotEqual(Question.singleAnswer("A String"), Question.multipleAnswers("A String"))
    }
                          
}
                          
                          
