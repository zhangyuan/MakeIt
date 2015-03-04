//
//  EditorViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import <CTAssetsPickerController.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "PostEditorViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UIImage+ResizeMagick.h"


@implementation PostEditorViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.formatHTML = NO;
    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarBold, ZSSRichTextEditorToolbarTextColor, ZSSRichTextEditorToolbarInsertImage];
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
    [self dismissViewControllerAnimated:YES completion:nil];
    [self uploadImages:assets atIndex:0];
}

-(void) uploadImages:(NSArray *)assets atIndex:(int) current {
    if (current < [assets count]) {
        ALAsset* asset = assets[current];
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        Byte *buffer = (Byte*)malloc(rep.size);
        NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
        NSData *imageData = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];

        NSLog(@"imageData = %ld", imageData.length);
        
        NSData *targetImageData;
        
        //300 KB
        if (imageData.length < 300 * 1024) {
            targetImageData = imageData;
        } else {
            UIImage* image = [UIImage imageWithData:imageData scale: (300 * 1024) / imageData.length];
            UIImage* targetImage = [image resizedImageByWidth: 320];
            targetImageData = UIImagePNGRepresentation(targetImage);
        }
        
        NSLog(@"targetImageData = %ld", targetImageData.length);

        AVFile *imageFile = [AVFile fileWithName:@"PostPhoto.jpg" data:targetImageData];

        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            AVObject *postPhoto = [AVObject objectWithClassName:@"PostPhoto"];
            [postPhoto setObject:imageFile forKey:@"imageFile"];
            [postPhoto save];

            [self insertImage:imageFile.url alt:@""];

            [self uploadImages:assets atIndex:(current+1)];
        } progressBlock:^(NSInteger percentDone) {

        }];
    } else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    return (picker.selectedAssets.count < 5);
}

@end
