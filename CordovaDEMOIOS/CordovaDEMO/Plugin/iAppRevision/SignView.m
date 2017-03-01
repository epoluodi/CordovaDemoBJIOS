//
//  SignView.m
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/23.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import "SignView.h"
#import "KGAlertView.h"
#import "iAppRevisionService.h"
#import "KGBase64.h"

@implementation SignView
@synthesize serverData;

-(instancetype)init:(UIViewController<SignDelegate> *)viewcontroller
{
    self = [super init];
    blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    _viewcontroller = viewcontroller;
    
    self.frame=_viewcontroller.view.frame;
    
    return self;
}


-(void)initHandView
{
    
    [self addSubview:effectview];
    
    
    
    handwritingView = [[KGHandwritingView alloc] init];
    handwritingView.backgroundColor=[UIColor whiteColor];
    handwritingView.handwritingWidth =1;
    [effectview addSubview:handwritingView];
    
    btnUndo = [[UIButton alloc] init];
    [btnUndo setTitle:@"撤销" forState:UIControlStateNormal];
    [btnUndo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnUndo setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    btnUndo.layer.borderColor = [[UIColor whiteColor] CGColor];
    btnUndo.layer.borderWidth = 1;
    btnUndo.layer.cornerRadius=8;
    btnUndo.layer.masksToBounds=YES;
    
    btnRedo = [[UIButton alloc] init];
    [btnRedo setTitle:@"恢复" forState:UIControlStateNormal];
    [btnRedo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRedo setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    btnRedo.layer.borderColor = [[UIColor whiteColor] CGColor];
    btnRedo.layer.borderWidth = 1;
    btnRedo.layer.cornerRadius=8;
    btnRedo.layer.masksToBounds=YES;
    
    [effectview addSubview:btnRedo];
    [effectview addSubview:btnUndo];
    
    
    //按钮初始化
    
    btnSave = [[UIButton alloc] init];
    [btnSave setTitle:@"确定" forState:UIControlStateNormal];
    [btnSave setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btnSave setTitleColor:[[UIColor greenColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    btnSave.layer.borderColor = [[UIColor greenColor] CGColor];
    btnSave.layer.borderWidth = 1;
    btnSave.layer.cornerRadius=8;
    btnSave.layer.masksToBounds=YES;
    
    btnCancel = [[UIButton alloc] init];
    [btnCancel setTitle:@"返回" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCancel setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    btnCancel.layer.borderColor = [[UIColor whiteColor] CGColor];
    btnCancel.layer.borderWidth = 1;
    btnCancel.layer.cornerRadius=8;
    btnCancel.layer.masksToBounds=YES;
    
    
    btnClean = [[UIButton alloc] init];
    [btnClean setTitle:@"清除" forState:UIControlStateNormal];
    [btnClean setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnClean setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    btnClean.layer.borderColor = [[UIColor whiteColor] CGColor];
    btnClean.layer.borderWidth = 1;
    btnClean.layer.cornerRadius=8;
    btnClean.layer.masksToBounds=YES;
    
    
    [effectview addSubview:btnSave];
    [effectview addSubview:btnClean];
    [effectview addSubview:btnCancel];
    
    
    
    [btnCancel addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [btnUndo addTarget:self action:@selector(undo) forControlEvents:UIControlEventTouchUpInside];
    [btnRedo addTarget:self action:@selector(redo) forControlEvents:UIControlEventTouchUpInside];
    [btnClean addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];
    [btnSave addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
     if ([[serverData objectForKey:@"haveFieldValue"]  isEqualToString:@"1"])//没有原始数据
     {
         NSData *pointdata = [self readPointDataFromFile];
         NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithData:pointdata];
         [handwritingView renderViewWithPaths:arr2];

     }
}


-(void)initTextView
{
    
    [self addSubview:effectview];
    textsignView = [[KGTextView alloc] init];
    textsignView.backgroundColor=[UIColor whiteColor];
    textsignView.textColor = [UIColor blackColor];
    [effectview addSubview:textsignView];
    textsignView.textFont = [UIFont systemFontOfSize:14];
    
    //按钮初始化
    
    btnSave = [[UIButton alloc] init];
    [btnSave setTitle:@"确定" forState:UIControlStateNormal];
    [btnSave setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btnSave setTitleColor:[[UIColor greenColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    btnSave.layer.borderColor = [[UIColor greenColor] CGColor];
    btnSave.layer.borderWidth = 1;
    btnSave.layer.cornerRadius=8;
    btnSave.layer.masksToBounds=YES;
    
    btnCancel = [[UIButton alloc] init];
    [btnCancel setTitle:@"返回" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCancel setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    btnCancel.layer.borderColor = [[UIColor whiteColor] CGColor];
    btnCancel.layer.borderWidth = 1;
    btnCancel.layer.cornerRadius=8;
    btnCancel.layer.masksToBounds=YES;
    
    
    btnClean = [[UIButton alloc] init];
    [btnClean setTitle:@"清除" forState:UIControlStateNormal];
    [btnClean setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnClean setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    btnClean.layer.borderColor = [[UIColor whiteColor] CGColor];
    btnClean.layer.borderWidth = 1;
    btnClean.layer.cornerRadius=8;
    btnClean.layer.masksToBounds=YES;
    
    
    [effectview addSubview:btnSave];
    [effectview addSubview:btnClean];
    [effectview addSubview:btnCancel];
    
    
    
    [btnCancel addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [btnClean addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];
    [btnSave addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[serverData objectForKey:@"haveFieldValue"]  isEqualToString:@"1"])//没有原始数据
    {
    
        word =[serverData objectForKey:@"word"];
        textsignView.text=word;
    }
    
}


-(void)undo
{
    [handwritingView undo];
}

-(void)redo
{
    [handwritingView redo];
}

-(void)clean
{
    if ([[serverData objectForKey:@"mode"] isEqual:@(1)])
        [handwritingView clean];
    else if ([[serverData objectForKey:@"mode"] isEqual:@(2)])
             [textsignView clean];
}

-(void)save
{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSString *filepath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[serverData objectForKey:@"recordID"]]];
    NSLog(@"保存地址 %@",filepath);
    __block NSData *imgdata;
    if ([[serverData objectForKey:@"mode"] isEqual:@(1)]){
        [handwritingView saveHandwritingSignatureWithCompletion:^(UIImage *iAppRevisionViewImage, UIImage *signatureImage, CGRect signatureRect) {
            
    
            UIImage *newimg = [self imageCompressForWidthScale:signatureImage targetWidth:800];
            [self loadImageFinished:newimg];
            imgdata = UIImagePNGRepresentation(newimg);
            word=@"";
            
            
            NSArray *pointdata= handwritingView.brushPaths;
            //数组 转 data
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:pointdata];
//            NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];

            [self writePointDataToText:data];
            [imgdata writeToFile:filepath atomically:YES];

     
        }];
    }
    else if ([[serverData objectForKey:@"mode"] isEqual:@(2)])
    {
        
        [textsignView saveTextSignatureWithCompletion:^(UIImage *iAppRevisionViewImage, UIImage *signatureImage, CGRect signatureRect) {
         
            NSDateFormatter *df= [[NSDateFormatter alloc] init];
            df.dateFormat = @"yyyy年MM月dd";
            NSString *dt = [df stringFromDate:[NSDate date]];
            NSString *watermarkStr = [NSString stringWithFormat:@"%@ %@",[serverData objectForKey:@"userName"] ,dt];
            NSDictionary *textAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:9], NSForegroundColorAttributeName : [UIColor blackColor]};
            UIImage *newsignatureImage = [iAppRevisionView watermarkImage:signatureImage content:watermarkStr textAttributes:textAttributes position:KGWatermarkPositionBottom gapPoint:CGPointMake(5, 5)];
            
            word = textsignView.text;
            UIImage *newtextimg = [self imageCompressForWidthScale:newsignatureImage targetWidth:800];
            imgdata = UIImagePNGRepresentation(newtextimg);
            [imgdata writeToFile:filepath atomically:YES];
//            CGRect newrect = CGRectMake(0, 0, newimg.size.width, newimg.size.height);
//            
//            [self uploadData:imgdata signatureRect:newrect];
            [self close];
        }];
       
    }
    
    
    NSDictionary *returndict = @{@"recordID":[serverData objectForKey:@"recordID"],
                             @"fieldName":[serverData objectForKey:@"fieldName"] ,
                                  @"userName":[serverData objectForKey:@"userName"] ,
                               @"mode":[serverData objectForKey:@"mode"]  ,
                               @"word":word,
                              @"base64":[self getImgBase64:imgdata] };
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:returndict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    [_viewcontroller CallBackPreView:json callbackID:_callbackID];
    
    [self close];
    
}

-(NSString *)getImgBase64:(NSData *)data
{
    KGBase64 *b64 = [KGBase64 base64];
    return [b64 base64StringWithData:data];
}

-(void)uploadData :(NSString *)callbackid{
    _callbackID = callbackid;
    iAppRevisionService *_server = [iAppRevisionService service];
    __weak __typeof(self) weakself= self;
    
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSString *filepath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[serverData objectForKey:@"recordID"]]];
    NSLog(@"保存地址 %@",filepath);
    NSData *signdata = [NSData dataWithContentsOfFile:filepath];
    if (!signdata)
    {
        [_viewcontroller uploadError:@"1" callbackID:_callbackID];
        return;
    }
    UIImage *image = [UIImage imageWithData:signdata];
    CGRect signatureRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    if ([[serverData objectForKey:@"haveFieldValue"]  isEqualToString:@"0"])//没有原始数据
    {
        //生成新的签批数据
        NSString *fieldvalue = [_server fieldValueWithSignatureImageData:signdata signatureRect:signatureRect userName:[serverData objectForKey:@"userName"] oldFieldValue:nil];
        if (!fieldvalue)
        {
            //返回空
            [_viewcontroller uploadError:@"组织签批数据为空" callbackID:_callbackID];
            return ;
        }
        
        [weakself saveSignData:fieldvalue];//保存签批数据
        return;
    }
    
    
    [_server loadSignatureWithWebService:[serverData objectForKey:@"webService"] recordID:[serverData objectForKey:@"oldRecordID"] userName:[serverData objectForKey:@"userName"] fieldName:[serverData objectForKey:@"oldFieldName"] success:^(NSString *fieldValue) {
        
        if (!fieldValue)
        {
            //返回空
            [_viewcontroller uploadError:@"原始签批数据读取失败" callbackID:_callbackID];
            return ;
        }
        NSString *newfieldvalue = [_server fieldValueWithSignatureImageData:signdata signatureRect:signatureRect userName:[serverData objectForKey:@"userName"] oldFieldValue:fieldValue];
        if (!newfieldvalue)
        {
            //返回空
            [_viewcontroller uploadError:@"组织签批数据为空" callbackID:_callbackID];
            return ;
        }
        [weakself saveSignData:newfieldvalue];//保存签批数据
        
    } failure:^(NSError *error) {
        //获取原始签批数据失败
        NSString *err = error.description;
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData *_errdata = [err dataUsingEncoding:encoding];
        [_viewcontroller uploadError:[[NSString alloc] initWithData:_errdata encoding:NSUTF8StringEncoding] callbackID:_callbackID];
    }];
    
}


//保存签批数据
-(void)saveSignData:(NSString *)fieldValue
{
    iAppRevisionService *_server = [iAppRevisionService service];
    NSDateFormatter *df= [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dt = [df stringFromDate:[NSDate date]];
    
    if ([[serverData objectForKey:@"haveFieldValue"]  isEqualToString:@"0"])
    {
        [_server saveSignatureWithWebService:[serverData objectForKey:@"webService"] recordID:[serverData objectForKey:@"recordID"] userName:[serverData objectForKey:@"userName"] fieldName:[serverData objectForKey:@"fieldName"] fieldValue:fieldValue dateTime:dt allImage:YES success:^(NSString *message) {
            NSLog(@"recordid %@",[serverData objectForKey:@"recordID"]);
            [_viewcontroller signFinish:@"0" callbackID:_callbackID];
        } failure:^(NSError *error) {
            [_viewcontroller uploadError:@"1" callbackID:_callbackID];
        }];
    }else  if ([[serverData objectForKey:@"haveFieldValue"]  isEqualToString:@"1"])
    {
        [_server saveSignatureWithWebService:[serverData objectForKey:@"webService"] recordID:[serverData objectForKey:@"newRecordID"] userName:[serverData objectForKey:@"userName"] fieldName:[serverData objectForKey:@"fieldName"] fieldValue:fieldValue dateTime:dt allImage:YES success:^(NSString *message) {
            NSLog(@"recordid %@",[serverData objectForKey:@"newRecordID"]);
            [_viewcontroller signFinish:@"0" callbackID:_callbackID];
        } failure:^(NSError *error) {
            [_viewcontroller uploadError:@"1" callbackID:_callbackID];
        }];
    }
  
    
}





//返回
-(void)close{
    [[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationPortrait animated: NO];
    [handwritingView removeFromSuperview];
    [textsignView removeFromSuperview];
    [btnCancel removeFromSuperview];
    [btnClean removeFromSuperview];
    [btnSave removeFromSuperview];
    [btnUndo removeFromSuperview];
    [btnRedo removeFromSuperview];
    handwritingView = nil;
    btnRedo = nil;
    btnUndo= nil;
    btnSave = nil;
    btnClean = nil;
    btnCancel= nil;
    [self removeFromSuperview];
}

-(void)show:(NSString *)callbackid
{
    _callbackID = callbackid;
    if ([[serverData objectForKey:@"mode"] isEqual:@(1)])
    {
        [self initHandView];
        [[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationLandscapeRight animated: NO];
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        CGRect frame = [UIScreen mainScreen].bounds;
        NSLog(@"%@",NSStringFromCGRect(frame));
        self.bounds = CGRectMake(0, 20, frame.size.width, frame.size.height);
        [_viewcontroller.view addSubview:self];
        effectview.frame = self.bounds;
        handwritingView.frame = CGRectMake(20, 30, self.bounds.size.width-140, self.bounds.size.height-50);
        handwritingView.layer.shadowColor =[[UIColor blackColor] CGColor];
        handwritingView.layer.shadowRadius=6;
        handwritingView.layer.shadowOpacity= 0.8;
        handwritingView.layer.shadowOffset=CGSizeMake(6, 6);
        
        btnUndo.frame = CGRectMake(handwritingView.frame.origin.x +  handwritingView.frame.size.width +20, 30, self.bounds.size.width - (20+16+16+handwritingView.frame.size.width), 50);
        btnRedo.frame = CGRectMake(handwritingView.frame.origin.x +  handwritingView.frame.size.width +20, 30 + btnUndo.frame.size.height + 10, self.bounds.size.width - (20+16+16+handwritingView.frame.size.width), 50);
        btnClean.frame = CGRectMake(handwritingView.frame.origin.x +  handwritingView.frame.size.width +20, btnRedo.frame.origin.y + btnRedo.frame.size.height + 10, self.bounds.size.width - (20+16+16+handwritingView.frame.size.width), 50);
        btnCancel.frame = CGRectMake(handwritingView.frame.origin.x +  handwritingView.frame.size.width +20, btnClean.frame.origin.y + btnClean.frame.size.height + 10, self.bounds.size.width - (20+16+16+handwritingView.frame.size.width), 50);
        
        
        btnSave.frame = CGRectMake(handwritingView.frame.origin.x +  handwritingView.frame.size.width +20, self.bounds.size.height - 70, self.bounds.size.width - (20+16+16+handwritingView.frame.size.width), 50);
        
        
        
    }
    
    else if ([[serverData objectForKey:@"mode"] isEqual:@(2)])
    {
        [self initTextView];
        [_viewcontroller.view addSubview:self];
        effectview.frame = self.bounds;
        
        textsignView.frame = CGRectMake(20, 30, self.bounds.size.width-40, self.bounds.size.height/2-100);
        textsignView.layer.shadowColor =[[UIColor blackColor] CGColor];
        textsignView.layer.shadowRadius=6;
        textsignView.layer.shadowOpacity= 0.8;
        textsignView.layer.shadowOffset=CGSizeMake(6, 6);
        
        
        btnClean.frame = CGRectMake(20, textsignView.frame.origin.y + textsignView.frame.size.height + 10, self.bounds.size.width - 40, 50);
        btnCancel.frame = CGRectMake(20, btnClean.frame.origin.y + btnClean.frame.size.height + 10, self.bounds.size.width -40, 50);
        btnSave.frame = CGRectMake(20, btnCancel.frame.origin.y + btnCancel.frame.size.height + 10, self.bounds.size.width -40, 50);
        
    }
    
    
}

//指定宽度按比例缩放
-(UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0] set];
    UIRectFill(CGRectMake(0, 0, thumbnailRect.size.width,thumbnailRect.size.height));
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();  
    return newImage;
}

//保存元数据
-(void)writePointToText:(NSString *)data
{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSString *filepath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",[serverData objectForKey:@"recordID"]]];
    NSLog(@"元数据地址 %@",filepath);
    
    NSFileManager *filemanger = [NSFileManager defaultManager];
    [filemanger removeItemAtPath:filepath error:nil];
    [data writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

-(void)writePointDataToText:(NSData *)pointdata
{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSString *filepath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",[serverData objectForKey:@"recordID"]]];
    NSLog(@"元数据地址 %@",filepath);
    
    NSFileManager *filemanger = [NSFileManager defaultManager];
    [filemanger removeItemAtPath:filepath error:nil];
    [pointdata writeToFile:filepath atomically:YES];
   
}

//读取元数据
-(NSString *)readPointFromTxt
{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSString *filepath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",[serverData objectForKey:@"recordID"]]];
    NSLog(@"元数据地址 %@",filepath);
    
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    if (!data)
        return nil;
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


-(NSData *)readPointDataFromFile
{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSString *filepath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",[serverData objectForKey:@"recordID"]]];
    NSLog(@"元数据地址 %@",filepath);
    
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    if (!data)
        return nil;
    return data;
}


- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
