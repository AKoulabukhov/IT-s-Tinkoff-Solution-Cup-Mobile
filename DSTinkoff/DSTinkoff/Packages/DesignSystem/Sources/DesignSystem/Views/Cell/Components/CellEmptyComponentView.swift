import UIKit

public final class CellEmptyComponentView: UIView {
    private var _isHidden = true
    public override var isHidden: Bool {
        get { _isHidden }
        set {
            if !_isHidden {
                assertionFailure("Should never be visible")
            }
        }
    }
}
