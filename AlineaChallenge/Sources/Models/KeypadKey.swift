enum KeypadKey {
    case digit(Int)
    case decimal
    case backspace

    var accessibilityID: String {
        switch self {
        case .digit(let n): return AccessibilityID.keypadDigit(n)
        case .decimal:      return AccessibilityID.keypadDecimal
        case .backspace:    return AccessibilityID.keypadBackspace
        }
    }
}
