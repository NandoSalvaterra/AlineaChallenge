# Alinea Challenge

iOS take-home challenge — investment amount entry screen built in SwiftUI.


## Images

<img width="188" height="406" alt="IMG_0482" src="https://github.com/user-attachments/assets/058eba7a-bdd6-4ce8-9ad0-cbbc7d3dfd7a" />
<img width="188" height="406" alt="IMG_0481 2" src="https://github.com/user-attachments/assets/71991f89-30b2-4ba3-bb56-a8bacc629e04" />


---

## Requirements

- Xcode 26+
- iOS 26.0+ deployment target
- iPhone (portrait only)

## Running

1. Clone the repo
2. Open `AlineaChallenge.xcodeproj`
3. Select any iOS 26+ simulator or device
4. `⌘R`

To run tests: `⌘U`

---

## Features

- Custom numeric keypad with haptic feedback
- Locale-aware currency formatting (`$`, `R$`, `€`)
- Blinking cursor after the last typed character
- Suggestion bubbles that disappear on first input
- Review button with animated gradient border and pulsing glow
- Embossed metallic text effect on the amount display
- Amount auto-scales when the number gets too long

---

## Project Structure

```
AlineaChallenge/
├── Sources/
│   ├── App/
│   ├── DesignSystem/      ← colors, typography, accessibility IDs, localization
│   ├── Models/            ← KeypadKey
│   ├── Styles/            ← EmbossedTextRenderer
│   ├── ViewModels/        ← InvestmentViewModel
│   └── Views/
├── Resources/
│   ├── Fonts/
│   └── Localizable.xcstrings
AlineaChallengeTests/      ← Swift Testing, 20+ unit tests
AlineaChallengeUITests/    ← XCUITest, 9 UI tests
```

---

## Tech Stack

| | |
|---|---|
| Language | Swift 6 |
| UI | SwiftUI |
| State | `@Observable` |
| Localization | String Catalog (`.xcstrings`) |
| Text effect | `TextRenderer` protocol |
| Unit tests | Swift Testing |
| UI tests | XCUITest |
