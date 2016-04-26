//
//  JBSnapshotView.m
//  SlideTableViewDemo
//
//  Created by Biao on 16/4/26.
//  Copyright © 2016年 Biao. All rights reserved.
//

#import "JBSnapshotView.h"

@implementation JBSnapshotView


+ (UIView *)customSnapshoFromView:(UIView *)inputView
{
    UIView *snapShot = [[UIView alloc]initWithFrame:inputView.frame];
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, YES, 1);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *shot = [[UIImageView alloc]initWithImage:viewImage];
    [snapShot addSubview:shot];
    snapShot.layer.masksToBounds = NO;
    snapShot.layer.cornerRadius = 0.0;
    snapShot.layer.shadowOpacity = 0.4;
    
    return snapShot;
}



@end
