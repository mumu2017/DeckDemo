//
//  ViewController.m
//  DeckDemo
//
//  Created by 陈林 on 16/8/18.
//  Copyright © 2016年 Chen Lin. All rights reserved.
//

#import "ViewController.h"
#import "CardsController.h"
#import "CLFullStackVC.h"
#import "CLDeckVC.h"
#import "CLStackVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%s", __func__);

    
    CLStackVC *vc = [[CLStackVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
