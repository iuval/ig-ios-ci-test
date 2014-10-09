//
//  ViewController.m
//  SayWat
//
//  Created by Iuval Goldansky on 10/7/14.
//  Copyright (c) 2014 iuval. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()
@end

static NSString *saywatURL = @"http://saywut.herokuapp.com/api/roulette";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewSaying];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipeAction:(UITapGestureRecognizer *)recognizer {
    [self loadNewSaying];
}

- (IBAction)fbShare1:(id)sender {
    UIImage *postImage = [UIImage imageNamed:@"avatar"];
    NSString *postText = [NSString stringWithFormat:@"%@ - %@", self.wutLabel.text, self.whoLabel.text];
    NSURL *postUrl = [NSURL URLWithString:saywatURL];
    
    NSArray *activityItems = @[postText, postImage, postUrl];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:activityController animated:YES completion:nil];
}

- (IBAction)fbShare2:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSheet setInitialText: [NSString stringWithFormat:@"%@ - %@", self.wutLabel.text, self.whoLabel.text]];
        [fbSheet addImage: [UIImage imageNamed:@"avatar"]];
        [fbSheet addURL:[NSURL URLWithString:saywatURL]];
        [self presentViewController:fbSheet animated:true completion:nil];
    }
}

- (void) loadNewSaying {
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:saywatURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (!error) {
                    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                    if (httpResp.statusCode == 200) {
                        NSError *parseError;
                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                        
                        NSDictionary *saying = [dic objectForKey:@"saying"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                            self.wutLabel.text = [saying objectForKey:@"wut"];
                            self.whoLabel.text = [saying objectForKey:@"who"];
                            self.wenLabel.text = [saying objectForKey:@"wen"];
                        });
                        
                    } else {
                        // HANDLE BAD RESPONSE //
                    }
                } else {
                    // ALWAYS HANDLE ERRORS :-] //
                }
            }] resume];
}
@end
