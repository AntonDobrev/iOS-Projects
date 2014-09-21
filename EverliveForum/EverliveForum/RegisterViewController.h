//
//  RegisterViewController.h
//  EverliveForum
//
//  Created by Tony on 26.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *usernameRegisterLabel;
@property (strong, nonatomic) IBOutlet UITextField *usernameRegisterTextField;
@property (strong, nonatomic) IBOutlet UILabel *passwordRegisterLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordRegisterTextField;
@property (strong, nonatomic) IBOutlet UILabel *emailRegisterLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailRegisterTextField;
@property (strong, nonatomic) IBOutlet UIButton *confirmRegisterButton;
@property (strong, nonatomic) IBOutlet UILabel *aboutLabel;
@property (strong, nonatomic) IBOutlet UITextField *aboutTextField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
