import UIKit

public final class CellButtonComponent: UIView {
    private let button = ButtonView()

    public var buttonText: String? {
        get { button.text }
        set {
            button.text = newValue
            updateVisibility()
        }
    }

    public var buttonAction: (() -> Void)? {
        get { button.action }
        set {
            button.action = newValue
            updateVisibility()
        }
    }

    public var buttonStyle: ButtonView.Style {
        get { button.style }
        set { button.style = newValue }
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        addArrangedSubview(button)
    }

    private func updateVisibility() {
        isHidden = (button.text == nil || button.action == nil)
    }
}

extension CellView where RightView: CellButtonComponent {
    public var buttonText: String? {
        get { rightView.buttonText }
        set { rightView.buttonText = newValue }
    }

    public var buttonAction: (() -> Void)? {
        get { rightView.buttonAction }
        set { rightView.buttonAction = newValue }
    }

    public var buttonStyle: ButtonView.Style {
        get { rightView.buttonStyle }
        set { rightView.buttonStyle = newValue }
    }
}
