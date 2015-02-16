//
//  EditorViewController.h
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "ZSSRichTextEditor.h"
#import "Post.h"
#import <CTAssetsPickerController.h>

@interface ComposeViewController : ZSSRichTextEditor  <CTAssetsPickerControllerDelegate>

@property (nonatomic, strong) Post* post;

@end
