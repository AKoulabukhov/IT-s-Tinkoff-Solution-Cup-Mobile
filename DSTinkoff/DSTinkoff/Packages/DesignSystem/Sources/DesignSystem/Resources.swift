import UIKit

// TODO: Introduce SwiftGen please

public enum DesignImage: CaseIterable {
    case favorites

    public var uiImage: UIImage {
        UIImage(named: name, in: .module, with: nil) ?? {
            assertionFailure("Missing image")
            return UIImage()
        }()
    }

    private var name: String {
        switch self {
        case .favorites:
            return "favorites"
        }
    }
}
