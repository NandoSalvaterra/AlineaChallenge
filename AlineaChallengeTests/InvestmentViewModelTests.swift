import Testing
import Foundation
@testable import AlineaChallenge

@Suite struct InvestmentViewModelTests {
    let viewModel = InvestmentViewModel()

    // MARK: - Initial state

    @Test func initialState_isEmpty() {
        #expect(viewModel.isEmpty)
        #expect(!viewModel.hasValue)
    }

    @Test func initialState_displayValueShowsZero() {
        #expect(viewModel.displayValue.contains("0"))
        #expect(!viewModel.displayValue.contains("."))
    }

    @Test func initialState_decimalNotDisabled() {
        #expect(!viewModel.isDecimalDisabled)
    }

    // MARK: - Digit input

    @Test func typingDigit_setsHasValue() {
        viewModel.keyTapped(.digit(5))
        #expect(viewModel.hasValue)
        #expect(!viewModel.isEmpty)
    }

    @Test func typingDigits_buildsRawInput() {
        viewModel.keyTapped(.digit(2))
        viewModel.keyTapped(.digit(0))
        viewModel.keyTapped(.digit(0))
        viewModel.keyTapped(.digit(0))
        #expect(viewModel.rawInput == "2000")
    }

    @Test func typingDigits_formatterApplied() {
        viewModel.keyTapped(.digit(2))
        viewModel.keyTapped(.digit(0))
        viewModel.keyTapped(.digit(0))
        viewModel.keyTapped(.digit(0))
        #expect(viewModel.displayValue != viewModel.rawInput)
    }

    @Test func maxIntegerDigits_enforcedAt10() {
        for _ in 0..<12 { viewModel.keyTapped(.digit(1)) }
        #expect(viewModel.rawInput.count == 10)
    }

    // MARK: - Decimal input

    @Test func typingDecimalOnEmpty_prefixesZero() {
        viewModel.keyTapped(.decimal)
        #expect(viewModel.rawInput == "0.")
    }

    @Test func typingDecimal_disablesDecimalKey() {
        viewModel.keyTapped(.digit(5))
        viewModel.keyTapped(.decimal)
        #expect(viewModel.isDecimalDisabled)
    }

    @Test func typingDecimalTwice_secondIsIgnored() {
        viewModel.keyTapped(.digit(5))
        viewModel.keyTapped(.decimal)
        viewModel.keyTapped(.decimal)
        #expect(viewModel.rawInput.filter { $0 == "." }.count == 1)
    }

    @Test func typingOneDecimalDigit_notAutoPadded() {
        viewModel.keyTapped(.digit(5))
        viewModel.keyTapped(.decimal)
        viewModel.keyTapped(.digit(7))
        #expect(viewModel.rawInput == "5.7")
        #expect(viewModel.displayValue.hasSuffix("7"))
    }

    @Test func maxDecimalPlaces_enforcedAtTwo() {
        viewModel.keyTapped(.digit(5))
        viewModel.keyTapped(.decimal)
        viewModel.keyTapped(.digit(7))
        viewModel.keyTapped(.digit(7))
        viewModel.keyTapped(.digit(7))
        #expect(viewModel.rawInput == "5.77")
    }

    // MARK: - Backspace

    @Test func backspaceOnEmpty_doesNothing() {
        viewModel.keyTapped(.backspace)
        #expect(viewModel.rawInput == "")
    }

    @Test func backspace_removesLastCharacter() {
        viewModel.keyTapped(.digit(5))
        viewModel.keyTapped(.digit(0))
        viewModel.keyTapped(.backspace)
        #expect(viewModel.rawInput == "5")
    }

    @Test func backspaceAfterDecimal_removesDecimalPoint() {
        viewModel.keyTapped(.digit(5))
        viewModel.keyTapped(.decimal)
        viewModel.keyTapped(.backspace)
        #expect(viewModel.rawInput == "5")
        #expect(!viewModel.isDecimalDisabled)
    }

    @Test func backspaceToEmpty_resetsState() {
        viewModel.keyTapped(.digit(5))
        viewModel.keyTapped(.backspace)
        #expect(viewModel.isEmpty)
        #expect(!viewModel.hasValue)
    }

    // MARK: - Suggestions

    @Test func selectSuggestion_setsRawInput() {
        viewModel.selectSuggestion(500)
        #expect(viewModel.rawInput == "500")
        #expect(viewModel.hasValue)
    }

    @Test func selectSuggestion_displayValueHasNoDecimals() {
        viewModel.selectSuggestion(500)
        #expect(!viewModel.displayValue.contains("."))
    }

    @Test func selectSuggestion_afterTyping_replacesInput() {
        viewModel.keyTapped(.digit(9))
        viewModel.keyTapped(.digit(9))
        viewModel.selectSuggestion(2_000)
        #expect(viewModel.rawInput == "2000")
    }
}
