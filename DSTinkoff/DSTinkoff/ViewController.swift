import UIKit
import UIKitUtils

class ViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.axis = .vertical
        stackView.spacing = 24

        view.addArrangedSubview(scrollView, preferSafeAnchors: true)
        scrollView.addArrangedSubview(
            stackView,
            insets: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        )

        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32).activate()

        scrollView.alwaysBounceVertical = true

        PreviewComponentsFactory().allExamples().forEach(stackView.addArrangedSubview)
        
//        let label = UILabel()
//        label.font = "HEllo"
//        stackView.adA
    }
}

