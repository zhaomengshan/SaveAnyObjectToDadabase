//
//  Shop.h
//  将任意对象存进数据库
//
//  Created by 杨蒙 on 16/2/9.
//  Copyright © 2016年 杨蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) double price;

@end
