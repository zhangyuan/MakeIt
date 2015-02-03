//
//  PostListTableViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "PostListTableViewController.h"
#import "Post.h"
 #import <AVOSCloud/AVOSCloud.h>

@implementation PostListTableViewController

-(void) viewDidLoad {
    [super viewDidLoad];

    AVQuery *query = [AVQuery queryWithClassName:@"Post"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.posts  = [NSMutableArray arrayWithCapacity:objects.count];
            for (int i = 0; i < objects.count; i++) {
                AVObject* object = objects[i];
                Post* post = [[Post alloc] init];
                post.objectId = [object objectId];
                
                [self.posts addObject:post];
            }
            
            [self.tableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post* post = [self.posts objectAtIndex:indexPath.row];
    
    static NSString *simpleTableIdentifier = @"PostListTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = post.objectId;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}


@end
