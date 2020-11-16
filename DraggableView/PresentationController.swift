//
//  PresentationController.swift
//  DraggableView
//
//  Created by Samira Ekrami on 11/16/20.
//


import UIKit

class PresentationController: UIPresentationController {
    
    var tapRecognizer: UITapGestureRecognizer!
    let blurView: UIVisualEffectView!
    
    override var frameOfPresentedViewInContainerView: CGRect {
          CGRect(origin: CGPoint(x: 0,
                                 y: self.containerView!.frame.height * 0.3),
                 size: CGSize(width: self.containerView!.frame.width,
                              height: self.containerView!.frame.height * 0.7))
    }

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.isUserInteractionEnabled = true
        blurView.addGestureRecognizer(tapRecognizer)
    }
    

    override func presentationTransitionWillBegin() {
        blurView.alpha = 0
        containerView?.addSubview(blurView)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
              self.blurView.alpha = 0.5
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
      
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {(UIViewControllerTransitionCoordinatorContext) in
            self.blurView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurView.removeFromSuperview()
        })
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurView.frame = containerView!.bounds
    }
      
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 10)
    }

    @objc func dismissController(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }

}

