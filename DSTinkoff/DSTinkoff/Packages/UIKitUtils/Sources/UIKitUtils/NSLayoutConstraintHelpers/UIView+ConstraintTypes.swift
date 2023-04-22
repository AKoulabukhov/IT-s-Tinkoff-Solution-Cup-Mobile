import UIKit

public extension UIView {
    struct SizeConstraints {
        public let width: NSLayoutConstraint
        public let height: NSLayoutConstraint

        public init(
            width: NSLayoutConstraint,
            height: NSLayoutConstraint
        ) {
            self.width = width
            self.height = height
        }

        public func apply(size: CGSize) {
            self.height.constant = size.height
            self.width.constant = size.width
        }

        public func activate() {
            self.height.activate()
            self.width.activate()
        }

        public func deactivate() {
            self.height.deactivate()
            self.width.deactivate()
        }
    }

    struct CenterConstraints {
        public let centerX: NSLayoutConstraint
        public let centerY: NSLayoutConstraint

        public init(
            centerX: NSLayoutConstraint,
            centerY: NSLayoutConstraint
        ) {
            self.centerX = centerX
            self.centerY = centerY
        }

        public func apply(offset: CGVector) {
            self.centerX.constant = offset.dx
            self.centerY.constant = offset.dy
        }

        public func activate() {
            self.centerX.activate()
            self.centerY.activate()
        }

        public func deactivate() {
            self.centerX.deactivate()
            self.centerY.deactivate()
        }
    }

    struct FitConstraints {
        public var top: NSLayoutConstraint?
        public var leading: NSLayoutConstraint?
        public var bottom: NSLayoutConstraint?
        public var trailing: NSLayoutConstraint?

        public init(
            top: NSLayoutConstraint?,
            leading: NSLayoutConstraint?,
            bottom: NSLayoutConstraint?,
            trailing: NSLayoutConstraint?
        ) {
            self.top = top
            self.leading = leading
            self.bottom = bottom
            self.trailing = trailing
        }

        public func apply(insets: UIEdgeInsets) {
            self.bottom?.constant = insets.bottom
            self.top?.constant = insets.top
            self.leading?.constant = insets.left
            self.trailing?.constant = insets.right
        }

        public func activate() {
            self.top?.activate()
            self.leading?.activate()
            self.bottom?.activate()
            self.trailing?.activate()
        }

        public func deactivate() {
            self.top?.deactivate()
            self.leading?.deactivate()
            self.bottom?.deactivate()
            self.trailing?.deactivate()
        }
    }
}
