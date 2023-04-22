import UIKit
import UIKitUtils

public final class CellImageComponentView: UIView {
    private let avatarView = AvatarView()

    public var config: AvatarView.Config? {
        get { avatarView.config }
        set { avatarView.config = newValue }
    }

    public var image: UIImage? {
        get { avatarView.image }
        set { setImageAndVisibility(newValue) }
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addArrangedSubview(avatarView, edges: [.left, .top, .right])
        bottomAnchor.constraint(greaterThanOrEqualTo: avatarView.bottomAnchor).activate()
        pinHeight(UIScreen.main.bounds.height, priority: .fittingSizeLevel)
        isHidden = true
    }

    fileprivate func setImageAndVisibility(_ image: UIImage?) {
        self.avatarView.image = image
        isHidden = image == nil
    }
}

extension CellView where LeftView: CellImageComponentView {
    public var image: UIImage? {
        get { leftView.image }
        set { leftView.image = newValue }
    }

    public var imageConfig: AvatarView.Config? {
        get { leftView.config }
        set { leftView.config = newValue }
    }
}

extension CellView where RightView: CellImageComponentView {
    public var image: UIImage? {
        get { rightView.image }
        set { rightView.image = newValue }
    }

    public var imageConfig: AvatarView.Config? {
        get { rightView.config }
        set { rightView.config = newValue }
    }
}
