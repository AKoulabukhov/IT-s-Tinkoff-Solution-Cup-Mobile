import UIKit

public final class ButtonView: UIView {
    private let backgroundView = UIView()
    private let textLabel = UILabel()
    private let leftImageView = UIImageView()
    private let rightImageView = UIImageView()
    private let contentStackView = UIStackView()

    private var heightConstraints = [NSLayoutConstraint]()
    private var paddingConstraints = [NSLayoutConstraint]()

    public var style: Style = .primary {
        didSet { onStyleUpdated() }
    }
    public var leftImage: UIImage? {
        didSet { onLeftImageUpdated() }
    }
    public var rightImage: UIImage? {
        didSet { onRightImageUpdated() }
    }
    public var text: String? {
        didSet { onTextUpdated() }
    }
    public var isEnabled = true {
        didSet { updateBackgroundColor() }
    }
    public var action: (() -> Void)?

    private var contentViews: [UIView] {
        [leftImageView, textLabel, rightImageView]
    }

    private var isTouching: Bool = false {
        didSet { updateBackgroundColor() }
    }

    public init() {
        super.init(frame: .zero)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {

        backgroundView.layer.cornerRadius = Corners.m.rawValue
        backgroundView.layer.masksToBounds = true

        addArrangedSubview(backgroundView)

        contentStackView.axis = .horizontal
        contentStackView.alignment = .center

        contentViews.forEach {
            $0.isHidden = true
            $0.setContentSizePriority(.required)
            contentStackView.addArrangedSubview($0)
        }

        contentStackView.spacing = Spacing.xs.rawValue

        contentStackView.forAutolayout()
        backgroundView.addSubview(contentStackView)
        contentStackView.pinCenterY(to: backgroundView)
        contentStackView.pinCenterX(to: backgroundView)

        self.paddingConstraints = [
            contentStackView.leadingAnchor.constraint(
                greaterThanOrEqualTo: backgroundView.leadingAnchor,
                constant: 0
            ).activate(),
            contentStackView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 0
            ).activate(
                priority: .defaultHigh
            )
        ]

        onStyleUpdated()
    }

    private func onLeftImageUpdated() {
        leftImageView.image = leftImage
        leftImageView.isHidden = leftImage == nil
    }

    private func onRightImageUpdated() {
        rightImageView.image = rightImage
        rightImageView.isHidden = rightImage == nil
    }

    private func onTextUpdated() {
        textLabel.setText(
            text,
            style: .bodyM,
            textColor: style.tintColor,
            alignment: .center
        )
        textLabel.isHidden = text == nil
    }

    private func onStyleUpdated() {
        onTextUpdated()
        updateHeightConstraints()
        updateHorizontalPadding()
        updateBackgroundColor()
    }

    private func updateBackgroundColor() {
        let color: DesignColor
        if !isEnabled {
            color = style.backgroundColorDisabled
        } else if isTouching {
            color = style.backgroundColorHighlighted
        } else {
            color = style.backgroundColor
        }
        backgroundView.backgroundColor = color.uiColor
    }

    private func updateHeightConstraints() {
        heightConstraints.removeAll()
        switch style.height{
        case .fixed(let fixed):
            heightConstraints.append(pinHeight(fixed))
        case .inset(let inset):
            heightConstraints.append(contentsOf: [
                contentStackView.topAnchor.constraint(
                    greaterThanOrEqualTo: backgroundView.topAnchor,
                    constant: inset
                ).activate(),
                contentStackView.topAnchor.constraint(
                    equalTo: backgroundView.topAnchor,
                    constant: inset
                ).activate(
                    priority: .defaultHigh
                )
            ])
        }
    }

    private func updateHorizontalPadding() {
        paddingConstraints.forEach {
            $0.constant = style.horizontalInsets
        }
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isTouching = true
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isTouching = false
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTouching = false
        if isEnabled, touches.contains(where: { bounds.contains($0.location(in: self)) }) {
            action?()
        }
    }
}

extension ButtonView {
    public struct Style {
        public enum Height {
            case fixed(CGFloat)
            case inset(CGFloat)
        }
        let backgroundColor: DesignColor
        let backgroundColorHighlighted: DesignColor
        let backgroundColorDisabled: DesignColor
        let tintColor: Colors.Text
        let height: Height
        let horizontalInsets: CGFloat
    }
}

extension ButtonView.Style {
    public static var primary: ButtonView.Style {
        ButtonView.Style(
            backgroundColor: Colors.Background.three,
            backgroundColorHighlighted: Colors.Background.four,
            backgroundColorDisabled: Colors.Background.four,
            tintColor: .accent,
            height: .fixed(44),
            horizontalInsets: Spacing.xxl.rawValue
        )
    }

    public static var link: ButtonView.Style {
        let clearColor = ClearDesignColor()
        return ButtonView.Style(
            backgroundColor: clearColor,
            backgroundColorHighlighted: clearColor,
            backgroundColorDisabled: clearColor,
            tintColor: .accent,
            height: .inset(.zero),
            horizontalInsets: .zero
        )
    }
}

private final class ClearDesignColor: DesignColor {
    var uiColor: UIColor { .clear }
}
