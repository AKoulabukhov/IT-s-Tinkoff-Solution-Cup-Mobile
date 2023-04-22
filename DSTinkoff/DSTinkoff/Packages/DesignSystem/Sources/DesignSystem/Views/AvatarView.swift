import UIKit
import UIKitUtils

// TODO: Support remote images, square type, other sizes etc.

public final class AvatarView: UIView {
    private let backgroundView = UIView()
    private let imageView = UIImageView()
    private var imageSizeConstraints: SizeConstraints?

    public var config: Config? {
        didSet { onConfigUpdated() }
    }

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue?.withRenderingMode(.alwaysTemplate) }
    }

    public override var intrinsicContentSize: CGSize {
        config?.viewSize ?? super.intrinsicContentSize
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
        setContentSizePriority(.codeRequired)

        addArrangedSubview(backgroundView)

        imageView.contentMode = .scaleAspectFit

        imageView.forAutolayout()
        addSubview(imageView)
        imageView.pinCenterX(to: self)
        imageView.pinCenterY(to: self)

        imageSizeConstraints = imageView.pinSize(.zero)
    }

    private func onConfigUpdated() {
        backgroundView.backgroundColor = config?.backgroundColor
        imageView.tintColor = config?.imageColor
        backgroundView.layer.cornerRadius = min(config?.viewSize.width ?? 0, config?.viewSize.height ?? 0) / 2
        imageSizeConstraints?.apply(size: config?.imageSize ?? .zero)
        invalidateIntrinsicContentSize()
    }
}

extension AvatarView {
    public struct Config {
        public let viewSize: CGSize
        public let imageSize: CGSize
        public let backgroundColor: UIColor
        public let imageColor: UIColor
        
        public init(
            viewSize: CGSize,
            imageSize: CGSize,
            backgroundColor: UIColor,
            imageColor: UIColor
        ) {
            self.viewSize = viewSize
            self.imageSize = imageSize
            self.backgroundColor = backgroundColor
            self.imageColor = imageColor
        }
    }

    public enum Size {
        case s

        var viewSize: CGSize {
            CGSize(width: 40, height: 40)
        }

        var imageSize: CGSize {
            CGSize(width: 24, height: 42)
        }
    }
}

extension AvatarView.Config {
    public init(
        size: AvatarView.Size = .s,
        backgroundColor: Colors.Background = .accent,
        imageColor: Colors.Elements = .staticWhite
    ) {
        self.init(
            viewSize: size.viewSize,
            imageSize: size.imageSize,
            backgroundColor: backgroundColor.uiColor,
            imageColor: imageColor.uiColor
        )
    }
}
