import UIKit
import UIKitUtils

public final class SpacerView: UIView {
    public init(
        width: Spacing? = nil,
        height: Spacing? = nil
    ) {
        let width = width?.rawValue ?? 0
        let height = height?.rawValue ?? 0

        super.init(frame: .zero)

        pinSize(CGSize(width: width, height: height))
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
