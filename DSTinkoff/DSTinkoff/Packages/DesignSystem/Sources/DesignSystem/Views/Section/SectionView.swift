import UIKit
import UIKitUtils

public final class SectionView<ContentView: UIView>: UIView {
    private let stackView = UIStackView()
    private let header = TextButtonCellView()
    private let button = ButtonView()

    public var title: String? {
        get { header.title }
        set { header.title = newValue }
    }

    public var headerButtonText: String? {
        get { header.buttonText }
        set { header.buttonText = newValue }
    }

    public var headerButtonAction: (() -> Void)? {
        get { header.buttonAction }
        set { header.buttonAction = newValue }
    }

    public var contentView: ContentView? {
        didSet { onContentViewUpdated(oldValue: oldValue) }
    }

    public var buttonText: String? {
        get { button.text }
        set {
            button.text = newValue
            onButtonUpdated()
        }
    }

    public var buttonAction: (() -> Void)? {
        get { button.action }
        set {
            button.action = newValue
            onButtonUpdated()
        }
    }

    public var config: SectionConfig = .init() {
        didSet { onConfigUpdated() }
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
        addArrangedSubview(stackView)

        stackView.axis = .vertical

        stackView.addArrangedSubview(header)
        header.contentInset = .zero
        header.highlightsTouches = false

        stackView.addArrangedSubview(button)

        onConfigUpdated()
        onButtonUpdated()
    }

    private func onContentViewUpdated(oldValue: UIView?) {
        oldValue?.removeFromSuperview()
        guard let contentView = contentView else { return }
        stackView.insertArrangedSubview(contentView, at: 1)
    }

    private func onConfigUpdated() {
        header.textConfig = config.headerTextConfig
        header.buttonStyle = config.headerButtonStyle
        button.style = config.buttonStyle
        stackView.spacing = config.spacing.rawValue
    }

    private func onButtonUpdated() {
        button.isHidden = (button.text == nil || button.action == nil)
    }
}

public struct SectionConfig {
    public let headerTextConfig: CellTextComponentView.Config
    public let headerButtonStyle: ButtonView.Style
    public let buttonStyle: ButtonView.Style
    public let spacing: Spacing

    public init(
        headerTextConfig: CellTextComponentView.Config = .init(),
        headerButtonStyle: ButtonView.Style = .primary,
        buttonStyle: ButtonView.Style = .primary,
        spacing: Spacing = .l
    ) {
        self.headerTextConfig = headerTextConfig
        self.headerButtonStyle = headerButtonStyle
        self.buttonStyle = buttonStyle
        self.spacing = spacing
    }
}
