//
//  TableViewCellSlideAnimationController.m
//  Animations
//
//  Created by YouXianMing on 15/12/4.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "TableViewCellSlideAnimationController.h"
#import "UIView+SetRect.h"
#import "WxHxD.h"
#import "SlideAnimationCell.h"

@interface TableViewCellSlideAnimationController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray  *dataSource;

@end

@implementation TableViewCellSlideAnimationController

- (void)setup {

    [super setup];
    
    // 数据源
    self.dataSource = [NSMutableArray array];
    
    NSArray *datas = @[@"YouXianMing",   @"Google",
                       @"iOS Developer", @"YouTube",
                       @"UI Delveloper", @"PS4 Player",
                       @"3DS Player",    @"NDS Player",
                       @"PSP Player",    @"GBA Player"];
    
    for (int i = 0; i < datas.count; i++) {
        
        CellDataAdapter *adapter = [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:DATA_CELL data:datas[i]
                                                                                cellHeight:0 cellType:0];
        [self.dataSource addObject:adapter];
    }
    
    // 初始化tableView
    self.tableView                = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SlideAnimationCell class] forCellReuseIdentifier:DATA_CELL];
    [self.contentView addSubview:self.tableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 发送广播
    [[NSNotificationCenter defaultCenter] postNotificationName:DATA_CELL
                                                        object:@(scrollView.contentOffset.y)
                                                      userInfo:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomAdapterTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:DATA_CELL];
    cell.indexPath   = indexPath;
    cell.dataAdapter = self.dataSource[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CELL_HEIGHT;
}

@end
