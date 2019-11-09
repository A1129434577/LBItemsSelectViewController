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
@property (nonatomic,assign)LBItemsSelectContentAlignment contentAlignment;
@property (nonatomic,assign)UIEdgeInsets contentInset;
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
    switch (self.contentAlignment) {
        case LBItemsSelectContentAlignmentLeft:
        {
            CGFloat iconHeight = CGRectGetHeight(frame)-self.contentInset.top-self.contentInset.bottom;
            self.icon.frame = CGRectMake(self.contentInset.left, self.contentInset.top, self.icon.image?iconHeight:0, iconHeight);
            CGFloat titleLabelMinX = CGRectGetMaxX(self.icon.frame)+(self.icon.image?5:0);
            self.titleLabel.frame = CGRectMake(titleLabelMinX, CGRectGetMinY(self.icon.frame), CGRectGetWidth(frame)-titleLabelMinX, iconHeight);
        }
            break;
        case LBItemsSelectContentAlignmentCenter:
        {
            CGFloat iconHeight = CGRectGetHeight(frame)-self.contentInset.top-self.contentInset.bottom;
            CGFloat iconWidth = self.icon.image?iconHeight:0;;
            CGFloat titleLabelWidth = [self.titleLabel sizeThatFits:CGSizeMake(CGRectGetWidth(frame)-iconWidth-self.contentInset.left-(self.icon.image?5:0), iconHeight)].width;
            CGFloat contentMinX = (CGRectGetWidth(frame)-iconWidth-titleLabelWidth-(self.icon.image?5:0))/2+self.contentInset.left;
            
            self.icon.frame = CGRectMake(contentMinX, self.contentInset.top, iconWidth, iconHeight);
            CGFloat titleLabelMinX = CGRectGetMaxX(self.icon.frame)+(self.icon.image?5:0);
            self.titleLabel.frame = CGRectMake(titleLabelMinX, CGRectGetMinY(self.icon.frame), titleLabelWidth, iconHeight);
        }
            
            break;
        case LBItemsSelectContentAlignmentRight:
        {
            CGFloat iconHeight = CGRectGetHeight(frame)-self.contentInset.top-self.contentInset.bottom;
            CGFloat titleLabelWidth = [self.titleLabel sizeThatFits:CGSizeMake(CGRectGetWidth(frame)-iconHeight-self.contentInset.left-(self.icon.image?5:0), iconHeight)].width;
            self.titleLabel.frame = CGRectMake(CGRectGetWidth(frame)-titleLabelWidth, self.contentInset.top, titleLabelWidth, iconHeight);
            self.icon.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame)-5-iconHeight, CGRectGetMinY(self.titleLabel.frame), iconHeight, iconHeight);
        }
            break;
            
        default:
            break;
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
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return self;
}
-(UIModalPresentationStyle )adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;//不适配
}

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:_tableView];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _tableView.frame = self.view.bounds;
}
- (void)setContentInset:(UIEdgeInsets)contentInset{
    _contentInset = contentInset;
    [_tableView reloadData];
}
- (void)setContentAlignment:(LBItemsSelectContentAlignment)contentAlignment{
    _contentAlignment = contentAlignment;
    [_tableView reloadData];
}
-(void)setSeparatorInset:(UIEdgeInsets)separatorInset{
    _separatorInset = separatorInset;
    _tableView.separatorInset = separatorInset;
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
    cell.contentAlignment = self.contentAlignment;
    cell.contentInset = self.contentInset;
    
    self.font?cell.titleLabel.font=self.font:NULL;
    self.textColor?cell.titleLabel.textColor=self.textColor:NULL;
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
