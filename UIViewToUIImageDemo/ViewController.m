//
//  ViewController.m
//  UIViewToUIImageDemo
//
//  Created by 张丁豪 on 2017/4/21.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UIView *shareView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createShareView];
}

- (void)createShareView{
    
    self.shareView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+20)];
    self.shareView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height-60)];
    image.image = [UIImage imageNamed:@"huaban.jpeg"];
    [self.shareView addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, image.bounds.size.height+30, [UIScreen mainScreen].bounds.size.width-20, 30)];
    label.text = @"Stay hungry Stay foolish.";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [self.shareView addSubview:label];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, [UIScreen mainScreen].bounds.size.width-40, 44)];
    btn.backgroundColor = [UIColor redColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"Share" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)BtnClicked
{
    UIImage *img = [self createViewImage:self.shareView];
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片保存成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alter show];
        
        NSLog(@"保存成功");
    }else{
        
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alter show];
        NSLog(@"保存失败");
    }
}

- (UIImage *)createViewImage:(UIView *)shareView {
    
    UIGraphicsBeginImageContextWithOptions(shareView.bounds.size, NO, [UIScreen mainScreen].scale);
    [shareView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
