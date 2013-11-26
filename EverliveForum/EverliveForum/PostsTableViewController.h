//
//  PostsTableViewController.h
//  EverliveForum
//
//  Created by Tony on 26.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EverliveSDK/EverliveSDK.h>

@interface PostsTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *postsTableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addPostButton;
@end
