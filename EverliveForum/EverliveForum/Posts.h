//
//  Posts.h
//  EverliveForum
//
//  Created by Tony on 25.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import <EverliveSDK/EverliveSDK.h>

@interface Posts : EVObject
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *content;
@property(strong, nonatomic) NSString *userId;
@property(strong, nonatomic) NSArray *comments;
@end
