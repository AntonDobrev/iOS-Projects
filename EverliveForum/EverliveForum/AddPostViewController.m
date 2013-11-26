//
//  AddPostViewController.m
//  EverliveForum
//
//  Created by Tony on 26.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import "AddPostViewController.h"
#import "Posts.h"

@interface AddPostViewController ()

@end

@implementation AddPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

- (IBAction)save:(id)sender {
    
    Posts *postToAdd = [[Posts alloc]init];
    
    [postToAdd setTitle:_titleText.text];
    [postToAdd setContent:_contentText.text];
    [postToAdd setUserId:[[EVUser currentUser] id]];
    
    [postToAdd create:^(BOOL success, NSError *error) {
        
        if (success){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
