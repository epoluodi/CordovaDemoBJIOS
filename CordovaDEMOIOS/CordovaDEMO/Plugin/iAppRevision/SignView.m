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
    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
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
}


-(void)initTextView
{
    
    [self addSubview:effectview];
    textsignView = [[KGTextView alloc] init];
    textsignView.backgroundColor=[UIColor whiteColor];
    textsignView.textColor = [UIColor blackColor];
    [effectview addSubview:textsignView];
    
    
    //按钮初始化
    
    btnSave = [[UIButton alloc] init];
    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
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
    [handwritingView clean];
}

-(void)save
{
    [handwritingView saveHandwritingSignatureWithCompletion:^(UIImage *iAppRevisionViewImage, UIImage *signatureImage, CGRect signatureRect) {
        
        NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [cacPath objectAtIndex:0];
        
        NSString *uuid = [[NSUUID UUID] UUIDString];
        NSString *filepath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",uuid]];
        fileuuid =uuid;
        NSLog(@"保存地址 %@",filepath);
        NSData *imgdata = UIImagePNGRepresentation(signatureImage);
        [imgdata writeToFile:filepath atomically:YES];
        //        [_viewcontroller signFinish:uuid callbackID:_callbackID];
        [self uploadData:imgdata signatureRect:signatureRect];
        [self close];
    }];
}


-(void)uploadData:(NSData *)signdata signatureRect:(CGRect)signatureRect{
    iAppRevisionService *_server = [iAppRevisionService service];
    __weak __typeof(self) weakself= self;
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
    
    
    [_server loadSignatureWithWebService:[serverData objectForKey:@"webService"] recordID:[serverData objectForKey:@"recordID"] userName:[serverData objectForKey:@"userName"] fieldName:[serverData objectForKey:@"fieldName"] success:^(NSString *fieldValue) {
        
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
    [_server saveSignatureWithWebService:[serverData objectForKey:@"webService"] recordID:[serverData objectForKey:@"recordID"] userName:[serverData objectForKey:@"userName"] fieldName:[serverData objectForKey:@"fieldName"] fieldValue:fieldValue dateTime:dt extractImage:YES  success:^(NSString *message) {
        [_viewcontroller signFinish:fileuuid callbackID:_callbackID];
    } failure:^(NSError *error) {
        [_viewcontroller uploadError:error.description callbackID:_callbackID];
    }];
    
}





//返回
-(void)close{
    [[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationPortrait animated: NO];
    [handwritingView removeFromSuperview];
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
        
        textsignView.frame = CGRectMake(20, 30, self.bounds.size.width-40, self.bounds.size.height/2);
        textsignView.layer.shadowColor =[[UIColor blackColor] CGColor];
        textsignView.layer.shadowRadius=6;
        textsignView.layer.shadowOpacity= 0.8;
        textsignView.layer.shadowOffset=CGSizeMake(6, 6);
        
    }

   
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
