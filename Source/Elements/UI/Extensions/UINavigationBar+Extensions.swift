import UIKit

extension UINavigationBar {
    
    func removeShadow() {
        self.setValue(true, forKey: "hidesShadow")
    }
    
    func addShadow() {
        self.setValue(false, forKey: "hidesShadow")
    }
    
}
