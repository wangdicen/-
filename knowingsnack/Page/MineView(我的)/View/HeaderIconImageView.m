//
//  HeaderIconImageView.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/27.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "HeaderIconImageView.h"
#import "Chameleon.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UserInfo.h"
#import "AVOSManager.h"
#import "JHUD.h"
#define kBorderWidth 3

@interface HeaderIconImageView()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;
    JHUD *_hudView;
}
@end



@implementation HeaderIconImageView

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = image;
        self.backgroundColor = ClearColor;
        
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePickerController.allowsEditing = YES;
        
        _hudView = [[JHUD alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"更换头像", nil];
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    [sheet showInView:[self viewController].view];
}


//获得view所在的controller
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //更换头像
    if (buttonIndex == 0) {
        [self selectImageFromAlbum];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
    
//    UserInfo *userInfo = [[AVOSManager shareAVOSManager] getUserInfo];
//    NSLog(@"%@",userInfo);
    NSData *data = UIImagePNGRepresentation(image);
    AVFile *file =[AVFile fileWithData:data];
    [[AVUser currentUser] setObject:file forKey:@"image"];
    [_hudView showAtView:picker.view hudType:JHUDLoadingTypeCircleJoin];
    _hudView.messageLabel.text = @"正在上传...稍等片刻~";
    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (succeeded) {
            [_hudView hide];
            self.image = image;
            [self setNeedsDisplay];

        }
        [[self viewController] dismissViewControllerAnimated:YES completion:nil];

    }];
}


#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [[self viewController] presentViewController:_imagePickerController animated:YES completion:nil];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    /**
     画圆形边框
     */
    CGRect bigRect = CGRectMake(rect.origin.x + kBorderWidth,
                                rect.origin.y+ kBorderWidth,
                                rect.size.width - kBorderWidth*2,
                                rect.size.height - kBorderWidth*2);
    //设置空心圆的线条宽度
    CGContextSetLineWidth(ctx, kBorderWidth);
    //以矩形bigRect为依据画一个圆
    CGContextAddEllipseInRect(ctx, bigRect);
    //填充当前绘画区域的颜色
    [FlatWhite set];
    //(如果是画圆会沿着矩形外围描画出指定宽度的（圆线）空心圆)/（根据上下文的内容渲染图层）
    CGContextStrokePath(ctx);
    
    /**
     *  裁剪图片
     */
    CGRect smallRect = CGRectMake(rect.origin.x + kBorderWidth,
                                  rect.origin.y + kBorderWidth,
                                  rect.size.width - 2 * kBorderWidth,
                                  rect.size.height -2 * kBorderWidth);
    //以矩形ctx为依据画一个圆
    CGContextAddEllipseInRect(ctx, smallRect);
    //设置裁剪区域
    CGContextClip(ctx);
    // 裁剪图片
    UIImage *image = _image;
    // 把图片加入smallRect的矩形区域内，超过上面设定的裁剪区域的部分将被裁剪掉
    [image drawInRect:smallRect];
    // 将上下文的内容渲染到视图的layer图层上
    CGContextStrokePath(ctx);
    
}


@end
