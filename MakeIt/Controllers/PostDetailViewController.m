//
//  PostDetailViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/6/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "PostDetailViewController.h"
#import "EditPostViewController.h"
#import "WXApi.h"

@implementation PostDetailViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    NSString* urlString = [self.post url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (IBAction)menuButtonClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Action"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Edit", @"Copy URL", @"Forward to WeChat Friends", @"Forward to WeChat Moments", nil];
    
    [actionSheet showInView:self.view];
}

-(void) copyUrlToClipboard {
    NSString* url = [self.post url];
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString: url];
    
    UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"URL Copied" message: url delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [messageAlert show];
}

-(void) forwardToWechatFriends {
    [self forwardToWeChat:WXSceneSession];
}

-(void) forwardToWechatMoments {
    [self forwardToWeChat:WXSceneTimeline];
}

-(void) forwardToWeChat:(int) scene {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.post.title;

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = self.post.url;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"editPost" sender:self];
    } else if (buttonIndex == 1) {
        [self copyUrlToClipboard];
    } else if (buttonIndex == 2) {
        [self forwardToWechatFriends];
    } else if (buttonIndex == 3) {
        [self forwardToWechatMoments];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editPost"]) {
        EditPostViewController *destViewController = segue.destinationViewController;
        NSLog(@"%s:%@", __FUNCTION__, self.post.content);
        destViewController.post = self.post;
//        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

- (IBAction)swipe:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
