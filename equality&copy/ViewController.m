//
//  ViewController.m
//  equality&copy
//
//  Created by mervin on 2017/4/7.
//
//

#import "ViewController.h"
#import "YJUser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)someaboutcopy:(id)sender {
    
    NSString *string = @"Stronger";
    NSString *copyString = [string copy];
    NSString *mutableCopyString = [string mutableCopy];
    NSLog(@"\nstring= %p, copyString= %p, mutableCopyString= %p", string, copyString, mutableCopyString);
    
    NSMutableString *string2 = [NSMutableString stringWithFormat:@"Stronger"];
    NSString *copyString2 = [string2 copy];
    NSMutableString *mutableCopyString2 = [string2 mutableCopy];
    NSLog(@"\nstring2= %p, copyString2= %p, mutableCopyString2= %p", string2, copyString2, mutableCopyString2);
    
    YJUser *user = [[YJUser alloc] initWithUserId:1122 name:@"joy"];
    YJUser *userCopy = [user copy];
    NSLog(@"\nuser1:%p\nuser2:%p",user,userCopy);
    
    NSMutableString *desc = [NSMutableString stringWithFormat:@"What doesn's kill you "];
    
    YJUser *person = [[YJUser alloc] init];
    person.desc = desc;
    
    // 可以改变person.name的值，因为其内部没有生成新的对象
    [desc appendString:@" make you stronger"];
    
    NSLog(@"name = %@", person.desc);

    
    
    
}
- (IBAction)copy_strong:(id)sender {
    NSMutableString *desc = [NSMutableString stringWithFormat:@"What doesn's kill you "];
    
    YJUser *person = [[YJUser alloc] init];
    person.desc = desc;
    
    // 可以改变person.name的值，因为其内部没有生成新的对象
    [desc appendString:@" make you stronger"];
    
    NSLog(@"name = %@", person.desc);
    
}



- (IBAction)equality:(id)sender {
    YJUser *u1 = [[YJUser alloc] initWithUserId:1122 name:@"jack"];
    YJUser *u2 = [[YJUser alloc] initWithUserId:1122 name:@"joy"];
    YJUser *u3 = [[YJUser alloc] initWithUserId:1122 name:@"jack"];
    YJUser *u4 = [[YJUser alloc] initWithUserId:2233 name:@"jack"];
    NSArray *users = @[u1, u2, u3, u4];
    NSLog(@"%@",users);
    
    NSLog(@"\n==========Array============");
    NSMutableArray *array = @[].mutableCopy;
    for (YJUser *user in users) {
        if (![array containsObject:user]) {
            [array addObject:user];
        }
    }
    NSLog(@"array:: %@\n", array);
    
    NSLog(@"\n==========Set==============");
    NSSet *set = [[NSSet alloc] initWithArray:users];
    NSLog(@"set:: %@\n", set);
    
    NSLog(@"\n==========Dictionary=======");
    NSMutableDictionary *dic = @{}.mutableCopy;
    NSLog(@"for obj");
    [dic setObject:u1 forKey:@"admin"];
    NSLog(@"for obj");
    NSLog(@"for key");
    [dic setObject:@"admin" forKey:u1];
    NSLog(@"for key");
    
    NSLog(@"dic:: %@",dic);
}


@end
