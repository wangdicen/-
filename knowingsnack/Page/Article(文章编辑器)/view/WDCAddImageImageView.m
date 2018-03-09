//
//  WDCAddImageImageView.m
//  knowingsnack
//
//  Created by travelsky on 2018/3/2.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "WDCAddImageImageView.h"
#import "Header.h"
@interface WDCAddImageImageView()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIBezierPath *_path;
    UIImageView *_imageview;
}
@end

@implementation WDCAddImageImageView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ClearColor;
        
        _textlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 50)];
        _textlabel.backgroundColor = ClearColor;
        [self addSubview:_textlabel];
        _textlabel.center = CGPointMake(frame.size.width/2.0, frame.size.height/2.f);
        [_textlabel setTextColor:FlatWhiteDark];
        _textlabel.textAlignment = NSTextAlignmentCenter;
        
        
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageview.image = nil;
        _imageview.contentMode = UIViewContentModeScaleAspectFill;
        _imageview.clipsToBounds = YES;
        [self addSubview:_imageview];
    }
    return self;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self getImageFromIpc];
}


- (void)getImageFromIpc
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [[self viewController] presentViewController:ipc animated:YES completion:nil];
}


#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    _imageview.image = info[UIImagePickerControllerOriginalImage];
}



-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    _path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, rect.size.width - 20.f, rect.size.height - 20.f) cornerRadius:7];
    _path.lineWidth = 2;
    [ClearColor setStroke];
    CGContextSetLineWidth(context, 2);
    CGContextAddPath(context, _path.CGPath);
    CGContextStrokePath(context);
    
    CGFloat dashes[] = {6,2};
    [_path setLineDash:dashes count:2 phase:0];
    [FlatWhite setStroke];
    [_path stroke];
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
/*
// Only override drawRect: if you perform custom drawing.
/
 / An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
