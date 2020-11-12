//
//  PhotoTableViewCell.swift
//  LoveStor
//
//  Created by ****** ****** on 12.11.2020.
//

import UIKit
import VisualEffectView

class PhotoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var photoImageView: BlurImageView!
    @IBOutlet weak var tapToUnblurLabel: UILabel!
    @IBOutlet weak var unblurView: UIView!
    
    var visualEffectView: VisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        setupBlurView()
        photoImageView.visualEffectView.tint(.black, blurRadius: 10)
        photoImageView.visualEffectView.layer.masksToBounds = true
        photoImageView.visualEffectView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupBlurView() {
        visualEffectView = VisualEffectView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        visualEffectView.colorTint = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        visualEffectView.colorTintAlpha = 0.5
        visualEffectView.blurRadius = 10
        visualEffectView.scale = 1
    }
    
    @IBAction func unblurButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.tapToUnblurLabel.layer.opacity = 0
            self.unblurView.layer.opacity = 0
//            self.photoImageView.visualEffectView.tint(.black, blurRadius: 0)
            self.photoImageView.visualEffectView.layer.opacity = 0
        }
    }
}

class BlurImageView: UIImageView {
    lazy var visualEffectView: VisualEffectView = { [unowned self] in
        let view = VisualEffectView()
        self.addSubview(view)
        view.constrainToEdges()
        return view
    }()
}

extension VisualEffectView {
    func tint(_ color: UIColor, blurRadius: CGFloat) {
        self.colorTint = color
        self.colorTintAlpha = 0.5
        self.blurRadius = blurRadius
    }
}

extension UIView {
    @discardableResult
    func constrain(constraints: (UIView) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        let constraints = constraints(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainToEdges(_ inset: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return constrain {[
            $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor, constant: inset.top),
            $0.leadingAnchor.constraint(equalTo: $0.superview!.leadingAnchor, constant: inset.left),
            $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor, constant: inset.bottom),
            $0.trailingAnchor.constraint(equalTo: $0.superview!.trailingAnchor, constant: inset.right)
        ]}
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
    class var red: UIColor { return UIColor(red: 255, green: 59, blue: 48) }
    class var orange: UIColor { return UIColor(red: 255, green: 149, blue: 0) }
    class var yellow: UIColor { return UIColor(red: 255, green: 204, blue: 0) }
    class var green: UIColor { return UIColor(red: 76, green: 217, blue: 100) }
    class var tealBlue: UIColor { return UIColor(red: 90, green: 200, blue: 250) }
    class var blue: UIColor { return UIColor(red: 0, green: 122, blue: 255) }
    class var purple: UIColor { return UIColor(red: 88, green: 86, blue: 214) }
    class var pink: UIColor { return UIColor(red: 255, green: 45, blue: 85) }
    class var allCases: [UIColor] {
        return [red, orange, yellow, green, tealBlue, blue, purple, pink]
    }
}
