//
//  UMSImagePicker.m
//  获取图片
//
//  Created by macj on 16/3/24.
//  Copyright © 2016年 macj. All rights reserved.
//

#import "UMSImagePicker.h"

@interface UMSImagePicker ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *pickerController;

@property (nonatomic, strong) UIImage *resultImage;

@property (nonatomic, weak) UIViewController *currentViewController;

@end

@implementation UMSImagePicker

- (void)addPhotoPickerToViewController:(UIViewController *)viewController completedBlock:(CompletedBlock)completedBlock {
    [self addPhotoPickerToViewController:viewController quailityType:UMSPhotoPickerJPGQuailityTypeHigh imageSize:CGSizeZero completedBlock:completedBlock];
}

- (void)addPhotoPickerToViewController:(UIViewController *)viewController quailityType:(UMSPhotoPickerJPGQuailityType)quailityType imageSize:(CGSize)imageSize completedBlock:(CompletedBlock)completedBlock {
    
    [self freeTheMemory];
    
    self.completedBlock = completedBlock;
    self.quailityType = quailityType;
    self.imageSize = imageSize;
    self.currentViewController = viewController;
    
    [self showAlertController];
}

- (void)showAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选取图片或拍照" message:@"从手机相册中选取一张图片或拍一张照片" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * takePictureAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showPickerViewTakePicture];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showPickerViewSelectPhoto];
    }];
    if (ISSimulator) {
        [alertController addAction:cancelAction];
        [alertController addAction:photoAction];
    } else {
        [alertController addAction:cancelAction];
        [alertController addAction:takePictureAction];
        [alertController addAction:photoAction];
    }
    
    [self.currentViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showPickerViewSelectPhoto {
    self.pickerController = [[UIImagePickerController alloc] init];
    self.pickerController.delegate = self;
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.pickerController.allowsEditing = YES;

    [self.currentViewController presentViewController:self.pickerController animated:YES completion:^{
        
    }];
}

- (void)showPickerViewTakePicture {
    
    NSString * mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
        UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"未获得授权使用摄像头" message:@"请在iOS\"设置\"-\"隐私\"-\"相机\"中打开" preferredStyle:UIAlertControllerStyleAlert];
        [self.currentViewController presentViewController:alertC animated:YES completion:nil];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self.currentViewController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertC addAction:action];
        return;
    }
    
    self.pickerController = [[UIImagePickerController alloc] init];
    self.pickerController.delegate = self;
    self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.pickerController.allowsEditing = YES;
    [self.currentViewController presentViewController:self.pickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *tempImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//        UIImage *tempImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *data;
        data = UIImageJPEGRepresentation(tempImage, [self imageJPEGQualityWithType:self.quailityType]);
        
        UIImage *image = [UIImage imageWithData:data];
//        if (self.imageSize.width > 0 && self.imageSize.height > 0) {
//            // 截取中心部分
//
//            image = [self originImage:image scaleToSize:self.imageSize];
//        }
        self.resultImage = image;
        if (self.completedBlock) {
            self.completedBlock(image);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        [self freeTheMemory];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.pickerController dismissViewControllerAnimated:YES completion:^{
        [self freeTheMemory];
    }];
}

- (void)freeTheMemory {
    self.pickerController = nil;
    self.currentViewController = nil;
    self.resultImage = nil;
    self.completedBlock = nil;
    self.imageSize = CGSizeZero;
    self.quailityType = UMSPhotoPickerJPGQuailityTypeHigh;
}

- (CGFloat)imageJPEGQualityWithType:(UMSPhotoPickerJPGQuailityType)type {
    switch (type) {
        case UMSPhotoPickerJPGQuailityTypeDefault:
            return 0.75;
            break;
        case UMSPhotoPickerJPGQuailityTypeHigh:
            return 1.0;
            break;
        case UMSPhotoPickerJPGQuailityTypeMedium:
            return 0.5;
            break;
        case UMSPhotoPickerJPGQuailityTypeLow:
            return 0.25;
            break;
         default:
            return 0.75;
            break;
    }
}


- (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size {
    
    CGRect rect;
    if (image.size.width > image.size.height) {
        CGFloat w = image.size.height;
        CGFloat h = image.size.height;
        CGFloat x = (image.size.width - w) * 0.5;
        CGFloat y = 0;
        rect = CGRectMake(x, y, w, h);
        
        CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
        UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        
        UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
        [thumbScale drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage;
        
    } else {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage;
    }
}

- (void)dealloc {

}

@end
