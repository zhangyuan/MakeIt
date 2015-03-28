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
#import "SWTableViewCell.h"
#import "NSMutableArray+SWUtilityButtons.h"

@interface PostListTableViewController() <SWTableViewCellDelegate>
@end

@implementation PostListTableViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [self.refreshControl beginRefreshing];
    [self refreshPosts: self.refreshControl];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PostListTableCell";

    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[SWTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.rightUtilityButtons = [self rightButtons];

        cell.delegate = self;
    }

    Post* post = [self.posts objectAtIndex:indexPath.row];
    cell.textLabel.text = post.title;
    cell.detailTextLabel.text = @"";
    
    return cell;
}

-(NSArray*) rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                icon: [UIImage imageNamed:@"delete.png"]];
    
    return rightUtilityButtons;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPostDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PostDetailViewController *destViewController = segue.destinationViewController;
        destViewController.post = [self.posts objectAtIndex:indexPath.row];
    }
    
    UIViewController* controller = segue.destinationViewController;
    controller.hidesBottomBarWhenPushed = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showPostDetail" sender:self];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    Post* post = self.posts[indexPath.row];
    [post deleteInBackground];
    [self.posts removeObject:post];
    
    NSArray* indexPaths = [NSArray arrayWithObjects:indexPath, nil];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (IBAction)refreshPosts:(UIRefreshControl*)sender {
    AVQuery *query = [AVQuery queryWithClassName:@"Post"];
    [query whereKey:@"user" equalTo:[AVUser currentUser]];
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.posts  = [NSMutableArray arrayWithCapacity:objects.count];
            for (int i = 0; i < objects.count; i++) {
                AVObject* object = objects[i];
                Post* post = [[Post alloc] init];
                post.avObject = object;
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
