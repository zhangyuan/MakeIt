//
//  Header.h
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#ifndef MakeIt_Post_h
#define MakeIt_Post_h

@interface Post : NSObject

@property (nonatomic, copy) NSString* objectId;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* content;

-(NSString*) url;

@end

#endif
