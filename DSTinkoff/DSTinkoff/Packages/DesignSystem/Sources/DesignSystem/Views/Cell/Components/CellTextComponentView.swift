import UIKit

public final class CellTextComponentView: UIStackView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    var title: String? {
        get { titleLabel.text }
        set { setTitle(newValue) }
    }

    var subtitle: String? {
        get { subtitleLabel.text }
        set { setSubtitle(newValue) }
    }

    var config: Config = .init() {
        didSet { onConfigUpdated() }
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError()
    }

    private func setup() {
        axis = .vertical
        alignment = .leading
        spacing = Spacing.xxxs.rawValue

        [titleLabel, subtitleLabel].forEach {
            addArrangedSubview($0)
            $0.isHidden = true
        }
    }

    private func setTitle(_ title: String?) {
        titleLabel.setText(
            title,
            style: config.titleStyle,
            textColor: config.titleColor
        )
        titleLabel.isHidden = title.isNilOrEmpty
    }

    private func setSubtitle(_ subtitle: String?) {
        subtitleLabel.setText(
            subtitle,
            style: config.subtitleStyle,
            textColor: config.subtitleColor
        )
        subtitleLabel.isHidden = subtitle.isNilOrEmpty
    }

    private func onConfigUpdated() {
        setTitle(title)
        setSubtitle(subtitle)
        spacing = config.spacing.rawValue
    }
}

private extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        guard let string = self else {
            return true
        }
        return string.isEmpty
    }
}

extension CellTextComponentView {
    public struct Config {
        public let titleStyle: TextStyle
        public let titleColor: Colors.Text
        public let subtitleStyle: TextStyle
        public let subtitleColor: Colors.Text
        public let spacing: Spacing

        public init(
            titleStyle: TextStyle = .bodyL,
            titleColor: Colors.Text = .primary,
            subtitleStyle: TextStyle = .uiS,
            subtitleColor: Colors.Text = .secondary,
            spacing: Spacing = .xxxs
        ) {
            self.titleStyle = titleStyle
            self.titleColor = titleColor
            self.subtitleStyle = subtitleStyle
            self.subtitleColor = subtitleColor
            self.spacing = spacing
        }
    }
}

extension CellView where MiddleView: CellTextComponentView {
    public var title: String? {
        get { middleView.title }
        set { middleView.title = newValue }
    }

    public var textConfig: CellTextComponentView.Config {
        get { middleView.config }
        set { middleView.config = newValue }
    }

    public var subtitle: String? {
        get { middleView.subtitle }
        set { middleView.subtitle = newValue }
    }
}
