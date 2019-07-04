//
//  XWVC2.m
//  XWAnalytics_Example
//
//  Created by WJF on 2019/6/28.
//  Copyright © 2019 1097171985. All rights reserved.
//

#import "XWVC2.h"

@interface XWVC2 ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_contentTable;
    NSArray *_dataArray;
}

@end

@implementation XWVC2

+ (void)load{
    [XWAnalyticsManager analyticsEvents:NSStringFromClass([self class]) methods:@"tableView:didSelectRowAtIndexPath:" position:@"1111" name:@"2222" url:@"33333" productType:@"444444"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = @[@"UIbutton事件1",@"UIbutton事件2",@"手势事件1",@"单元格选中事件"];
    
    _contentTable = [[UITableView alloc] initWithFrame:self.view.frame];
    [_contentTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    _contentTable.dataSource = self;
    _contentTable.delegate = self;
    [self.view addSubview:_contentTable];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcName = [NSString stringWithFormat:@"XWVC%d",(int)indexPath.row+3];
    Class vcClassName = NSClassFromString(vcName);
    UIViewController *vc = (UIViewController *)[vcClassName new];
    vc.title = _dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
