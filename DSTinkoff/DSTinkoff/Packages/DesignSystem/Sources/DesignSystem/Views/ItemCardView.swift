import UIKit
import UIKitUtils

// No time :)

public final class ItemCardView: UIView {
    private let containerView = UIView()
    private let imageView = AvatarView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private var fitConstraints: FitConstraints?
    private var interlabelConstraint: NSLayoutConstraint?

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    public var title: String? {
        get { titleLabel.text }
        set { setTitle(newValue) }
    }

    public var subtitle: String? {
        get { subtitleLabel.text }
        set { setSubtitle(newValue) }
    }

    public var config: Config = Config() {
        didSet { onConfigUpdated() }
    }

    private func setup() {
        fitConstraints = addArrangedSubview(containerView)

        containerView.addArrangedSubview(imageView, edges: [.left, .top])
        containerView.addArrangedSubview(subtitleLabel, edges: [.left, .bottom])
        containerView.addArrangedSubview(titleLabel, edges: [.left])

        interlabelConstraint = subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).activate()

        onConfigUpdated()
    }

    private func onConfigUpdated() {
        imageView.config = config.imageConfig
        backgroundColor = config.backgroundColor.uiColor
        layer.cornerRadius = config.corners.rawValue
        setTitle(title)
        setSubtitle(subtitle)
        fitConstraints?.apply(insets: config.contentInset)
        interlabelConstraint?.constant = config.textSpacing.rawValue
    }

    private func setTitle(_ title: String?) {
        titleLabel.setText(title, style: config.titleStyle)
    }

    public func setSubtitle(_ subtitle: String?) {
        subtitleLabel.setText(subtitle, style: config.subtitleStyle)
    }
}

extension ItemCardView {
    public struct Config {
        public let imageConfig: AvatarView.Config
        public let backgroundColor: Colors.Background
        public let corners: Corners
        public let titleStyle: TextStyle
        public let subtitleStyle: TextStyle
        public let contentInset: UIEdgeInsets
        public let textSpacing: Spacing

        public init(
            imageConfig: AvatarView.Config = .init(),
            backgroundColor: Colors.Background = .three,
            corners: Corners = .m,
            titleStyle: TextStyle = .uiMBold,
            subtitleStyle: TextStyle = .uiS,
            contentInset: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12),
            textSpacing: Spacing = .xxs
        ) {
            self.imageConfig = imageConfig
            self.backgroundColor = backgroundColor
            self.corners = corners
            self.titleStyle = titleStyle
            self.subtitleStyle = subtitleStyle
            self.contentInset = contentInset
            self.textSpacing = textSpacing
        }
    }
}
