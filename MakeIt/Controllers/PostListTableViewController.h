//
//  PostListTableViewController.h
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostListTableViewController : UITableViewController
- (IBAction)refreshPosts:(UIRefreshControl*)sender;
@property (nonatomic, strong) NSMutableArray* posts;
@end
