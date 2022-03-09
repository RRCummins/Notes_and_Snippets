//
//  Extensions.swift
//  TRFramework
//
//  Created by Ryan Cummins on 10/20/21.
//

import Foundation
import UIKit
import SwiftUI

//MARK: - UIColor+Hex
// Source - https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

//MARK: - Emoji+String
extension String {
    static private var availableEmojis: [String] = [
        "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼",
        "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸",
        "🐵", "🦆", "🦅", "🦉", "🐝", "🦇", "🐺", "🐗",
        "🐴", "🦄", "🐛", "🦋", "🐌", "🐞", "🐙", "🦑",
        "🐢", "🐳",
    ]
    static public var poopEmoji: String = "💩"
    
    public var idxAsEmoji: String {
        let idx = abs(hash) % String.availableEmojis.count
        return String.availableEmojis[idx]
    }
}

//MARK: - UIView+CGNames
extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var right: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }
}

//MARK: - UIView+Variadic
// Variadic Subview Addition
extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}



//MARK: - UIView+Anchors
// Formatting Anchors
extension UIView {
    func pin(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints                             = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive           = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive   = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive     = true
    }
    func fillSuperView() {
        anchor(top: superview?.topAnchor,
               leading: superview?.leadingAnchor,
               bottom: superview?.bottomAnchor,
               trailing: superview?.trailingAnchor,
               center: nil)
    }
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                center: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero,
                cornerRadius: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive              = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive     = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive    = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let center = center {
            centerXAnchor.constraint(equalTo: center).isActive                              = true
        }
//        if let thirdWidth = thirdWidth {
//            centerXAnchor.constraint(equalTo: center).isActive                              = true
//        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive                    = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive                  = true
        }
        if cornerRadius != 0 {
            layer.cornerRadius = cornerRadius
        }
    }
}

//MARK: - UITextField+Padding
// Adding padding inside a textField
extension UITextField {
    
    enum PaddingSpace {
        case left(CGFloat)
        case right(CGFloat)
        case equalSpacing(CGFloat)
    }
    
    func addPadding(padding: PaddingSpace) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {
        
        case .left(let spacing):
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = leftPaddingView
            self.leftViewMode = .always
            
        case .right(let spacing):
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = rightPaddingView
            self.rightViewMode = .always
            
        case .equalSpacing(let spacing):
            let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = equalPaddingView
            self.leftViewMode = .always
            // right
            self.rightView = equalPaddingView
            self.rightViewMode = .always
        }
    }
}

//MARK: - UIImage+Scaling
extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}

//MARK: - UIImage+Rotation

public extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

public extension CGFloat {
    
    func toRadians() -> CGFloat {
        return self * (.pi / 180)
    }
    
    func toDegrees() -> CGFloat {
        return self * (180 * .pi)
    }
}

public extension UIImage {
    
    func imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: size))
        let t = CGAffineTransform(rotationAngle: degrees.toRadians());
        rotatedViewBox.transform = t
        rotatedViewBox.frame.size.width = rotatedViewBox.frame.size.width * 1.1
        rotatedViewBox.frame.size.height = rotatedViewBox.frame.size.height * 1.1
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        if let bitmap = UIGraphicsGetCurrentContext() {
            
            bitmap.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
            
            //   // Rotate the image context
            bitmap.rotate(by: degrees.toRadians())
            
            // Now, draw the rotated/scaled image into the context
            bitmap.scaleBy(x: 1.1, y: -1.1)
            
            if let cgImage = self.cgImage {
                bitmap.draw(cgImage, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
            }
            
            guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { debugPrint("Failed to rotate image. Returning the same as input..."); return self }
            UIGraphicsEndImageContext()
            
            return newImage
        } else {
            debugPrint("Failed to create graphics context. Returning the same as input...")
            return self
        }
        
    }
    
}

// MARK: - Realm+Array
//extension Results {
//    func toArray() -> [Element] {
//        return compactMap {
//            $0
//        }
//    }
//}
//
//extension RealmSwift.List {
//    func toArray() -> [Element] {
//        return compactMap {
//            $0
//        }
//    }
//}

//extension Array<String> {
//    func toObjectID() -> [ObjectId] {
//        return compactMap {
//            ObjectId.init(string:$0)
//        }
//    }
//}


// MARK: - Grouping
protocol Dated {
    var date: Date { get }
}

extension Array where Element: Dated {
    func groupedBy(dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents(dateComponents, from: cur.date)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        
        return groupedByDateComponents
    }
}

// MARK: - UserDefaults+ValueExists
extension UserDefaults {
    
    func valueExists(forKey key: String) -> Bool {
            return object(forKey: key) != nil
        }

    
}

// MARK: - UINavigationController+RemoveSeperator
extension UINavigationController {
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}

// MARK: - UIView+RoundedShadow
protocol ShadowableRoundableView {
    
    var cornerRadius: CGFloat { get set }
    var shadowColor: UIColor { get set }
    var shadowOffsetWidth: CGFloat { get set }
    var shadowOffsetHeight: CGFloat { get set }
    var shadowOpacity: Float { get set }
    var shadowRadius: CGFloat { get set }
    
