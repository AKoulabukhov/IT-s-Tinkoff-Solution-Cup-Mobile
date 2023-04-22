import UIKit
import DesignSystem

final class PreviewComponentsFactory {

    func allExamples() -> [UIView] {
        [
            makeCardWithHeaderRightImage().cardWrapped(style: .light),
            makeCardWithHeaderRightImage().cardWrapped(style: .dark),

            makeCardWithHeaderRightImage(subheader: nil).cardWrapped(style: .light),
            makeCardWithHeaderRightImage(subheader: nil).cardWrapped(style: .dark),

            makeCardWithHeaderRightImageAndButton().cardWrapped(style: .light),
            makeCardWithHeaderRightImageAndButton().cardWrapped(style: .dark),

            makeCardWithTitleLeftImage().cardWrapped(style: .light),
            makeCardWithTitleLeftImage().cardWrapped(style: .dark),

            makeSection(withButton: true).cardWrapped(style: .light),
            makeSection(withButton: true).cardWrapped(style: .dark),
            makeSection(withButton: false).cardWrapped(style: .light),
            makeSection(withButton: false).cardWrapped(style: .dark),
        ]
    }

    private func makeCardWithHeaderRightImage(subheader: String? = "Subheader") -> RightImageTextCellView {
        let view = RightImageTextCellView()
        view.textConfig = .init(
            titleStyle: .headingM,
            titleColor: .primary,
            subtitleStyle: .bodyM,
            subtitleColor: .secondary,
            spacing: .xs
        )
        view.imageConfig = .init(
            size: .s,
            backgroundColor: .accent,
            imageColor: .staticWhite
        )
        view.contentInset = .zero
        
        view.title = "Header"
        view.subtitle = subheader
        view.image = DesignImage.favorites.uiImage
        view.highlightsTouches = false
        
        return view
    }

    private func makeCardWithHeaderRightImageAndButton() -> RightImageTextCellView {
        let view = makeCardWithHeaderRightImage()
        let button = ButtonView()
        button.text = "Button"
        view.addSupplementaryView(SpacerView(height: .m))
        view.addSupplementaryView(button)
        
        return view
    }

    private func makeCardWithTitleLeftImage() -> LeftImageTextCellView {
        let view = LeftImageTextCellView()
        view.textConfig = .init(
            titleStyle: .bodyL,
            titleColor: .primary,
            subtitleStyle: .uiS,
            subtitleColor: .secondary,
            spacing: .xxs
        )
        view.imageConfig = .init(
            size: .s,
            backgroundColor: .accent,
            imageColor: .staticWhite
        )
        view.contentInset = .zero
        
        view.title = "Title"
        view.subtitle = "Description"
        view.image = DesignImage.favorites.uiImage
        view.highlightsTouches = false
        
        return view
    }

    private func makeSection(withButton: Bool) -> SectionView<CollectionView<LeftImageTextCellView>> {
        let view = SectionView<CollectionView<LeftImageTextCellView>>()
        view.config = SectionConfig(
            headerTextConfig: CellTextComponentView.Config(
                titleStyle: .headingM,
                titleColor: .primary
            ),
            headerButtonStyle: .link,
            buttonStyle: .primary,
            spacing: .m
        )
        view.title = "Header"
        view.headerButtonText = "Button"
        view.headerButtonAction = { print("header button action") }

        let content = CollectionView<LeftImageTextCellView>()
        content.layout = CollectionViewLayout(
            axis: .vertical,
            spacing: 20,
            scrollEnabled: false
        )
        content.items = (0..<4).map { _ in
            makeCardWithTitleLeftImage()
        }
        view.contentView = content

        if withButton {
            view.buttonText = "Button"
            view.buttonAction = { print("Button action") }
        }
        
        return view
    }
}

private extension UIView {
    func cardWrapped(style: CardViewStyle) -> UIView {
        let view = CardView()
        view.contentView = self
        view.style = style
        return view
    }
}
