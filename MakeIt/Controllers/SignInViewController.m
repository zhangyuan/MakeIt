//
//  SignInViewController.m
//  MakeIt
//
//  Created by zhangyuan on 3/28/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "SignInViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <Toast/UIView+Toast.h>

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signIN:(id)sender {
    NSString* username = self.usernameTextField.text;
    NSString* password = self.passwordTextField.text;
    
    if (username.length == 0 || password.length == 0) {
        return;
    }
    
    
    [AVUser logInWithUsernameInBackground: username password:password block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [sb instantiateInitialViewController];
            vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:vc animated:YES completion:NULL];
        } else {
            [self.view makeToast: error.localizedDescription];
        }
    }];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
