//
//  ViewController.m
//  FZCategory
//
//  Created by Florence on 2017/5/11.
//  Copyright © 2017年 AllureTeartop. All rights reserved.
//

#import "ViewController.h"
#import "FZCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *sss = @"370883211509104419";
    BOOL is =  sss.fz_isIdentityCard;
    
    
    NSLog(@"%@",is);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
