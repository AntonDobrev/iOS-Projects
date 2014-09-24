	//
//  LoginViewController.m
//  EverliveSDK
//
//  Created by Mehfuz Hossain on 7/5/13.
//  Copyright (c) 2013 Telerik AD. All rights reserved.
//

#import "LoginViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "TKUITextField.h"
#import <EverliveSDK/EverliveSDK.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MBProgressHUD.h"
#import "TKUIButton.h"
#import <LiveSDK/LiveConnectClient.h>
#import <GooglePlus/GooglePlus.h>
#import <EQATECAnalyticsMonitoriOS/EQATECAnalyticsMonitor.h>
@interface LoginViewController ()
{
    TKUITextField *activeField;
}
@end

@implementation LoginViewController


// invoke this method in the view will load event
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// call this method when the view will disappear
- (void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(TKUITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(TKUITextField *)textField
{
    activeField = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loginButton.text = @"Login";
    self.loginButton.delegate = self;
    
    
    self.signUpButton.text = @"Don't have an account?";
    self.signUpButton.delegate = self;
    
    
    self.facebookLoginButton.icon = [UIImage imageNamed:@"icon-facebook.png"];
    self.facebookLoginButton.delegate = self;
    
    self.adfsLoginButton.icon = [UIImage imageNamed:@"icon-adfs.png"];
    self.adfsLoginButton.delegate = self;
    
    self.googleLoginButton.icon =[UIImage imageNamed:@"icon-google.png"];
    self.googleLoginButton.delegate = self;
    
    self.liveIDLoginButton.icon = [UIImage imageNamed:@"icon-liveid.png"];
    self.liveIDLoginButton.delegate = self;
}


-(void)viewDidDisappear:(BOOL)animated{
    
    if(self.monitor){
        [self.monitor stop];
    }
    [self unregisterForKeyboardNotifications];
}

-(void)viewDidAppear:(BOOL)animated{
    //init analytics
    NSString *version = @"1.2.3";
    NSString *productID =[[NSBundle mainBundle]objectForInfoDictionaryKey:@"analyticsProductID"];
    if(productID && ![productID isEqual:@""]){
        self.monitor = [EQATECAnalyticsMonitor monitorWithProductId:productID version:version];
        [self.monitor start];
    }
}

- (void)buttonClicked:(id)sender
{
    
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];

    [[FBSession  activeSession] closeAndClearTokenInformation];
    	
    if ([sender isEqual:self.loginButton]){
        [self trackFeatureInAnalytics:@"Login.Regular"];
        if([_usernameTextField validate] && [_passwordTextField validate]){
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.labelText = @"Please wait";
            
            [EVUser loginInWithUsername:_usernameTextField.text password:_passwordTextField.text block:^(EVUser *user, NSError *error) {
                [self loginUser:user error:error];
            }];
        }
    }
    else if([sender isEqual:self.adfsLoginButton]){
        [self trackFeatureInAnalytics:@"Login.ADFS"];
        [self performSegueWithIdentifier:@"adfsLoginSegue" sender:self];
    }
    else if ([sender isEqual:self.facebookLoginButton]){
        [self trackFeatureInAnalytics:@"Login.Facebook"];
        NSArray *permissions = [[NSArray alloc] initWithObjects: @"email",nil];
        [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
             [self sessionStateChanged:session state:state error:error];
        }];
    }
    else if ([sender isEqual:self.liveIDLoginButton]){
        [self trackFeatureInAnalytics:@"Login.LiveID"];
        self.liveClient =[[LiveConnectClient alloc] initWithClientId:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"LiveIDClientID"] delegate:self userState:@"initialize"];
    }
    else if ([sender isEqual:self.signUpButton]){
        self.navigationItem.title = nil;
        [self performSegueWithIdentifier:@"ShowSignUp" sender:self];
    }
    else if ([sender isEqual:self.googleLoginButton]){
        [self trackFeatureInAnalytics:@"Login.Google"];
        
        
        GPPSignIn *signIn = [GPPSignIn sharedInstance];
        signIn.shouldFetchGooglePlusUser = YES;
        signIn.shouldFetchGoogleUserEmail = YES;
        signIn.clientID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"GoogleClientID"];
        signIn.scopes = @[ @"profile" ];
        signIn.delegate = self;
        
        [signIn authenticate];
    }
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error){
                self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                self.hud.labelText = @"Logging In";
                
                [EVUser loginWithFacebook:session.accessTokenData.accessToken block:^(EVUser *user, NSError *error) {
                    [self loginUser:user error:error];
                }];
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    if (error){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)loginUser:(EVUser*)user error:(NSError*)error
{
    [self.hud hide:YES];
    
    if (error == nil && [user isAuthenticated]){
        [self.navigationItem setTitle:@"Log out"];
        [self performSegueWithIdentifier:@"ShowActivities" sender:self];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self registerForKeyboardNotifications];
}

//Google
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    NSLog(@"Received error %@ and auth object %@",error, auth);
    [EVUser loginWithGoogle:auth.accessToken block:^(EVUser *user, NSError *error) {
        [self loginUser:user error:error];
    }];
}
//Faceboook
- (void)authCompleted:(LiveConnectSessionStatus) status
              session:(LiveConnectSession *) session
            userState:(id) userState
{
    if ([userState isEqual:@"initialize"])
    {
        [self.liveClient login:self scopes:[NSArray arrayWithObjects:@"wl.basic",@"wl.emails",nil] delegate:self userState:@"signin"];
    }
    if ([userState isEqual:@"signin"])
    {
        if (session != nil)
        {
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.labelText = @"Logging In";
            
            [EVUser loginWithLiveId:session.accessToken block:^(EVUser *user, NSError *error) {
                [self loginUser:user error:error];
            }];
        }
    }
}

//Live ?
- (void)authFailed:(NSError *) error
         userState:(id)userState
{
   // [self.infoLabel setText:[NSString stringWithFormat:@"Error: %@", [error localizedDescription]]];
}

-(void) trackFeatureInAnalytics:(NSString*) feature{
    NSString *productID = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"analyticsProductID"];
    if(productID && ![productID isEqual:@""]){
        [self.monitor trackFeature:feature];
    }
}

@end
