//
//  Categories.h
//  iOSNorthwind
//
//  Created by Tony on 25/05/2014.
//  Copyright (c) 2014 com.dobrev.iosnorthwind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EverliveSDK/EverliveSDK.h>

@interface Categories : EVObject

@property(nonatomic, strong) NSString *categoryName;
@property(nonatomic, strong) NSString *description;

@end
