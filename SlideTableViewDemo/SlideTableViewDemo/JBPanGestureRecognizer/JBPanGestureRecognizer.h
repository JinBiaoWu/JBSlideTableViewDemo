//
//  JBPanGestureRecognizer.h
//  SlideTableViewDemo
//
//  Created by Biao on 16/4/26.
//  Copyright © 2016年 Biao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBPanGestureRecognizer;

typedef void(^JBHandler)(JBPanGestureRecognizer *panGesture,NSIndexPath *indexpath,BOOL isLeft);

@interface JBPanGestureRecognizer : UIPanGestureRecognizer

- (instancetype)initWithTableView:(UITableView *)tableView Handle:(JBHandler)handle;

@property (nonatomic,copy)JBHandler panHandle;
@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic,strong)CATextLayer *leftLayer;
@property (nonatomic,strong)CATextLayer *rightLayer;

- (void)addLeftText:(NSString *)leftText rightText:(NSString *)rightText;

@end
