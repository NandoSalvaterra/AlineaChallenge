import Foundation

@Observable
final class InvestmentViewModel {
    private(set) var rawInput: String = ""
    let suggestions: [Decimal] = [500, 2_000, 10_000]

    private static let wholeFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    private static let maxDigits = 10
    private static let maxDecimalPlaces = 2

    var displayValue: String {
        guard !rawInput.isEmpty else {
            return Self.wholeFormatter.string(from: 0) ?? "0"
        }

        let components = rawInput.split(separator: ".", omittingEmptySubsequences: false)
        let integerStr = components.first.map(String.init) ?? "0"
        let integerValue = Decimal(string: integerStr.isEmpty ? "0" : integerStr) ?? 0

        guard let formattedWhole = Self.wholeFormatter.string(from: integerValue as NSDecimalNumber) else {
            return rawInput
        }

        guard components.count > 1 else { return formattedWhole }

        // Mirror the decimal digits exactly as typed — no padding, no rounding
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let decimalDigits = String(components[1])
        return formattedWhole + decimalSeparator + decimalDigits
    }

    var isEmpty: Bool { rawInput.isEmpty }

    var hasValue: Bool { !rawInput.isEmpty }

    var isDecimalDisabled: Bool { rawInput.contains(".") }

    func keyTapped(_ key: KeypadKey) {
        switch key {
        case .digit(let n):
            appendDigit(n)
        case .decimal:
            appendDecimal()
        case .backspace:
            removeLastCharacter()
        }
    }

    func selectSuggestion(_ value: Decimal) {
        rawInput = "\(value)"
    }
    
    // MARK: - Private API

    private func appendDigit(_ digit: Int) {
        let components = rawInput.split(separator: ".", omittingEmptySubsequences: false)

        if rawInput.contains(".") {
            let decimalPart = components.count > 1 ? String(components[1]) : ""
            guard decimalPart.count < Self.maxDecimalPlaces else { return }
        } else {
            let integerPart = components.first.map(String.init) ?? rawInput
            guard integerPart.count < Self.maxDigits else { return }
        }

        rawInput += "\(digit)"
    }

    private func appendDecimal() {
        guard !isDecimalDisabled else { return }
        rawInput = rawInput.isEmpty ? "0." : rawInput + "."
    }

    private func removeLastCharacter() {
        guard !rawInput.isEmpty else { return }
        rawInput.removeLast()
    }
}
