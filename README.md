# Stacked modal transitions - StackedTransitionDemo

![DEMO](https://github.com/ZhangYizhe/StackedTransition/blob/master/demo.gif?raw=true)



1、Use the UIViewControllerTransitioningDelegate delegate to control animations between view controllers.

2、Two ways to implement it to control animations

```swift
//MARK: - Transition animation control
func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let present = StackedTransitionPresentAnimation()
        return present
}
    
func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let present = StackedTransitionDismissedAnimation()
        return present
}
```

3、 Create a new class method to describe specific animations

```swift
// MARK: - stack transition

/// Admission
class StackedTransitionPresentAnimation:NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // Modify the background color during transition
        transitionContext.containerView.backgroundColor = UIColor.clear
        
        // get subview
        let childViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        // get parent view
        let parentViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        parentViewController.view.layer.masksToBounds = true
        parentViewController.view.layer.cornerRadius = 10
        
        childViewController.view.layer.masksToBounds = true
        childViewController.view.layer.cornerRadius = 10
        
        // Place subview on top of parent view
        transitionContext.containerView.insertSubview(childViewController.view, aboveSubview: parentViewController.view)
        
        // Set the initial position of the subview
        childViewController.view.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            
            parentViewController.view.alpha = 0.3
            parentViewController.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            childViewController.view.transform = CGAffineTransform(translationX: 0, y: 60)
            
        }, completion: { (completion) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    
}


/// appear
class StackedTransitionDismissedAnimation:NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Modify the background color during transition
        transitionContext.containerView.backgroundColor = UIColor.clear
        
        // get parent view
        let parentViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        // get subview
        let childViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        // Place toViewController.view above fromViewController.view
        transitionContext.containerView.insertSubview(childViewController.view, aboveSubview: parentViewController.view)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            childViewController.view.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            
            parentViewController.view.alpha = 1
            parentViewController.view.transform = CGAffineTransform.identity
            
        }, completion: { (completion) in
            
            // After the transition is completed transitionWasCancelled
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

```

