//
//  DetailViewController.h
//  iOSNorthwind
//
//  Created by Tony on 24/05/2014.
//  Copyright (c) 2014 com.dobrev.iosnorthwind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
