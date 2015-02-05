//
//  EditorViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "EditorViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <CTAssetsPickerController.h>


@implementation EditorViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarBold, ZSSRichTextEditorToolbarTextColor, ZSSRichTextEditorToolbarInsertImage];
    
    NSString *html = @"";
    self.post = [[Post alloc] init];
    
    [self setHTML:html];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    AVObject* postObject;
    
    if (self.post.objectId) {
        NSLog(@"Save");
        postObject = [AVObject objectWithoutDataWithClassName:@"Post" objectId:self.post.objectId];
    } else {
        NSLog(@"Create");
        postObject = [AVObject objectWithClassName:@"Post"];
    }
    
    [postObject setObject:[self getHTML] forKey:@"content"];
    [postObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            self.post.objectId = [postObject objectId];
        }
    }];
}

- (void)showInsertImageDialogWithLink:(NSString *)url alt:(NSString *)alt {
    [self dismissAlertView];
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showsNumberOfAssets = NO;
    picker.delegate = self;
   [self presentViewController:picker animated:YES completion:nil];
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    NSLog(@"%s:%@", __FUNCTION__, assets);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    return (picker.selectedAssets.count < 2);
}

@end