    var shadowLayer: CAShapeLayer { get }
    
    func setCornerRadiusAndShadow()
}

extension ShadowableRoundableView where Self: UIView {
    func setCornerRadiusAndShadow() {
        layer.cornerRadius = cornerRadius
        shadowLayer.path = UIBezierPath(roundedRect: bounds,
                                            cornerRadius: cornerRadius ).cgPath
        shadowLayer.fillColor = backgroundColor?.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: shadowOffsetWidth ,
                                          height: shadowOffsetHeight )
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
    }
}

//MARK: - SwiftUI+Deselect

struct RefreshOnAppearModifier<Tag: Hashable>: ViewModifier {
    @State private var viewId = UUID()
    @Binding var selection: Tag?
    
    func body(content: Content) -> some View {
        content
            .id(viewId)
            .onAppear {
                if selection != nil {
                    viewId = UUID()
                    selection = nil
                }
            }
    }
}

extension View {
    func refreshOnAppear<Tag: Hashable>(selection: Binding<Tag?>? = nil) -> some View {
        modifier(RefreshOnAppearModifier(selection: selection ?? .constant(nil)))
    }
}

//MARK: - UINavigationController+Previous ViewController

extension UINavigationController {
    var previousViewController: UIViewController? {
       viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }
}


//MARK: - UIColor/Color+Lighten/Darken

extension Color {
    public func lighter(by amount: CGFloat = 0.2) -> Self { Self(UIColor(self).lighter(by: amount)) }
    public func darker(by amount: CGFloat = 0.2) -> Self { Self(UIColor(self).darker(by: amount)) }
}

extension UIColor {
    func mix(with color: UIColor, amount: CGFloat) -> Self {
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0

        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0

        getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        return Self(
            red: red1 * CGFloat(1.0 - amount) + red2 * amount,
            green: green1 * CGFloat(1.0 - amount) + green2 * amount,
            blue: blue1 * CGFloat(1.0 - amount) + blue2 * amount,
            alpha: alpha1
        )
    }

    func lighter(by amount: CGFloat = 0.2) -> Self { mix(with: .white, amount: amount) }
    func darker(by amount: CGFloat = 0.2) -> Self { mix(with: .black, amount: amount) }
}

// MARK: - UIButton+Insets
extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1

        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}

// MARK: - UIViewController+Children
extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func remove(completion: @escaping (() -> Void)) {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
        completion()
    }
}

// MARK: - AppDelegate+RootViewShared
//extension AppDelegate {
//    static var shared: AppDelegate {
//        return UIApplication.shared.delegate as! AppDelegate
//    }
//    var rootViewController: RootViewController {
//        return window!.rootViewController as! RootViewController
//    }
//}

// MARK: - Calendar+CompareDates
extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}

// MARK: - Image+Path
extension Image {
    init(path: String) {
        self.init(uiImage: UIImage(named: path)!)
    }
}

//MARK: - UIView+translatesAutoresizingMaskIntoConstraint
extension UIView {
    func translatesAutoresizingMaskIntoConstraintsForThese(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

// // MARK: - UINavigationController+Themeable
//extension UINavigationController: Themeable {
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//        ThemeManager.shared.register(self)
//    }
//
//    func applyTheme(_ theme: CurrentTheme) {
//        self.view.tintColor = theme.settings.mainHightlight
//        self.view.backgroundColor = theme.settings.background
//        self.navigationBar.applyTheme(theme)
//    }
//
//}
//
//extension UINavigationBar: Themeable {
//    func applyTheme(_ theme: CurrentTheme) {
//        self.tintColor = theme.settings.mainHightlight
//        self.backgroundColor = theme.settings.background
//    }
//}

// MARK: - Sequence + UniqueElements
extension Sequence {
    func uniqueElements<T: Hashable>(byProperty propertyAccessor: (Element) -> T) -> [Element] {
        var seen = Set<T>()
        var result = [Element]()
        
        for element in self {
            let property = propertyAccessor(element)
            
            if seen.contains(property) == false {
                result.append(element)
                seen.insert(property)
            }
        }
        return result
    }
}
/*
    // Use Notes
struct User {
    var name: String
}
let users = [User(name: "User1"), User(name: "User2"), User(name: "User3"), User(name: "User1")]
let uniqueUsers = users.uniqueElements(byProperty: { $0.name })
let uniqueUsers = users.uniqueElements(byProperty: \.name)
 */

// MARK: - PropertyWrappers + NonNegative

@propertyWrapper struct NonNegative<Value: SignedNumeric & Comparable> {
    var value: Value
    
    init(wrappedValue: Value) {
        self.value = max(0, wrappedValue)
    }
    
    var wrappedValue: Value {
        get { value }
        set { value = max(0, newValue) }
    }
}
/*
    // Use Notes
struct SpeedTracker {
    @NonNegative var current = 0.0
    @NonNegative var highest = 0.0
}
*/
