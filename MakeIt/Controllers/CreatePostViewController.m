//
//  CreatePostViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/19/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
#import "CreatePostViewController.h"
#import "PostDetailViewController.h"

@implementation CreatePostViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    NSString *html = @"";
    [self setHTML:html];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    AVObject* postObject;
    
    if (self.post.objectId) {
        NSLog(@"Save");
        postObject = [AVObject objectWithoutDataWithClassName:@"Post" objectId:self.post.objectId];
    } else {
        NSLog(@"Create");
        postObject = [AVObject objectWithClassName:@"Post"];
    }
    
    [postObject setObject:[self getHTML] forKey:@"content"];
    [postObject setObject:self.post.title forKey:@"title"];
    [postObject setObject:[AVUser currentUser] forKey:@"user"];
    
    [postObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            self.post.objectId = [postObject objectId];
            self.post.content = [postObject valueForKey:@"content"];
            
            PostDetailViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PostDetailViewController"];
            controller.post = self.post;
            
            UINavigationController* navigationController = self.navigationController;
            [navigationController popToRootViewControllerAnimated:NO];
            [navigationController pushViewController:controller animated:YES];
            
            controller.hidesBottomBarWhenPushed = YES;
        }
    }];
}

@end
