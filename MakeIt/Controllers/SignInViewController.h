//
//  SignInViewController.h
//  MakeIt
//
//  Created by zhangyuan on 3/28/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end
