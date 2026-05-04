import XCTest
@testable import AlineaChallenge

final class InvestmentViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - Initial state

    func test_initialState_bubblesVisible() {
        XCTAssertTrue(app.buttons[AccessibilityID.suggestion(500)].exists)
        XCTAssertTrue(app.buttons[AccessibilityID.suggestion(2_000)].exists)
        XCTAssertTrue(app.buttons[AccessibilityID.suggestion(10_000)].exists)
    }

    func test_initialState_reviewButtonHidden() {
        XCTAssertFalse(app.buttons[AccessibilityID.reviewButton].exists)
    }

    // MARK: - Digit input

    func test_typingDigit_hidesBubblesAndShowsReview() {
        app.buttons[AccessibilityID.keypadDigit(5)].tap()
        XCTAssertTrue(app.buttons[AccessibilityID.reviewButton].waitForExistence(timeout: 1))
        XCTAssertFalse(app.buttons[AccessibilityID.suggestion(500)].exists)
    }

    func test_typingDigit_updatesAmountDisplay() {
        app.buttons[AccessibilityID.keypadDigit(5)].tap()
        XCTAssertTrue(app.staticTexts[AccessibilityID.amountDisplay].label.contains("5"))
    }

    // MARK: - Decimal button

    func test_decimalButton_disabledAfterDecimalInput() {
        app.buttons[AccessibilityID.keypadDigit(5)].tap()
        XCTAssertTrue(app.buttons[AccessibilityID.reviewButton].waitForExistence(timeout: 1))
        app.buttons[AccessibilityID.keypadDecimal].tap()
        XCTAssertFalse(app.buttons[AccessibilityID.keypadDecimal].isEnabled)
    }

    func test_decimalButton_reenabledAfterBackspace() {
        app.buttons[AccessibilityID.keypadDigit(5)].tap()
        XCTAssertTrue(app.buttons[AccessibilityID.reviewButton].waitForExistence(timeout: 1))
        app.buttons[AccessibilityID.keypadDecimal].tap()
        app.buttons[AccessibilityID.keypadBackspace].tap()
        XCTAssertTrue(app.buttons[AccessibilityID.keypadDecimal].isEnabled)
    }

    // MARK: - Backspace

    func test_backspace_removesLastCharacter() {
        app.buttons[AccessibilityID.keypadDigit(5)].tap()
        XCTAssertTrue(app.buttons[AccessibilityID.reviewButton].waitForExistence(timeout: 1))
        app.buttons[AccessibilityID.keypadDigit(0)].tap()
        app.buttons[AccessibilityID.keypadBackspace].tap()
        let label = app.staticTexts[AccessibilityID.amountDisplay].label
        XCTAssertTrue(label.contains("5"))
        XCTAssertFalse(label.contains("50"))
    }

    func test_backspaceToEmpty_showsBubblesAgain() {
        app.buttons[AccessibilityID.keypadDigit(5)].tap()
        XCTAssertTrue(app.buttons[AccessibilityID.reviewButton].waitForExistence(timeout: 1))
        app.buttons[AccessibilityID.keypadBackspace].tap()
        XCTAssertTrue(app.buttons[AccessibilityID.suggestion(500)].waitForExistence(timeout: 1))
        XCTAssertFalse(app.buttons[AccessibilityID.reviewButton].exists)
    }

    // MARK: - Suggestions

    func test_selectSuggestion_showsReviewButton() {
        app.buttons[AccessibilityID.suggestion(500)].tap()
        XCTAssertTrue(app.buttons[AccessibilityID.reviewButton].waitForExistence(timeout: 1))
    }

    func test_selectSuggestion_updatesAmountDisplay() {
        app.buttons[AccessibilityID.suggestion(500)].tap()
        XCTAssertTrue(app.buttons[AccessibilityID.reviewButton].waitForExistence(timeout: 1))
        XCTAssertTrue(app.staticTexts[AccessibilityID.amountDisplay].label.contains("500"))
    }
}
