//
//  ViewController.m
//  SlideTableViewDemo
//
//  Created by Biao on 16/4/26.
//  Copyright © 2016年 Biao. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "JBPanGestureRecognizer.h"

#define JB_Color_RGB(a,b,c) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1]


@interface ViewController ()

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = [NSMutableArray arrayWithArray:@[@"Beauty! Where is thy faith?",
                                                     @"Keep up your bright swords, for the dew will rust them. ",
                                                     @"O, she dothe teach the torches to burn bright! ",
                                                     @"Nothing will come of nothing. ",
                                                     @"This above all: to thine self be true.",
                                                     @"A little more than kin, and less than kind. ",
                                                     @"no zuo no die",
                                                     @"Beauty! Where is thy faith?",
                                                     @"Keep up your bright swords, for the dew will rust them. ",
                                                     @"O, she dothe teach the torches to burn bright! ",
                                                     @"Nothing will come of nothing. ",
                                                     @"This above all: to thine self be true.",
                                                     @"A little more than kin, and less than kind. "]];
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        tableView;
    });
    
    typeof(self) __weak weakSelf = self;
    JBPanGestureRecognizer *pan = [[JBPanGestureRecognizer alloc]initWithTableView:_tableView Handle:^(JBPanGestureRecognizer *panGesture, NSIndexPath *indexpath, BOOL isLeft) {
        
        if(isLeft)
        {
            [weakSelf.dataList removeObjectAtIndex:indexpath.row];
            [panGesture.tableView deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            DetailViewController *detail = [[DetailViewController alloc]init];
            [weakSelf addChildViewController:detail];
            [weakSelf.view addSubview:detail.view];
            [detail didMoveToParentViewController:weakSelf];
        }
    }];
    [pan addLeftText:@"comment" rightText:@"retweent"];
    [self.view addGestureRecognizer:pan];
    
}


#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    cell.backgroundColor = JB_Color_RGB(245, 110, 235);
    return cell;
}



@end
