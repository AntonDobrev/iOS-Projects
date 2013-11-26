//
//  PostDetailsViewController.h
//  EverliveForum
//
//  Created by Tony on 26.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Posts.h"
@interface PostDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationItem *postTitleNavigationItem;
@property (strong, nonatomic) IBOutlet UITextView *postContentTextView;
@property (nonatomic, strong) Posts *currentPost;
@end
