//
//  Tags.h
//  EverliveForum
//
//  Created by Tony on 25.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import <EverliveSDK/EverliveSDK.h>

@interface Tags : EVObject
@property(strong, nonatomic) NSString *text;
@property(strong, nonatomic) NSArray *posts;
@end
