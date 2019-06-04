# 堆栈式模态转场

StackedTransitionDemo

![DEMO](https://github.com/ZhangYizhe/StackedTransition/blob/master/demo.gif?raw=true)



```swift
// MARK: - 堆栈式转场

/// 入场
class StackedTransitionPresentAnimation:NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 修改过渡时的背景颜色
        transitionContext.containerView.backgroundColor = UIColor.clear
        
        // 得到子视图
        let childViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        // 得到父视图
        let parentViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        parentViewController.view.layer.masksToBounds = true
        parentViewController.view.layer.cornerRadius = 10
        
        childViewController.view.layer.masksToBounds = true
        childViewController.view.layer.cornerRadius = 10
        
        // 将子视图 放到父视图之上
        transitionContext.containerView.insertSubview(childViewController.view, aboveSubview: parentViewController.view)
        
        // 设置子视图初始位置
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


/// 出场
class StackedTransitionDismissedAnimation:NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 修改过渡时的背景颜色
        transitionContext.containerView.backgroundColor = UIColor.clear
        
        // 得到父视图
        let parentViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        // 得到子视图
        let childViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        // 将toViewController.view 放到fromViewController.view之上
        transitionContext.containerView.insertSubview(childViewController.view, aboveSubview: parentViewController.view)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            childViewController.view.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            
            parentViewController.view.alpha = 1
            parentViewController.view.transform = CGAffineTransform.identity
            
        }, completion: { (completion) in
            
            // 转场完成后 transitionWasCancelled
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    
}

```

