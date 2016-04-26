//
//  DetailViewController.m
//  SlideTableViewDemo
//
//  Created by Biao on 16/4/26.
//  Copyright © 2016年 Biao. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    UITextView *_textView;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.alpha = 0.7f;
    self.view.backgroundColor = [UIColor greenColor];
    
    UITextView *textView = [[UITextView alloc]init];
    textView.frame = CGRectMake(10, -180, self.view.frame.size.width - 20, 180);
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelButton setFrame:CGRectMake(0, textView.frame.size.height - 30, 60, 30)];
    [cancelButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [textView addSubview:cancelButton];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setTitle:@"send" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [commitButton setFrame:CGRectMake(textView.frame.size.width - 60, textView.frame.size.height - 30, 60, 30)];
    [commitButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [textView addSubview:commitButton];
    _textView = textView;
    
    [self showView];
}

- (void)showView
{
    [UIView animateWithDuration:0.3 animations:^{
        _textView.transform = CGAffineTransformMakeTranslation(0, 210);
    }];
    [_textView becomeFirstResponder];
}


- (void)back
{
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _textView.transform = CGAffineTransformMakeTranslation(0, -210);
    } completion:^(BOOL finished) {
        [weakSelf willMoveToParentViewController:nil];
        [weakSelf.view removeFromSuperview];
        [weakSelf removeFromParentViewController];
    }];
    
}



@end
