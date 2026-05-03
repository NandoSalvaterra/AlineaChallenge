import SwiftUI

struct KeypadView: View {
    let isDecimalDisabled: Bool
    let onKeyTap: (KeypadKey) -> Void

    private let rows: [[KeypadKey]] = [
        [.digit(1), .digit(2), .digit(3)],
        [.digit(4), .digit(5), .digit(6)],
        [.digit(7), .digit(8), .digit(9)],
        [.decimal,  .digit(0), .backspace]
    ]

    private let rowSpacing: CGFloat = 26

    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: rowSpacing) {
            ForEach(rows.indices, id: \.self) { rowIndex in
                GridRow {
                    ForEach(rows[rowIndex].indices, id: \.self) { colIndex in
                        let key = rows[rowIndex][colIndex]
                        KeypadButtonView(
                            key: key,
                            isEnabled: isEnabled(for: key),
                            expandsHorizontally: colIndex == 1,
                            onTap: { onKeyTap(key) }
                        )
                    }
                }
            }
        }
    }

    private func isEnabled(for key: KeypadKey) -> Bool {
        if case .decimal = key { return !isDecimalDisabled }
        return true
    }
}

#Preview {
    VStack {
        KeypadView(isDecimalDisabled: false, onKeyTap: { _ in })
    }
    .padding()
    .background(Color.background)
}
