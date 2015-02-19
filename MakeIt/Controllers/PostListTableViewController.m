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
#import "PostDetailViewController.h"

@implementation PostListTableViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [self.refreshControl beginRefreshing];
    [self refreshPosts: self.refreshControl];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post* post = [self.posts objectAtIndex:indexPath.row];
    
    static NSString *simpleTableIdentifier = @"PostListTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = post.title;
    cell.detailTextLabel.text = @"";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPostDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PostDetailViewController *destViewController = segue.destinationViewController;
        destViewController.post = [self.posts objectAtIndex:indexPath.row];
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

- (IBAction)refreshPosts:(UIRefreshControl*)sender {
    AVQuery *query = [AVQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.posts  = [NSMutableArray arrayWithCapacity:objects.count];
            for (int i = 0; i < objects.count; i++) {
                AVObject* object = objects[i];
                Post* post = [[Post alloc] init];
                post.objectId = [object objectId];
                post.title = [object valueForKey:@"title"];
                post.content =[object valueForKey:@"content"];
                
                [self.posts addObject:post];
            }
            
            [self.tableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [sender endRefreshing];
    }];
}
@end
