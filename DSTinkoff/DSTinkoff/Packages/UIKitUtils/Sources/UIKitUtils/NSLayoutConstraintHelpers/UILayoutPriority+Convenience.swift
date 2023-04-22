import UIKit

extension UILayoutPriority {
    // Highest allowed value to change to from code
    public static let codeRequired = UILayoutPriority(
        rawValue: UILayoutPriority.required.rawValue - 1
    )
}
