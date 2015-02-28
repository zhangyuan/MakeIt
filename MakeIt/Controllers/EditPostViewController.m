//
//  EditPostViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/19/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "EditPostViewController.h"
#import "PostDetailViewController.h"
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
