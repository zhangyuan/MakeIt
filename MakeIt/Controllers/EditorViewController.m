//
//  EditorViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "EditorViewController.h"
#import <AVOSCloud/AVOSCloud.h>


@implementation EditorViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    NSString *html = @"";
    [self setHTML:html];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    AVObject *postObject = [AVObject objectWithClassName:@"Post"];
    [postObject setObject:[self getHTML] forKey:@"content"];
    [postObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) { 
        
    }];
}

@end
