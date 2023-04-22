import UIKit

public enum TextStyle: CaseIterable {
    case headingM
    case bodyL
    case bodyM
    case uiMBold
    case uiS

    public func parameters(
        textColor: Colors.Text = .primary,
        alignment: NSTextAlignment = .natural
    ) -> TextStyleParameters {
        switch self {
        case .headingM:
            return .headingM(
                textColor: textColor,
                alignment: alignment
            )
        case .bodyL:
            return .bodyL(
                textColor: textColor,
                alignment: alignment
            )
        case .bodyM:
            return .bodyM(
                textColor: textColor,
                alignment: alignment
            )
        case .uiMBold:
            return .uiMBold(
                textColor: textColor,
                alignment: alignment
            )
        case .uiS:
            return .uiS(
                textColor: textColor,
                alignment: alignment
            )
        }
    }
}

extension TextStyleParameters {
    static func headingM(
        textColor: Colors.Text = .primary,
        alignment: NSTextAlignment = .natural
    ) -> Self {
        .init(
            font: .systemFont(
                ofSize: 20,
                weight: .bold
            ),
            textColor: textColor.uiColor,
            lineHeight: 24,
            kern: 0.38,
            alignment: alignment
        )
    }

    static func bodyL(
        textColor: Colors.Text = .primary,
        alignment: NSTextAlignment = .natural
    ) -> Self {
        .init(
            font: .systemFont(
                ofSize: 17,
                weight: .regular
            ),
            textColor: textColor.uiColor,
            lineHeight: 20,
            kern: -0.41,
            alignment: alignment
        )
    }

    static func bodyM(
        textColor: Colors.Text = .primary,
        alignment: NSTextAlignment = .natural
    ) -> Self {
        .init(
            font: .systemFont(
                ofSize: 15,
                weight: .regular
            ),
            textColor: textColor.uiColor,
            lineHeight: 18,
            kern: -0.24,
            alignment: alignment
        )
    }

    static func uiMBold(
        textColor: Colors.Text = .primary,
        alignment: NSTextAlignment = .natural
    ) -> Self {
        .init(
            font: .systemFont(
                ofSize: 15,
                weight: .semibold
            ),
            textColor: textColor.uiColor,
            lineHeight: 18,
            kern: -0.24,
            alignment: alignment
        )
    }

    static func uiS(
        textColor: Colors.Text = .primary,
        alignment: NSTextAlignment = .natural
    ) -> Self {
        .init(
            font: .systemFont(
                ofSize: 13,
                weight: .regular
            ),
            textColor: textColor.uiColor,
            lineHeight: 16,
            kern: -0.08,
            alignment: alignment
        )
    }
}

public struct TextStyleParameters {
    public let font: UIFont
    public let textColor: UIColor
    public let lineHeight: CGFloat
    public let kern: CGFloat
    public let alignment: NSTextAlignment
    public let caps: Bool

    var lineHeightMultiple: CGFloat {
        lineHeight / font.lineHeight
    }

    init(
        font: UIFont,
        textColor: UIColor,
        lineHeight: CGFloat,
        kern: CGFloat,
        alignment: NSTextAlignment,
        caps: Bool = false
    ) {
        self.font = font
        self.textColor = textColor
        self.lineHeight = lineHeight
        self.kern = kern
        self.alignment = alignment
        self.caps = caps
    }
}

extension UILabel {
    public func setText(
        _ string: String?,
        style: TextStyle,
        textColor: Colors.Text = .primary,
        alignment: NSTextAlignment = .natural
    ) {
        setText(
            string,
            style: style.parameters(
                textColor: textColor,
                alignment: alignment
            )
        )
    }

    private func setText(
        _ string: String?,
        style: TextStyleParameters
    ) {
        guard let string = string else {
            attributedText = nil
            return
        }
        attributedText = NSAttributedString(
            string: string,
            style: style
        )
    }
}

extension NSAttributedString {
    public convenience init(
        string: String,
        style: TextStyleParameters
    ) {
        self.init(
            string: style.caps ? string.uppercased() : string,
            attributes: [
                .foregroundColor: style.textColor,
                .font: style.font,
                .kern: style.kern,
                .paragraphStyle: {
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineHeightMultiple = style.lineHeightMultiple
                    paragraphStyle.alignment = style.alignment
                    paragraphStyle.lineBreakMode = .byTruncatingTail
                    return paragraphStyle
                }()
            ]
        )
    }
}
