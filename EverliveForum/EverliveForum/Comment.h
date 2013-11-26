//
//  Comment.h
//  EverliveForum
//
//  Created by Tony on 25.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import <EverliveSDK/EverliveSDK.h>

@interface Comment : EVObject
@property(strong, nonatomic) NSString *comment;
@property(strong, nonatomic) NSString *userId;
@property(strong, nonatomic) NSString *postId;
@end
