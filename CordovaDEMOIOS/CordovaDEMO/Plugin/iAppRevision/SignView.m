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
    [self initView];
    return self;
}


-(void)initView
{

   [self addSubview:effectview];
    

    handwritingView = [[KGHandwritingView alloc] init];
    handwritingView.backgroundColor=[UIColor whiteColor];
    handwritingView.handwritingWidth =1;
    [effectview addSubview:handwritingView];
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
    [effectview addSubview:btnRedo];
    [effectview addSubview:btnUndo];
    
    
    [btnCancel addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [btnUndo addTarget:self action:@selector(undo) forControlEvents:UIControlEventTouchUpInside];
    [btnRedo addTarget:self action:@selector(redo) forControlEvents:UIControlEventTouchUpInside];
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
        NSLog(@"保存地址 %@",filepath);
        NSData *imgdata = UIImagePNGRepresentation(signatureImage);
        [imgdata writeToFile:filepath atomically:YES];
//        [_viewcontroller signFinish:uuid callbackID:_callbackID];
        [self uploadData:imgdata signatureRect:signatureRect uuid:uuid];
        [self close];
    }];
}


-(void)uploadData:(NSData *)signdata signatureRect:(CGRect)signatureRect uuid:(NSString *)uuid
{
    iAppRevisionService *_server = [iAppRevisionService service];
//    [_server loadSignatureWithWebService:[serverData objectForKey:@"webService"] recordID:[serverData objectForKey:@"recordID"] userName:[serverData objectForKey:@"fieldName"] fieldName:[serverData objectForKey:@"userName"] success:^(NSString *fieldValue) {
//        
//        
//        NSLog(@"查询到 %@",fieldValue);
//        
//    } failure:^(NSError *error) {
//     
//        
//        NSString *err = error.description;
//        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//        NSData *_errdata = [err dataUsingEncoding:encoding];
//           [_viewcontroller uploadError:[[NSString alloc] initWithData:_errdata encoding:NSUTF8StringEncoding] callbackID:_callbackID];
//    }];
    
    NSString *fieldvalue = [_server fieldValueWithSignatureImageData:signdata signatureRect:signatureRect userName:[serverData objectForKey:@"userName"] oldFieldValue:nil];
    if (!fieldvalue)
    {
        //返回空
        [_viewcontroller uploadError:@"组织签批数据为空" callbackID:_callbackID];
        return ;
    }
    
    NSDateFormatter *df= [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dt = [df stringFromDate:[NSDate date]];
    [_server saveSignatureWithWebService:[serverData objectForKey:@"webService"] recordID:[serverData objectForKey:@"recordID"] userName:[serverData objectForKey:@"userName"] fieldName:[serverData objectForKey:@"fieldName"] fieldValue:fieldvalue dateTime:dt extractImage:YES  success:^(NSString *message) {
        [_viewcontroller signFinish:uuid callbackID:_callbackID];
        [self loadSignatureWithRecordID:[serverData objectForKey:@"recordID"]];
    } failure:^(NSError *error) {
        [_viewcontroller uploadError:error.description callbackID:_callbackID];
    }];
    
    
}



- (void)loadSignatureWithRecordID:(NSString *)recordID {
    
    [[iAppRevisionService service] loadSignatureWithWebService:@"http://oa.goldgrid.com:88/iWebRevisionEx/iWebServer.jsp" recordID:recordID userName:@"admin" fieldName:@"SendOut" success:^(NSString *fieldValue) {
        
        NSArray *fieldValues = [[iAppRevisionService service]  fieldValuesWithValue:fieldValue  ];
        NSLog(@"fieldValues: %@", fieldValues);
        
    }failure:^(NSError *error) {
        
        NSString *e = [NSString stringWithCString:[[error.userInfo objectForKey:NSLocalizedDescriptionKey] cStringUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)] encoding:NSUTF8StringEncoding];
        NSLog(@"error: %@", e);
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
