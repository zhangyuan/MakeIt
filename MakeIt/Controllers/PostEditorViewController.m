//
//  EditorViewController.m
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "PostEditorViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <CTAssetsPickerController.h>
#import "UIImage+ResizeMagick.h"


@implementation PostEditorViewController

-(void) viewDidLoad {
    [super viewDidLoad];
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
    NSLog(@"%s:%@", __FUNCTION__, assets);
    [self dismissViewControllerAnimated:YES completion:nil];
    for (int i = 0; i < [assets count]; i++) {
        ALAsset* asset = assets[i];
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        Byte *buffer = (Byte*)malloc(rep.size);
        NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
        NSData *imageData = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
        
        UIImage* image = [UIImage imageWithData:imageData scale:0.4];
        UIImage* resizedImage = [image resizedImageByWidth: 320];
        
        NSData *resizedImageData = UIImagePNGRepresentation(resizedImage);
        AVFile *imageFile = [AVFile fileWithName:@"PostPhoto.jpg" data:resizedImageData];
        [imageFile save];
        
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
