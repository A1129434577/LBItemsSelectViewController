# LBItemsSelectViewController
```objc
LBItemsSelectViewController *homeMorePopover = [[LBItemsSelectViewController alloc] init];
homeMorePopover.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
homeMorePopover.popPC.backgroundColor = [UIColor blackColor];
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
```
![]()
