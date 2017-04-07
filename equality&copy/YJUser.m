//
//  YJUser.m
//  equality&copy
//
//  Created by mervin on 2017/4/7.
//
//

#import "YJUser.h"

@implementation YJUser


-(instancetype)initWithUserId:(NSInteger)userId name:(NSString *)name {
    if (self = [super init]) {
        _userId = userId;
        _name = [name copy];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    YJUser *user = [[YJUser allocWithZone:zone] initWithUserId:_userId name:_name];
    return user;
}

-(BOOL)isEqual:(id)object {
    NSLog(@"self invoke isEqual:%@",self);
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    YJUser *otherUser = (YJUser *)object;
    BOOL haveEqualId = otherUser.userId == self.userId;
    BOOL haveEqualName = (!self.name && !otherUser.name) || [otherUser.name isEqualToString:otherUser.name];
    
    return haveEqualId && haveEqualName;
}


- (NSUInteger)hash {
    NSLog(@"%@  hash:%ld",self,[super hash]);
    return self.userId ^ [self.name hash];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%p, userid:%ld, nama: %@", self,_userId, _name];
}

@end
