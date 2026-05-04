import Foundation

enum AccessibilityID {
    static let amountDisplay = "amount_display"
    static let reviewButton  = "review_button"
    static let keypadDecimal = "keypad_decimal"
    static let keypadBackspace = "keypad_backspace"

    static func keypadDigit(_ n: Int) -> String { "keypad_\(n)" }
    static func suggestion(_ value: Decimal) -> String {
        "suggestion_\(NSDecimalNumber(decimal: value).intValue)"
    }
}
