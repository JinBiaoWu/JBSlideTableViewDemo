//
//  JBPanGestureRecognizer.m
//  SlideTableViewDemo
//
//  Created by Biao on 16/4/26.
//  Copyright © 2016年 Biao. All rights reserved.
//

#import "JBPanGestureRecognizer.h"
#import "JBSnapshotView.h"

static CGFloat const BPanFontSize = 15.0f;

static inline CGFloat angleWithOffserX(CGFloat x,CGFloat viewWidth)
{
    return (M_PI / 180.0 * (x / viewWidth) * 20);
}


@implementation JBPanGestureRecognizer

- (instancetype)initWithTableView:(UITableView *)tableView Handle:(JBHandler)handle
{
    self = [self initWithTarget:self action:@selector(JB_handleAction:)];
    if(!self)
    {
        return nil;
    }
    
    self.tableView = tableView;
    self.panHandle = handle;
    self.delaysTouchesBegan = YES;
    
    return self;
}


- (CATextLayer *)createLAyerWithText:(NSString *)text
{
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:BPanFontSize]constrainedToSize:CGSizeMake(100, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    CATextLayer *layer = [CATextLayer layer];
    layer.bounds = CGRectMake(0, 0, size.width, size.height);
    layer.font = (__bridge CFTypeRef)[UIFont systemFontOfSize:BPanFontSize].fontName;
    layer.fontSize = BPanFontSize;
    layer.foregroundColor = [UIColor magentaColor].CGColor;
    layer.string = text;
    
    return layer;
}

- (CATextLayer *)leftLayer
{
    if(_leftLayer == nil)
    {
        _leftLayer = [self createLAyerWithText:@"leftText"];
    }
    return _leftLayer;
}


- (CATextLayer *)rightLayer
{
    if(!_rightLayer)
    {
        _rightLayer = [self createLAyerWithText:@"rightText"];
    }
    return _rightLayer;
}


- (void)addLeftText:(NSString *)leftText rightText:(NSString *)rightText
{
    _leftLayer = [self createLAyerWithText:leftText];
    _rightLayer = [self createLAyerWithText:rightText];
}

- (void)JB_handleAction:(UIPanGestureRecognizer *)gesture
{
    CGPoint movePoint = [self translationInView:self.tableView];
    CGPoint location = [self locationInView:self.tableView];
    CGFloat viewWidth = self.tableView.frame.size.width;
    
    static NSIndexPath *sourceIndexPath = nil;
    static UIView *snapshot = nil;
    static BOOL isFirstTouch;
    
    switch (self.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
            if(indexPath == nil)
            {
                return;
            }
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            snapshot = [JBSnapshotView customSnapshoFromView:cell];
            
            CGFloat cellH = cell.frame.size.height;
            
            self.leftLayer.anchorPoint = CGPointMake(1, 0.5);
            self.leftLayer.position = CGPointMake(-10, cellH / 2);
            [snapshot.layer addSublayer:self.leftLayer];
            
            self.rightLayer.anchorPoint = CGPointMake(0, 0.5);
            self.rightLayer.position = CGPointMake(viewWidth + 10, cellH / 2);
            
            [snapshot.layer addSublayer:self.rightLayer];
            isFirstTouch = YES;
            sourceIndexPath = indexPath;
            snapshot.center = cell.center;
            snapshot.alpha = 0.0;
            [self.tableView addSubview:snapshot];
            
            [UIView animateWithDuration:0.25 animations:^{
                snapshot.alpha = 0.98;
                cell.alpha = 0.0;
            } completion:^(BOOL finished) {
                cell.hidden = YES;
            }];
        }
            break;
        
        case UIGestureRecognizerStateChanged:
        {
            CGAffineTransform transform = CGAffineTransformIdentity;
            transform = CGAffineTransformRotate(transform, angleWithOffserX(movePoint.x, viewWidth));
            transform = CGAffineTransformTranslate(transform, movePoint.x, 0);
            snapshot.transform = transform;
        }
            break;
        default:
        {
            //end
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            
            if(fabs(movePoint.x) > viewWidth * 0.3)
            {
                typeof(self) __weak weakSelf = self;
                [UIView animateWithDuration:0.4 animations:^{
                    CGFloat offsetX = movePoint.x > 0 ? viewWidth : -viewWidth;
                    CGAffineTransform transform = CGAffineTransformIdentity;
                    offsetX *= 1.2f;
                    transform = CGAffineTransformRotate(transform, angleWithOffserX(offsetX, viewWidth));
                    transform = CGAffineTransformTranslate(transform, offsetX, 0);
                    [snapshot setTransform:transform];
                    [snapshot setAlpha:1];
                } completion:^(BOOL finished) {
                    cell.alpha = 1.0;
                    cell.hidden = NO;
                    [snapshot removeFromSuperview];
                    
                    if(weakSelf.panHandle)
                    {
                        weakSelf.panHandle(weakSelf,sourceIndexPath,movePoint.x < 0);
                    }
                    snapshot = nil;
                    isFirstTouch = NO;
                    sourceIndexPath = nil;
                    
                }];
            }
            else
            {
                [UIView animateWithDuration:0.5 animations:^{
                    [snapshot setTransform:CGAffineTransformIdentity];
                    [snapshot setAlpha:1];
                } completion:^(BOOL finished) {
                    cell.alpha = 1.0;
                    cell.hidden = NO;
                    [snapshot removeFromSuperview];
                    snapshot = nil;
                    isFirstTouch = NO;
                    sourceIndexPath = nil;
                }];
            }
        }
            break;
    }
    
}

@end
