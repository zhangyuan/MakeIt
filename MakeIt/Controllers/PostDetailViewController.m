//
//  PostDetailViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/6/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "PostDetailViewController.h"

@implementation PostDetailViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    NSString* urlString = [self.post url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (IBAction)menuButtonClicked:(id)sender {
    NSString* url = [self.post url];
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString: url];
    
    UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"URL Copied" message: url delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [messageAlert show];
}

@end
