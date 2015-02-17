//
//  PostDetailViewController.h
//  MakeIt
//
//  Created by zhangyuan on 2/6/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PostDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) Post* post;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuButtonItem;

@end
