//
//  ZCTextLayer.m
//  ZCHud
//
//  Created by charles on 15/12/15.
//  Copyright © 2015年 charles. All rights reserved.
//

#import "ZCTextLayer.h"
#import <CoreText/CoreText.h>

@implementation ZCTextLayer

- (UIFont *)font {
    if (!_font) {
        _font = [UIFont systemFontOfSize:17];
    }
    return _font;
}

- (UIColor *)fontColor {
    if (!_fontColor) {
        _fontColor = [UIColor colorWithRed:70 / 255.f green:70 / 255.f blue:70 / 255.f alpha:1];
    }
    return _fontColor;
}

- (CGFloat)heightForSelf {
    return 0;
}

- (void)drawInContext:(CGContextRef)ctx {
    if (self.text.length == 0) {
        return;
    }
    
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableDictionary *attributes = [@{} mutableCopy];
    attributes[NSForegroundColorAttributeName] = self.fontColor;
    attributes[NSFontAttributeName] = self.font;
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.alignment = NSTextAlignmentCenter;
    attributes[NSParagraphStyleAttributeName] = style;
    
    [text addAttributes:attributes range:NSMakeRange(0, text.length)];
    
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)text);
    CTFrameRef frameRef = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, text.length), path, NULL);
    CTFrameDraw(frameRef, ctx);
    
    CFRelease(frameRef);
    CFRelease(setterRef);
    CFRelease(path);
}

@end
