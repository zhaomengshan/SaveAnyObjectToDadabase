//
//  Shop.m
//  将任意对象存进数据库
//
//  Created by 杨蒙 on 16/2/9.
//  Copyright © 2016年 杨蒙. All rights reserved.
//

#import "Shop.h"

@implementation Shop
#pragma mark 编码
-(void)encodeWithCoder:(NSCoder *)enCoder {
    [enCoder encodeObject:self.name forKey:@"name"];
    [enCoder encodeDouble:self.price forKey:@"price"];
}
#pragma mark 解码
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.price = [decoder decodeDoubleForKey:@"price"];
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@--%f",self.name, self.price];
}

@end
