//
//  ViewController.m
//  LBTextFieldDemo
//
//  Created by 刘彬 on 2019/9/24.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "ViewController.h"
#import "LBItemsSelectViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"LBItemsSelectViewController";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下拉菜单" style:UIBarButtonItemStylePlain target:self action:@selector(dropDownMenu:)];
    
    
    
}
-(void)dropDownMenu:(UIBarButtonItem *)item{
    LBItemsSelectViewController *homeMorePopover = [[LBItemsSelectViewController alloc] init];
    homeMorePopover.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    homeMorePopover.popPC.backgroundColor = [UIColor lightGrayColor];
    homeMorePopover.cellHeight = 35;
    homeMorePopover.textColor = [UIColor whiteColor];
    LBItem *item1 = [LBItem itemWithTitle:@"我的消息"];
    LBItem *item2 = [LBItem itemWithTitle:@"系统设置"];
    item2.image = [UIImage imageNamed:@"img_+"];
    homeMorePopover.items = @[item1,item2];
    homeMorePopover.popPC.barButtonItem = item;
    homeMorePopover.popPC.sourceView = self.view;
    homeMorePopover.preferredContentSize = CGSizeMake(100, homeMorePopover.cellHeight*homeMorePopover.items.count);
    [self presentViewController:homeMorePopover animated:YES completion:NULL];
    
    homeMorePopover.selectedItem = ^(NSObject<LBSelectItemsProtocol> * _Nonnull item) {
        NSLog(@"%@",item.title);
    };
}
@end
