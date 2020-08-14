//
//  LoginViewController.m
//  ParseChat
//
//  Created by Kaitlyn Gunadhi on 7/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passField;

@end

@implementation LoginViewController

- (IBAction)registerUser:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.userField.text;
    newUser.password = self.passField.text;
    
    UIAlertController *emptyAlert = [UIAlertController alertControllerWithTitle:@"Invalid Username or Password"
           message:@"Username or password field is empty."
    preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {}];

    [emptyAlert addAction:okAction];
    
    if ([self.userField.text isEqual:@""] || [self.passField.text isEqual:@""]) {
        [self presentViewController:emptyAlert animated:YES completion:^{}];
    } else {
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                
                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Sign Up Error"
                                                                                    message:error.localizedDescription
                preferredStyle:(UIAlertControllerStyleAlert)];
                [errorAlert addAction:okAction];
                [self presentViewController:errorAlert animated:YES completion:^{}];
            } else {
                NSLog(@"User registered successfully");
                
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
    }
}

- (IBAction)loginUser:(id)sender {
    NSString *username = self.userField.text;
    NSString *password = self.passField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            
            UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Login Error"
                                                                                message:error.localizedDescription
            preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {}];
            [errorAlert addAction:okAction];
            [self presentViewController:errorAlert animated:YES completion:^{}];
        } else {
            NSLog(@"User logged in successfully");
            
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
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
