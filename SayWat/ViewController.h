//
//  ViewController.h
//  SayWat
//
//  Created by Iuval Goldansky on 10/7/14.
//  Copyright (c) 2014 iuval. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wutLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoLabel;
@property (weak, nonatomic) IBOutlet UILabel *wenLabel;

@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;

- (IBAction)swipeAction:(UITapGestureRecognizer *)recognizer;

- (void) loadNewSaying;
@end

