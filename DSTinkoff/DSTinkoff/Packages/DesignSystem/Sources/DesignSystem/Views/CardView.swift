import UIKit
import UIKitUtils

public final class CardView<ContentView: UIView>: UIView {

    public var contentView: ContentView? {
        didSet { onContentViewUpdated(oldValue: oldValue) }
    }

    public var style: CardViewStyle = .light {
        didSet { onStyleUpdated() }
    }

    private var fitConstraints: FitConstraints?

    public init() {
        super.init(frame: .zero)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public override var intrinsicContentSize: CGSize {
        if contentView == nil {
            return .zero
        }
        return super.intrinsicContentSize
    }

    private func setup() {
        clipsToBounds = false
    }

    private func onContentViewUpdated(oldValue: ContentView?) {
        oldValue?.removeFromSuperview()
        guard let newValue = contentView else {
            return
        }
        fitConstraints = addArrangedSubview(
            newValue,
            insets: style.contentInset
        )
        invalidateIntrinsicContentSize()
    }

    private func onStyleUpdated() {
        backgroundColor = style.backgroundColor
        fitConstraints?.apply(insets: style.contentInset)

        layer.cornerRadius = style.radius
        if let shadow = style.shadow {
            layer.apply(shadow)
        } else {
            layer.shadowColor = nil
            layer.shadowOpacity = 0
        }
    }
}

public struct CardViewStyle {
    public let backgroundColor: UIColor
    public let radius: CGFloat
    public let contentInset: UIEdgeInsets
    public let shadow: ShadowParameters?

    public init(
        backgroundColor: UIColor,
        radius: CGFloat,
        contentInset: UIEdgeInsets,
        shadow: ShadowParameters?
    ) {
        self.backgroundColor = backgroundColor
        self.radius = radius
        self.contentInset = contentInset
        self.shadow = shadow
    }

    public static var light: CardViewStyle {
        CardViewStyle(
            backgroundColor: Colors.Background.primary.uiColor,
            radius: Corners.l.rawValue,
            contentInset: UIEdgeInsets(
                top: 16,
                left: 20,
                bottom: 16,
                right: 20
            ),
            shadow: Shadow.medium.parameters
        )
    }

    public static var dark: CardViewStyle {
        CardViewStyle(
            backgroundColor: Colors.Background.secondary.uiColor,
            radius: Corners.l.rawValue,
            contentInset: UIEdgeInsets(
                top: 16,
                left: 20,
                bottom: 16,
                right: 20
            ),
            shadow: nil
        )
    }
}
