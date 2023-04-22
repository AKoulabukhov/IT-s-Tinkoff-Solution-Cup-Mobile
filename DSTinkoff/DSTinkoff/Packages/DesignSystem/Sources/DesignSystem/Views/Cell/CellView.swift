import UIKit
import UIKitUtils

open class CellView<LeftView: UIView, MiddleView: UIView, RightView: UIView>: UIView {
    public let leftView: LeftView
    public let middleView: MiddleView
    public let rightView: RightView

    public var highlightsTouches = true

    public var contentInset: UIEdgeInsets {
        get {
            UIEdgeInsets(
                top: fitConstraints?.top?.constant ?? 0,
                left: fitConstraints?.leading?.constant ?? 0,
                bottom: fitConstraints?.bottom?.constant ?? 0,
                right: fitConstraints?.trailing?.constant ?? 0
            )
        }
        set {
            fitConstraints?.apply(insets: newValue)
        }
    }

    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private var touchesBeganBackgroundColor: UIColor?
    private var fitConstraints: FitConstraints?

    public init(
        leftViewInit: () -> LeftView = LeftView.init,
        middleViewInit: () -> MiddleView = MiddleView.init,
        rightViewInit: () -> RightView = RightView.init
    ) {
        self.leftView = leftViewInit()
        self.middleView = middleViewInit()
        self.rightView = rightViewInit()
        super.init(frame: .zero)
        setup()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func setup() {
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center

        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center

        let insets = UIEdgeInsets(
            top: Spacing.s.rawValue,
            left: Spacing.m.rawValue,
            bottom: Spacing.s.rawValue,
            right: Spacing.m.rawValue
        )
        fitConstraints = addArrangedSubview(
            verticalStackView,
            insets: insets,
            edges: [.left, .top, .right]
        )
        fitConstraints?.bottom = bottomAnchor.constraint(
            equalTo: verticalStackView.bottomAnchor,
            constant: insets.bottom
        ).activate(
            priority: .codeRequired
        )

        verticalStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor).activate()

        [leftView, middleView, rightView].forEach {
            horizontalStackView.addArrangedSubview($0)
        }

        horizontalStackView.setCustomSpacing(
            Spacing.s.rawValue,
            after: leftView
        )

        horizontalStackView.setCustomSpacing(
            Spacing.xl.rawValue,
            after: middleView
        )

        [leftView, rightView].forEach {
            $0.setContentSizePriority(.required)
        }
    }

    public func addSupplementaryView(_ view: UIView) {
        verticalStackView.addArrangedSubview(view)
        view.pinEdges(to: horizontalStackView, edges: [.left, .right], priority: .defaultHigh)
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard highlightsTouches else {
            return
        }
        touchesBeganBackgroundColor = backgroundColor
        backgroundColor = Colors.Background.three.uiColor
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        backgroundColor = touchesBeganBackgroundColor ?? .clear
        touchesBeganBackgroundColor = nil
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        backgroundColor = touchesBeganBackgroundColor ?? .clear
        touchesBeganBackgroundColor = nil
    }
}
