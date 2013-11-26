//
//  LoginViewController.h
//  EverliveForum
//
//  Created by Tony on 25.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *labelUsername;
@property (strong, nonatomic) IBOutlet UILabel *labelPassword;
@property (strong, nonatomic) IBOutlet UITextField *usernameTexField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *buttonLogin;
@property (strong, nonatomic) IBOutlet UIButton *buttonRegister;


@end
