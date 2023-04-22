import UIKit
import SwiftUI

public enum Shadow: CaseIterable {
    case medium

    public var parameters: ShadowParameters {
        switch self {
        case .medium:
            return .medium
        }
    }
}

extension ShadowParameters {
    static var medium: Self {
        .init(
            color: UIColor(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 0.12
            ),
            opacity: 1,
            radius: 34,
            offset: CGSize(
                width: 0,
                height: 6
            )
        )
    }
}

// MARK: - Declarations

public struct ShadowParameters {
    let color: UIColor
    let opacity: CGFloat
    let radius: CGFloat
    let offset: CGSize

    public init(
        color: UIColor,
        opacity: CGFloat,
        radius: CGFloat,
        offset: CGSize
    ) {
        self.color = color
        self.opacity = opacity
        self.radius = radius
        self.offset = offset
    }
}

extension UIView {
    public func apply(_ shadow: Shadow) {
        layer.apply(shadow.parameters)
    }
    public func apply(_ shadowParameters: ShadowParameters) {
        layer.apply(shadowParameters)
    }
}

extension CALayer {
    public func apply(_ shadowParameters: ShadowParameters) {
        shadowColor = shadowParameters.color.cgColor
        shadowOpacity = Float(shadowParameters.opacity)
        shadowRadius = shadowParameters.radius
        shadowOffset = shadowParameters.offset
    }
}

private struct ShadowViewModifier: ViewModifier {
    let parameters: ShadowParameters

    func body(content: Content) -> some View {
        content.shadow(
            color: Color(parameters.color.withAlphaComponent(parameters.opacity)),
            radius: parameters.radius,
            x: parameters.offset.width,
            y: parameters.offset.height
        )
    }
}

extension View {
    public func shadow(_ shadow: Shadow) -> some View {
        modifier(ShadowViewModifier(parameters: shadow.parameters))
    }
}
