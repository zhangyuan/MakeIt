//
//  Post.m
//  MakeIt
//
//  Created by zhangyuan on 2/3/15.
//  Copyright (c) 2015 NextCloudMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@implementation Post

-(NSString*) url {
    if (self.objectId) {
        static NSString* server = @"http://makeit.avosapps.com";
        return [NSString stringWithFormat:@"%@/posts/%@", server, self.objectId];
    }
    return nil;
}

@end
