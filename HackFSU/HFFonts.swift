import UIKit

extension UIFont {
    struct HFFont {
        private static let font = "UniSansHeavyCAPS"
        static let H1 = UIFont(name: font, size: 40)?.reduceFontSize(40)
        static let H2 = UIFont(name: font, size: 30)?.reduceFontSize(30)
        static let H3 = UIFont(name: font, size: 25)?.reduceFontSize(25)
        static let H4 = UIFont(name: font, size: 20)?.reduceFontSize(20)
        static let H5 = UIFont(name: font, size: 15)?.reduceFontSize(15)
        static let H6 = UIFont(name: font, size: 10)?.reduceFontSize(10)
        static let p = UIFont(name: font, size: 16)?.reduceFontSize(16)
        static let smallFont = UIFont(name: font, size: 12)?.reduceFontSize(12)
    }
    
    private func reduceFontSize(size: CGFloat) -> UIFont {
        let deviceWidth = UIScreen.mainScreen().bounds.width
        if deviceWidth >= 414 {
            return self.fontWithSize(size)
        }
        if deviceWidth >= 375 {
            return self.fontWithSize(size - 1)
        }
        else {
            return self.fontWithSize(size - 3)
        }
    }
}
