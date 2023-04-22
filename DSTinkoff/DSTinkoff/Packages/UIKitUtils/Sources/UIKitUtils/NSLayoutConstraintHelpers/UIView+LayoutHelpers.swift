import UIKit

extension UIView {
    // MARK: - Anchors

    var safeTopAnchor: NSLayoutYAxisAnchor {
        self.safeAreaLayoutGuide.topAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        self.safeAreaLayoutGuide.bottomAnchor
    }

    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        self.safeAreaLayoutGuide.leadingAnchor
    }

    var safeLeftAnchor: NSLayoutXAxisAnchor {
        self.safeAreaLayoutGuide.leftAnchor
    }

    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        self.safeAreaLayoutGuide.trailingAnchor
    }

    var safeRightAnchor: NSLayoutXAxisAnchor {
        self.safeAreaLayoutGuide.rightAnchor
    }

    // MARK: - Common

    public func forAutolayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Pin

    @discardableResult
    public func addArrangedSubview(
        _ subview: UIView,
        insets: UIEdgeInsets = .zero,
        edges: UIRectEdge = .all,
        preferSafeAnchors: Bool = false,
        priority: UILayoutPriority = .required
    ) -> FitConstraints {
        subview.forAutolayout()
        addSubview(subview)
        return subview.pinEdges(
            to: self,
            insets: insets,
            edges: edges,
            preferSafeAnchors: preferSafeAnchors,
            priority: priority
        )
    }

    @discardableResult
    public func pinEdges(
        to view: UIView,
        insets: UIEdgeInsets = .zero,
        edges: UIRectEdge = .all,
        preferSafeAnchors: Bool = false,
        priority: UILayoutPriority = .required
    ) -> FitConstraints {
        var topConstraint: NSLayoutConstraint?
        var leadingConstraint: NSLayoutConstraint?
        var bottomConstraint: NSLayoutConstraint?
        var trailingConstraint: NSLayoutConstraint?

        let viewTopAnchor = preferSafeAnchors ? view.safeTopAnchor : view.topAnchor
        let viewLeadingAnchor = preferSafeAnchors ? view.safeLeadingAnchor : view.leadingAnchor
        let viewBottomAnchor = preferSafeAnchors ? view.safeBottomAnchor : view.bottomAnchor
        let viewTrailingAnchor = preferSafeAnchors ? view.safeTrailingAnchor : view.trailingAnchor

        if edges.contains(.top) {
            topConstraint = self.topAnchor.constraint(equalTo: viewTopAnchor, constant: insets.top)
        }
        if edges.contains(.left) {
            leadingConstraint = self.leadingAnchor.constraint(equalTo: viewLeadingAnchor, constant: insets.left)
        }
        if edges.contains(.bottom) {
            bottomConstraint = viewBottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom)
        }
        if edges.contains(.right) {
            trailingConstraint = viewTrailingAnchor.constraint(equalTo: self.trailingAnchor, constant: insets.right)
        }

        [
            topConstraint,
            leadingConstraint,
            bottomConstraint,
            trailingConstraint
        ].forEach {
            $0?.activate(priority: priority)
        }

        return FitConstraints(
            top: topConstraint,
            leading: leadingConstraint,
            bottom: bottomConstraint,
            trailing: trailingConstraint
        )
    }

    // MARK: - Size

    @discardableResult
    public func pinSize(
        _ size: CGSize,
        priority: UILayoutPriority = .required
    ) -> SizeConstraints {
        SizeConstraints(
            width: self.pinWidth(
                size.width,
                priority: priority
            ),
            height: self.pinHeight(
                size.height,
                priority: priority
            )
        )
    }

    @discardableResult
    public func pinHeight(_ height: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.heightAnchor.constraint(
            equalToConstant: height
        ).activate(
            priority: priority
        )
    }

    @discardableResult
    public func pinWidth(_ width: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.widthAnchor.constraint(
            equalToConstant: width
        ).activate(
            priority: priority
        )
    }

    @discardableResult
    public func pinCenterX(to view: UIView, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).activate(
            priority: priority
        )
    }

    @discardableResult
    public func pinCenterY(to view: UIView, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).activate(
            priority: priority
        )
    }

    // MARK: - Content size priority

    public func setContentSizePriority(
        _ priority: UILayoutPriority,
        for axis: UIAxis = .both
    ) {
        axis.layoutAxes.forEach {
            setContentHuggingPriority(priority, for: $0)
            setContentCompressionResistancePriority(priority, for: $0)
        }
    }
}

private extension UIAxis {
    var layoutAxes: [NSLayoutConstraint.Axis] {
        var layoutAxes = [NSLayoutConstraint.Axis]()
        if contains(.vertical) {
            layoutAxes.append(.vertical)
        }
        if contains(.horizontal) {
            layoutAxes.append(.horizontal)
        }
        return layoutAxes
    }
}
