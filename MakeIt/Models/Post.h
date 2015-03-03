//
//  Header.h
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#ifndef MakeIt_Post_h
#define MakeIt_Post_h

#import <AVOSCloud/AVOSCloud.h>

@interface Post : NSObject

@property (nonatomic, copy) NSString* objectId;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, strong) AVObject* avObject;

-(NSString*) url;
-(void) deleteInBackground;

@end

#endif
