//
//  PostTitleViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/16/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "PostTitleViewController.h"
#import "CreatePostViewController.h"

@implementation PostTitleViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (!self.post) {
        self.post = [[Post alloc] init];
    }
    if ([segue.identifier isEqualToString:@"composePost"]) {
        self.post.title = self.titleTextField.text;
        CreatePostViewController* controller = segue.destinationViewController;
        controller.post = self.post;
    }
}

@end
