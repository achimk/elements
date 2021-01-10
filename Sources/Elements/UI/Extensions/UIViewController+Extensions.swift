import UIKit

extension UIViewController {

    public func insert(
        viewController: UIViewController,
        into container: UIView? = nil,
        using insets: UIEdgeInsets? = nil) {
        
        toggle(from: nil, to: viewController, inside: container, using: insets)
    }
    
    
    public func remove(viewController: UIViewController) {
        toggle(from: viewController, to: nil)
    }
    
    public func toggle(
        from source: UIViewController?,
        to target: UIViewController?,
        inside container: UIView? = nil,
        using insets: UIEdgeInsets? = nil) {
        
        let viewContainer: UIView = container ?? self.view
        
        if source != target, let source = source, let target = target {
            // Replace existing view controller with new view controller
            addChild(target)
            target.willMove(toParent: self)
            source.willMove(toParent: nil)
            source.view.removeFromSuperview()
            source.removeFromParent()
            source.didMove(toParent: nil)
            setup(container: viewContainer, with: target, using: insets)
            target.didMove(toParent: self)
            
        } else if source == nil, let target = target {
            // add new view controller
            addChild(target)
            target.willMove(toParent: self)
            setup(container: viewContainer, with: target, using: insets)
            target.didMove(toParent: self)
            
        } else if target == nil, let source = source {
            // remove existing view controller
            source.willMove(toParent: nil)
            source.view.removeFromSuperview()
            source.removeFromParent()
            source.didMove(toParent: nil)
        }
    }
    
    private func setup(
        container: UIView,
        with viewController: UIViewController,
        using insets: UIEdgeInsets? = nil) {
        
        let insets = insets ?? UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.frame = container.bounds.inset(by: insets)
        container.addSubview(viewController.view)
        container.setNeedsLayout()
    }
}
