//
//  AddPostViewController.h
//  EverliveForum
//
//  Created by Tony on 26.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Posts.h"

@interface AddPostViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (strong, nonatomic) IBOutlet UITextView *contentText;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *savePostButton;
- (IBAction)save:(id)sender;

@end

