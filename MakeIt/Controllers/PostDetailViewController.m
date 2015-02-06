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
    
    NSString *html = [NSString stringWithFormat:@"<html><body><h1>%@</h1></body></html>", self.post.objectId];
    
    [self.webView loadHTMLString:html baseURL:nil];
    
}
@end
