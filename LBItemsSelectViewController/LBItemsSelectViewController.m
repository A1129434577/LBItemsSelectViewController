//
//  DropDownViewController.m
//  moonbox
//
//  Created by 刘彬 on 2019/1/8.
//  Copyright © 2019 张琛. All rights reserved.
//

#import "LBItemsSelectViewController.h"

@interface LBItemsSelectCell : UITableViewCell
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel *titleLabel;
@end

@implementation LBItemsSelectCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.icon = [[UIImageView alloc] init];
        [self addSubview:self.icon];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.titleLabel];
    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.icon.frame = CGRectMake(self.layoutMargins.left, self.layoutMargins.top, self.icon.image?CGRectGetHeight(frame)-self.layoutMargins.top-self.layoutMargins.bottom:0, CGRectGetHeight(frame)-self.layoutMargins.top-self.layoutMargins.bottom);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.icon.frame)+(self.icon.image?5:0), CGRectGetMinY(self.icon.frame), CGRectGetWidth(frame)-CGRectGetMaxX(self.icon.frame)-10, CGRectGetHeight(self.icon.frame));
    
    if (self.icon.image) {
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
    }else{
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}
@end

@interface LBItemsSelectViewController ()<UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation LBItemsSelectViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        _popPC = self.popoverPresentationController;
        _popPC.delegate = self;
    }
    return self;
}
-(UIModalPresentationStyle )adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;//不适配
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setSeparatorInset:(UIEdgeInsets)separatorInset{
    _separatorInset = separatorInset;
    [_tableView reloadData];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
- (void)setCellHeight:(CGFloat)cellHeight{
    _cellHeight = cellHeight;
    [_tableView reloadData];
}

-(void)setItems:(NSArray<NSObject<LBSelectItemsProtocol> *> *)items{
    _items = items;
    [_tableView reloadData];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"DROP_DOWN_CELL";
    LBItemsSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LBItemsSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.separatorInset = self.separatorInset;
    
    self.font?cell.titleLabel.font = self.font:NULL;
    self.textColor?cell.titleLabel.textColor = self.textColor:NULL;
    cell.titleLabel.text = [_items[indexPath.row] title];
    if ([_items[indexPath.row] respondsToSelector:@selector(image)]) {
        cell.icon.image = [_items[indexPath.row] image];
    }
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    typeof(self) __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            weakSelf.selectedItem?weakSelf.selectedItem(weakSelf.items[indexPath.row]):NULL;
        }];
    });
    
}

@end

@implementation LBItem
+ (instancetype)itemWithTitle:(NSString *)title
{
    LBItem *item = [[super alloc] init];
    item.title = title;
    return item;
}
@end
