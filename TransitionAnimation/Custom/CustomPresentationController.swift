//
//  CustomPresentationController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/16.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let tapDimming = #selector(CustomPresentationController.tapDimming(_:))
}

fileprivate let CORNER_RADIUS: CGFloat = 16.0

class CustomPresentationController: UIPresentationController {
    
    fileprivate var dimmingView: UIView?
    fileprivate var presentationWrappingView: UIView?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
}

// MARK: - Presentation方法
extension CustomPresentationController {
    override var presentedView: UIView? {
        GGLog(message: "presentedView")
        return self.presentationWrappingView
    }
    
    override func presentationTransitionWillBegin() {
        GGLog(message: "presentationTransitionWillBegin")
        let presentedViewControllerView = super.presentedView
        
        do {
            presentationWrappingView = UIView(frame: self.frameOfPresentedViewInContainerView)
            presentationWrappingView?.layer.shadowOpacity = 0.44
            presentationWrappingView?.layer.shadowOffset = CGSize(width: 0, height: -6)
            presentationWrappingView?.layer.shadowRadius = 13
            
            let presentationRoundedCornerView = UIView(frame: UIEdgeInsetsInsetRect(presentationWrappingView!.bounds, UIEdgeInsets(top: 0, left: 0, bottom: -CORNER_RADIUS, right: 0)))
            presentationRoundedCornerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            presentationRoundedCornerView.layer.cornerRadius = CORNER_RADIUS
            presentationRoundedCornerView.layer.masksToBounds = true
            
            let presentedViewControllerWrapperView = UIView(frame: UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsets(top: 0, left: 0, bottom: CORNER_RADIUS, right: 0)))
            presentedViewControllerWrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            presentedViewControllerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            presentedViewControllerView?.frame = presentedViewControllerWrapperView.bounds
            presentedViewControllerWrapperView.addSubview(presentedViewControllerView!) //
            presentationRoundedCornerView.addSubview(presentedViewControllerWrapperView) // blue
            presentationWrappingView?.addSubview(presentationRoundedCornerView) // yellow
        }
        
        do {
            dimmingView = UIView(frame: self.containerView!.bounds)
            dimmingView?.backgroundColor = UIColor.black
            dimmingView?.isOpaque = false
            dimmingView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            dimmingView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: .tapDimming))
            self.containerView?.addSubview(dimmingView!)
            
            let transitionCoordinator = self.presentingViewController.transitionCoordinator
            dimmingView?.alpha = 0
            transitionCoordinator?.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
                self.dimmingView?.alpha = 0.5
                }, completion: nil)
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        GGLog(message: "presentationTransitionDidEnd")
        if !completed {
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }
    
    override func dismissalTransitionWillBegin() {
        GGLog(message: "dismissalTransitionWillBegin")
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
            self.dimmingView?.alpha = 0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        GGLog(message: "dismissalTransitionDidEnd")
        if completed {
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }

    func tapDimming(_ gesture: UITapGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Layout
extension CustomPresentationController {
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        GGLog(message: "preferredContentSizeDidChange")
        if let container = container as? UIViewController {
            if container == self.presentedViewController {
                GGLog(message: "set needs layout")
                self.containerView?.setNeedsLayout()
            }
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        GGLog(message: "sizeforChildContentContainer")
        if let container = container as? UIViewController {
            if container == self.presentedViewController {
                return container.preferredContentSize
            } else {
                return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
            }
        } else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        GGLog(message: "frameOfPresentedViewInContainerView")
        guard let container = self.containerView else {
            return super.frameOfPresentedViewInContainerView
        }
        let containerViewBounds = container.bounds
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerViewBounds.size)
        var presentedViewControllerFrame = containerViewBounds
        presentedViewControllerFrame.size.height = presentedViewContentSize.height
        presentedViewControllerFrame.origin.y = containerViewBounds.maxY - presentedViewContentSize.height
        return presentedViewControllerFrame
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        GGLog(message: "containerViewWillLayoutSubviews")
        guard let container = self.containerView else {
            return
        }
        self.dimmingView?.frame = container.bounds
        self.presentationWrappingView?.frame = self.frameOfPresentedViewInContainerView
    }
}

extension CustomPresentationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        GGLog(message: "duration")
        if let isAnimated = transitionContext?.isAnimated , isAnimated == true {
            return 0.35
        } else {
            return 0
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        GGLog(message: "animateTransition")
        let fromController = transitionContext.viewController(forKey: .from)
        let toController = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        var fromView: UIView?
        var toView: UIView?
        
        if transitionContext.responds(to: NSSelectorFromString("viewForKey:")) {
            fromView = transitionContext.view(forKey: .from)
            toView = transitionContext.view(forKey: .to)
        } else {
            fromView = fromController?.view
            toView = toController?.view
        }
        
        let isPresenting = fromController == self.presentingViewController
        
        var _ = transitionContext.initialFrame(for: fromController!)
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromController!)
        
        var toViewInitialFrame = transitionContext.initialFrame(for: toController!)
        let toViewFinalFrame = transitionContext.finalFrame(for: toController!)
        
        if let toView = toView {
            containerView.addSubview(toView)
        }
        
        if isPresenting {
            toViewInitialFrame.origin = CGPoint(x: containerView.bounds.minX, y: containerView.bounds.maxY)
            toViewInitialFrame.size = toViewFinalFrame.size
            toView?.frame = toViewInitialFrame
        } else {
            if let view = fromView {
                fromViewFinalFrame = view.frame.offsetBy(dx: 0, dy: containerView.bounds.height)
            }
        }
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0, options: .curveLinear, animations: {
            if isPresenting {
                toView?.frame = toViewFinalFrame
            } else {
                fromView?.frame = fromViewFinalFrame
            }
        }) { (isFinish) in
            if isFinish {
                let cancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!cancelled)
            }
        }

    }
}

extension CustomPresentationController: UIViewControllerTransitioningDelegate {
    
    /// UIPresentationController 必须实现此方法
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        GGLog(message: "presentationController 代理方法")
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
