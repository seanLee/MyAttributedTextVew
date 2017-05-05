//
//  ViewController.m
//  TestTextView
//
//  Created by Sean on 2017/5/5.
//  Copyright © 2017年 Sean. All rights reserved.
//

#define kLinebreakKey @"\n"
#define kTextFont [UIFont systemFontOfSize:25.f]
#define kLineSpacing 20.f

#import "ViewController.h"
#import "UIImage+Common.h"

@interface ViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = kLineSpacing;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:kTextFont,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _myTextView.typingAttributes = attributes;
    _myTextView.delegate = self;
}

- (IBAction)addAction:(id)sender {
    UIImage *image = [UIImage imageNamed:@"roar"];
    
    NSMutableAttributedString *string = self.myTextView.attributedText.mutableCopy;
//    NSRange textRange = self.myTextView.selectedRange;
//    if (textRange.location != 0) {
//        NSString *lastString = [string attributedSubstringFromRange:NSMakeRange(textRange.location - 1, 1)].string;
//        if (![lastString isEqualToString:kLinebreakKey]) {
//            NSAttributedString *lineBreakString = [[NSAttributedString alloc] initWithString:kLinebreakKey];
//            [string appendAttributedString:lineBreakString];
//        }
//    }
    
    CGFloat contentWidth = CGRectGetWidth(_myTextView.frame);
    CGFloat scale = (contentWidth - 8.f) / image.size.width;
    if (scale > 1) {
        scale = 1;
    }
    
    image = [image scaledToSize:CGSizeMake(image.size.width * scale, image.size.height * scale)];
    
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    attachment.image = image;
    
    //图片
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    [string appendAttributedString:textAttachmentString];
    
    //换行
    NSMutableAttributedString *lineBreakString = [[NSMutableAttributedString alloc] initWithString:kLinebreakKey];
    [string appendAttributedString:lineBreakString];
    
    //重新设置换行
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = kLineSpacing;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:kTextFont,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.myTextView.attributedText = string ;
    self.myTextView.typingAttributes = attributes;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = kLineSpacing;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:kTextFont,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.typingAttributes = attributes;
}

@end
