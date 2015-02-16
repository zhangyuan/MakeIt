//
//  EditorViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "ComposeViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <CTAssetsPickerController.h>


@implementation ComposeViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarBold, ZSSRichTextEditorToolbarTextColor, ZSSRichTextEditorToolbarInsertImage];
    NSString *html = @"";
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
    [postObject setObject:self.post.title forKey:@"title"];
    
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
    [self dismissViewControllerAnimated:YES completion:nil];
    for (int i = 0; i < [assets count]; i++) {
        ALAsset* asset = assets[i];
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        Byte *buffer = (Byte*)malloc(rep.size);
        NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
        NSData *imageData = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
        
        AVFile *imageFile = [AVFile fileWithName:@"PostPhoto.jpg" data:imageData];
        [imageFile save];
        
        NSLog(@"%s:%@", __FUNCTION__,imageFile);
        
        AVObject *postPhoto = [AVObject objectWithClassName:@"PostPhoto"];
        [postPhoto setObject:imageFile forKey:@"imageFile"];
        [postPhoto save];
        
        [self insertImage:imageFile.url alt:@""];
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    return (picker.selectedAssets.count < 2);
}

@end
