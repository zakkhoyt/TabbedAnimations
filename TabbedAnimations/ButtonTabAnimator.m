//
//  ButtonTabAnimator.m
//  TabbedAnimations
//
//  Created by Zakk Hoyt on 5/14/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "ButtonTabAnimator.h"


@interface ButtonTabAnimator ()
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic) CGRect frame;
@property (nonatomic) CGPoint center;
@property (nonatomic) BOOL reverse;
@end


@implementation ButtonTabAnimator

+(ButtonTabAnimator*)animatorStartingAtFrame:(CGRect)frame{
    ButtonTabAnimator *animator = [[ButtonTabAnimator alloc]init];
    // Copy useful information about where to start transition
    animator.frame = frame;
    animator.center = CGPointMake(frame.origin.x + frame.size.width / 2.0,
                                  frame.origin.y + frame.size.height / 2.0);
    return animator;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    
    UIView *containerView = transitionContext.containerView;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [containerView addSubview:toViewController.view];
    
    //    if(self.reverse){
    //        UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:self.frame];
    //        CGPoint extremePoint = CGPointMake(self.center.x - 0, self.center.y - CGRectGetHeight(toViewController.view.bounds));
    //        CGFloat radius = 2*sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y));
    //        UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.frame, -radius, -radius)];
    //
    //        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //        maskLayer.path = circleMaskPathFinal.CGPath;
    //        toViewController.view.layer.mask = maskLayer;
    //
    //        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    //        maskLayerAnimation.fromValue = (id)circleMaskPathFinal.CGPath;
    //        maskLayerAnimation.toValue = (id)circleMaskPathInitial.CGPath;
    //        maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    //        maskLayerAnimation.delegate = self;
    //        [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    //
    //    } else {
    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:self.frame];
    CGPoint extremePoint = CGPointMake(self.center.x - 0, self.center.y - CGRectGetHeight(toViewController.view.bounds));
    CGFloat radius = 2*sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y));
    UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.path = circleMaskPathFinal.CGPath;
    toViewController.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (id)circleMaskPathInitial.CGPath;
    maskLayerAnimation.toValue = (id)circleMaskPathFinal.CGPath;
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    //    }
    
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
    UIViewController *vc = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    vc.view.layer.mask = nil;
}

@end
