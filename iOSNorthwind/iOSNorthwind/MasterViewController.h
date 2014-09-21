//
//  MasterViewController.h
//  iOSNorthwind
//
//  Created by Tony on 24/05/2014.
//  Copyright (c) 2014 com.dobrev.iosnorthwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EverliveSDK/EverliveSDK.h>

@interface MasterViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *categoriesTableView;


@end
