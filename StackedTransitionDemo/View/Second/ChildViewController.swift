//
//  SecondViewController.swift
//  sandwichTransitionDemo
//
//  Created by 张艺哲 on 2019/5/31.
//  Copyright © 2019 张艺哲. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view : HaveButtonView = self.view as? HaveButtonView else {
            return
        }
        
        view.btnTapCompletion = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }

    }

}
