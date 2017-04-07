//
//  YJUser.h
//  equality&copy
//
//  Created by mervin on 2017/4/7.
//
//

#import <Foundation/Foundation.h>

@interface YJUser : NSObject<NSCopying>

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong)NSString *desc;
-(instancetype)initWithUserId:(NSInteger)userId name:(NSString *)name;

@end
