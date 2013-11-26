//
//  PostDetailsViewController.m
//  EverliveForum
//
//  Created by Tony on 26.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import "PostDetailsViewController.h"

@interface PostDetailsViewController ()
@property (strong, nonatomic) IBOutlet UIView *postDetailsView;

@end

@implementation PostDetailsViewController

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
    self.postTitleNavigationItem.title = [self.currentPost title];
    self.postContentTextView.text = [self.currentPost content];
    self.postContentTextView.editable = NO;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
   // dateField.text = [df stringFromDate:[self.currentPost createdAt]];
}

- (void)viewDidUnload
{
//    [self setTitleField:nil];
//    [self setAuthorField:nil];
//    [self setDateField:nil];
//    [self setEditButton:nil];
//    [self setDoneButton:nil];
//    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
@end
