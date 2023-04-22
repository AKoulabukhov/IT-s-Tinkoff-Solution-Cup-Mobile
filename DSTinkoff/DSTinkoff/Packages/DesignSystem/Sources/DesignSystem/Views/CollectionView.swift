import UIKit
import UIKitUtils

// TBD: UICollectionView, just haven't enough time :D
// Snap to item minX etc...

public final class CollectionView<ItemView: UIView>: UIView {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    public var layout = CollectionViewLayout() {
        didSet { onLayoutUpdated() }
    }

    public var items = [ItemView]() {
        didSet { onItemsUpdated() }
    }

    public init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        onLayoutUpdated()
    }

    private func onLayoutUpdated() {
        [scrollView, stackView].forEach { $0.removeFromSuperview() }

        if layout.scrollEnabled {
            addArrangedSubview(scrollView)
            scrollView.addArrangedSubview(stackView)
            switch layout.axis {
            case .vertical:
                stackView.widthAnchor.constraint(equalTo: widthAnchor).activate()
            case .horizontal:
                stackView.heightAnchor.constraint(equalTo: heightAnchor).activate()
            }
        } else {
            addArrangedSubview(stackView)
        }

        stackView.axis = layout.axis.uiKitAxis
        stackView.spacing = layout.spacing
    }

    private func onItemsUpdated() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        items.forEach(stackView.addArrangedSubview)
    }
}

public struct CollectionViewLayout {
    public enum Axis {
        case vertical, horizontal

        var uiKitAxis: NSLayoutConstraint.Axis {
            switch self {
            case .horizontal:
                return .horizontal
            case .vertical:
                return .vertical
            }
        }
    }
    public enum Dimension {
        case fixed(CGFloat)
        case contentSize
    }

    public let axis: Axis
    public let spacing: CGFloat
    public let scrollEnabled: Bool

    public init(
        axis: Axis = .vertical,
        spacing: CGFloat = 0,
        scrollEnabled: Bool = false
    ) {
        self.axis = axis
        self.spacing = spacing
        self.scrollEnabled = scrollEnabled
    }
}
