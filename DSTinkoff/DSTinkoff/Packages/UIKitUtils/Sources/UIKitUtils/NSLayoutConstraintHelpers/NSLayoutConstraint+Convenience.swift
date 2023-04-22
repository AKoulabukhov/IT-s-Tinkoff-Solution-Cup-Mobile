import Foundation
import UIKit

extension NSLayoutConstraint {
    @discardableResult
    public func activate(priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        if let priority = priority {
            self.priority = priority
        }
        isActive = true
        return self
    }
    public func deactivate() {
        isActive = false
    }

    public func withMultiplier(_ newMultiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: newMultiplier,
            constant: constant
        )
        newConstraint.priority = priority
        newConstraint.identifier = identifier
        newConstraint.shouldBeArchived = shouldBeArchived
        newConstraint.isActive = isActive
        return newConstraint
    }
}
