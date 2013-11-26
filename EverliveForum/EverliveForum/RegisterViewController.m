//
//  RegisterViewController.m
//  EverliveForum
//
//  Created by Tony on 26.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import "RegisterViewController.h"
#import "EverliveSDK/EverliveSDK.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonConfirmRegisterClick:(id)sender {
    if ([sender isEqual:self.confirmRegisterButton]){
        
        EVUser *newUser = [[EVUser alloc]init];
        
        [newUser setUsername:_usernameRegisterTextField.text];
        [newUser setPassword:_passwordRegisterTextField.text];
        [newUser setDisplayName:_usernameRegisterTextField.text];
        [newUser setEmail:_emailRegisterTextField.text];
        
        [newUser signUp:^(EVUser *user, NSError *error) {
            if (error == nil){
                [EVUser loginInWithUsername:user.username password:_passwordRegisterTextField.text block:^(EVUser *user, NSError *error) {
                    [self performSegueWithIdentifier:@"ShowAllPosts" sender:self];
                }];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            }
        }];
    }

}

- (void)buttonClicked:(id)sender
{
    }

@end
