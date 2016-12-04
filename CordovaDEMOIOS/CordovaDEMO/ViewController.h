//
//  ViewController.h
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/1.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
{
    

}
@property (weak, nonatomic) IBOutlet UIButton *btnweb1;
@property (weak, nonatomic) IBOutlet UIButton *btnweb2;

@property (weak, nonatomic) IBOutlet UIButton *btndownload1;
@property (weak, nonatomic) IBOutlet UIButton *btndownload2;
@property (weak, nonatomic) IBOutlet UILabel *labstate1;
@property (weak, nonatomic) IBOutlet UILabel *labstate2;

- (IBAction)clickweb1:(id)sender;
- (IBAction)clickweb2:(id)sender;

- (IBAction)clickdownload1:(id)sender;
- (IBAction)clickdownload2:(id)sender;




@end

