import UIKit

public protocol DesignColor {
    var uiColor: UIColor { get }
}

public enum Colors {
    public enum Text: CaseIterable, DesignColor {
        case primary
        case secondary
        case accent

        public var uiColor: UIColor {
            switch self {
            case .primary:
               return UIColor(
                    lightMode: 0x333333,
                    darkMode: 0xFFFFFF
                )
            case .secondary:
               return UIColor(
                    lightMode: 0x9299A2,
                    darkMode: 0x959598
                )
            case .accent:
               return UIColor(
                    lightMode: 0x428BF9,
                    darkMode: 0x428BF9
                )
            }
        }

    }

    public enum Elements: CaseIterable, DesignColor {
        case accent
        case staticWhite

        public var uiColor: UIColor {
            switch self {
            case .accent:
               return UIColor(
                    lightMode: 0x428BF9,
                    darkMode: 0x428BF9
                )
            case .staticWhite:
               return UIColor(
                    lightMode: 0xFFFFFF,
                    darkMode: 0xFFFFFF
                )
            }
        }

    }

    public enum Background: CaseIterable, DesignColor {
        case primary
        case secondary
        case three // card & button
        case four // button presed
        case accent

        public var uiColor: UIColor {
            switch self {
            case .primary:
               return UIColor(
                    lightMode: 0xFFFFFF,
                    darkMode: 0x2A2A2D
                )
            case .secondary:
                return UIColor(
                    lightMode: 0xF6F7F8,
                    darkMode: 0x2F2F2F
                )
            case .three:
                return UIColor(
                    hex: 0x001024,
                    alpha: 0.03
                )
            case .four:
                return UIColor(
                    hex: 0x001024,
                    alpha: 0.06
                )
            case .accent:
               return UIColor(
                    lightMode: 0x428BF9,
                    darkMode: 0x428BF9
                )
            }
        }
    }
}

private extension UIColor {

    convenience init(hex: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }

    convenience init(
        lightMode: Int,
        lightModeAlpha: CGFloat = 1.0,
        darkMode: Int,
        darkModeAlpha: CGFloat = 1.0
    ) {
        self.init(
            dynamicProvider: { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    return UIColor(hex: lightMode, alpha: lightModeAlpha)
                case .dark:
                    return UIColor(hex: darkMode, alpha: darkModeAlpha)
                @unknown default:
                    return UIColor(hex: lightMode, alpha: lightModeAlpha)
                }
            }
        )
    }
}
