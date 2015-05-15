//
//  SecondViewController.m
//  TabbedAnimations
//
//  Created by Zakk Hoyt on 5/14/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "SecondViewController.h"
#import "ButtonTabAnimator.h"

@interface SecondViewController () <UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.delegate = self;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonTouchUpInside:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}



- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC{
    return [ButtonTabAnimator animatorStartingAtFrame:self.button.frame];
}


@end
