//
//  LoginViewController.m
//  EverliveForum
//
//  Created by Tony on 25.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import "LoginViewController.h"
#import <EverliveSDK/EverliveSDK.h>

@interface LoginViewController ()
{
    
}
@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)loginButtonTap:(id)sender {
    
    [EVUser loginInWithUsername:_usernameTexField.text password:_passwordTextField.text block:^(EVUser *user, NSError *error) {
        [self loginUser:user error:error];
    }];
    
}
- (IBAction)registerButtonTap:(id)sender {
    [self performSegueWithIdentifier:@"ShowSignUp" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginUser:(EVUser*)user error:(NSError*)error
{
    
    if (error == nil && [user isAuthenticated]){
        _usernameTexField.text = nil;
        _passwordTextField.text = nil;
        [self performSegueWithIdentifier:@"ShowAllPosts" sender:self];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

@end
