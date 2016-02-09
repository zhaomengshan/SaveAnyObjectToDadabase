//
//  ViewController.m
//  将任意对象存进数据库
//
//  Created by 杨蒙 on 16/2/9.
//  Copyright © 2016年 杨蒙. All rights reserved.
//

#import "ViewController.h"
#import "Shop.h"
#import "FMDB.h"

@interface ViewController ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据库
    [self initDatabase];
    //添加数据
    [self addShops];
    //读取数据
    [self readShos];
}

#pragma mark 初始化数据库
-(void)initDatabase {
    //初始化
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shop.sqlite"];
    self.db = [FMDatabase databaseWithPath:path];
    [self.db open];
    //创表
    //数据库中blob是二进制对象
   [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shop(id integer PRIMARY KEY, shop blob NOT NULL)"];
}

#pragma mark 读取数据
-(void)readShos {
    FMResultSet *set = [self.db executeQuery:@"SELECT * FROM t_shop LIMIT 10;"];
    while (set.next) {
        NSData *data = [set objectForColumnName:@"shop"];
        Shop *shop = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"%@---%f",shop.name, shop.price);
    }
}

#pragma mark 添加数据
- (void)addShops {
    for (int i = 0; i < 1000; i++) {
        Shop *shop = [[Shop alloc] init];
        shop.name = [NSString stringWithFormat:@"商品--%d", i];
        shop.price = arc4random() % 10000;
        //要将一个对象存进数据库的blob字段，最先转化为NSData
        //一个对象要遵守NSCoding协议，实现协议中相应的方法，才能转化为NSData
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:shop];
        [self.db executeUpdateWithFormat:@"INSERT INTO t_shop(shop) VALUES (%@);",data];
    }
}

@end
