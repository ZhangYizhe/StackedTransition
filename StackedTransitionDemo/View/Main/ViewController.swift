//
//  ViewController.swift
//  sandwichTransitionDemo
//
//  Created by 张艺哲 on 2019/5/31.
//  Copyright © 2019 张艺哲. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let view : HaveButtonView = self.view as? HaveButtonView else {
            return
        }
        
        view.btnTapCompletion = { [weak self] in
            let storyboard = UIStoryboard(name: "Child", bundle: nil)
            let childVC = storyboard.instantiateViewController(withIdentifier: "ChildViewController")
            childVC.transitioningDelegate = self
            self?.present(childVC, animated: true, completion: nil)
            
        }
    }

    
    //MARK: - 转场动画控制
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentA = StackedTransitionPresentAnimation()
        return presentA
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentA = StackedTransitionDismissedAnimation()
        return presentA
    }

}



