//
//  EditPostViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/19/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "EditPostViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation EditPostViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    NSString *html = self.post.content;
    [self setHTML:html];
}

- (IBAction)updatePost:(UIBarButtonItem *)sender {
    AVObject* postObject;
    postObject = [AVObject objectWithoutDataWithClassName:@"Post" objectId:self.post.objectId];
    
    [postObject setObject:[self getHTML] forKey:@"content"];
    [postObject setObject:self.post.title forKey:@"title"];
    
    [postObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            self.post.objectId = [postObject objectId];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

@end
