//
//  PostTitleViewController.h
//  MakeIt
//
//  Created by zhangyuan on 2/16/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PostTitleViewController : UIViewController

@property (nonatomic, strong) Post* post;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextButtonItem;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;

@end
