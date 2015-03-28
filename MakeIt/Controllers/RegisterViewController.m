//
//  RegisterViewController.m
//  MakeIt
//
//  Created by zhangyuan on 3/28/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import "RegisterViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <Toast/UIView+Toast.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)register:(id)sender {
    if(self.emailTextField.text.length == 0
       || self.passwordTextField.text.length == 0
       || self.passwordConfirmationTextField.text.length == 0
       || self.usernameTextField.text.length == 0){
        return;
    }
    
    if(![self.passwordConfirmationTextField.text isEqualToString:self.passwordTextField.text]){
        return;
    }
    
    AVUser *user = [AVUser user];
    user.username = self.usernameTextField.text;
    user.password =  self.passwordConfirmationTextField.text;
    user.email = self.emailTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [sb instantiateInitialViewController];
            vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:vc animated:YES completion:NULL];
        } else {
            [self.view makeToast: error.localizedDescription];
        }
    }];
}

@end
