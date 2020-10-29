
//  UIColor+Chameleon.m

/*
 
 The MIT License (MIT)
 
 Copyright (c) 2014-2015 Vicc Alexander.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

#import "UIColor+Chameleon.h"
#import <objc/runtime.h>
#import "ChameleonMacros.h"

@implementation UIColor (Chameleon)

#pragma mark - Chameleon - Getter & Setter Methods for Instance Variables

+ (void)setGradientImage:(UIImage *)gradientImage {
    
    objc_setAssociatedObject(self, @selector(gradientImage), gradientImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)gradientImage {
    
    return objc_getAssociatedObject(self, @selector(gradientImage));
}

#pragma mark - Chameleon - Light Shades

+ (UIColor *)flatBlackColor {
    return hsb(0, 0, 17);
}

+ (UIColor *)flatBlueColor {
    return hsb(224, 50, 63);
}

+ (UIColor *)flatBrownColor {
    return hsb(24, 45, 37);
}

+ (UIColor *)flatCoffeeColor {
    return hsb(25, 31, 64);
}

+ (UIColor *)flatForestGreenColor {
    return hsb(138, 45, 37);
}

+ (UIColor *)flatGrayColor {
    return hsb(184, 10, 65);
}

+ (UIColor *)flatGreenColor {
    return hsb(145, 77, 80);
}

+ (UIColor *)flatLimeColor {
    return hsb(74, 70, 78);
}

+ (UIColor *)flatMagentaColor {
    return hsb(283, 51, 71);
}

+ (UIColor *)flatMaroonColor {
    return hsb(5, 65, 47);
}

+ (UIColor *)flatMintColor {
    return hsb(168, 86, 74);
}

+ (UIColor *)flatNavyBlueColor {
    return hsb(210, 45, 37);
}

+ (UIColor *)flatOrangeColor {
    return hsb(28, 85, 90);
}

+ (UIColor *)flatPinkColor {
    return hsb(324, 49, 96);
}

+ (UIColor *)flatPlumColor {
    return hsb(300, 45, 37);
}

+ (UIColor *)flatPowderBlueColor {
    return hsb(222, 24, 95);
}

+ (UIColor *)flatPurpleColor {
    return hsb(253, 52, 77);
}

+ (UIColor *)flatRedColor {
    return hsb(6, 74, 91);
}

+ (UIColor *)flatSandColor {
    return hsb(42, 25, 94);
}

+ (UIColor *)flatSkyBlueColor {
    return hsb(204, 76, 86);
}

+ (UIColor *)flatTealColor {
    return hsb(195, 55, 51);
}

+ (UIColor *)flatWatermelonColor {
    return hsb(356, 53, 94);
}

+ (UIColor *)flatWhiteColor {
    return hsb(192, 2, 95);
}

+ (UIColor *)flatYellowColor {
    return hsb(48, 99, 100);
}

#pragma mark - Chameleon - Dark Shades

+ (UIColor *)flatBlackDarkColor {
    return hsb(0, 0, 15);
}

+ (UIColor *)flatBlueDarkColor {
    return hsb(224, 56, 51);
}

+ (UIColor *)flatBrownDarkColor {
    return hsb(25, 45, 31);
}

+ (UIColor *)flatCoffeeDarkColor {
    return hsb(25, 34, 56);
}

+ (UIColor *)flatForestGreenDarkColor {
    return hsb(135, 44, 31);
}

+ (UIColor *)flatGrayDarkColor {
    return hsb(184, 10, 55);
}

+ (UIColor *)flatGreenDarkColor {
    return hsb(145, 78, 68);
}

+ (UIColor *)flatLimeDarkColor {
    return hsb(74, 81, 69);
}

+ (UIColor *)flatMagentaDarkColor {
    return hsb(282, 61, 68);
}

+ (UIColor *)flatMaroonDarkColor {
    return hsb(4, 68, 40);
}

+ (UIColor *)flatMintDarkColor {
    return hsb(168, 86, 63);
}

+ (UIColor *)flatNavyBlueDarkColor {
    return hsb(210, 45, 31);
}

+ (UIColor *)flatOrangeDarkColor {
    return hsb(24, 100, 83);
}

+ (UIColor *)flatPinkDarkColor {
    return hsb(327, 57, 83);
}

+ (UIColor *)flatPlumDarkColor {
    return hsb(300, 46, 31);
}

+ (UIColor *)flatPowderBlueDarkColor {
    return hsb(222, 28, 84);
}

+ (UIColor *)flatPurpleDarkColor {
    return hsb(253, 56, 64);
}

+ (UIColor *)flatRedDarkColor {
    return hsb(6, 78, 75);
}

+ (UIColor *)flatSandDarkColor {
    return hsb(42, 30, 84);
}

+ (UIColor *)flatSkyBlueDarkColor {
    return hsb(204, 78, 73);
}

+ (UIColor *)flatTealDarkColor {
    return hsb(196, 54, 45);
}

+ (UIColor *)flatWatermelonDarkColor {
    return hsb(358, 61, 85);
}

+ (UIColor *)flatWhiteDarkColor {
    return hsb(204, 5, 78);
}

+ (UIColor *)flatYellowDarkColor {
    return hsb(40, 100, 100);
}

#pragma mark - Chameleon - "Color With" Methods

+ (UIColor *)colorWithComplementaryFlatColorOf:(UIColor *)color {
    
    return [[self class] colorWithComplementaryFlatColorOf:color withAlpha:1.0];
}

+ (UIColor *)colorWithComplementaryFlatColorOf:(UIColor *)color withAlpha:(CGFloat)alpha {
    
    //Check if input UIColor is a gradient aka a pattern
    if (CGColorGetPattern(color.CGColor)) {
        
        //Let's find the average color of the image and contrast against that.
        CGSize size = {1, 1};
        
        //Create a 1x1 bitmap context
        UIGraphicsBeginImageContext(size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        //Set the interpolation quality to medium
        CGContextSetInterpolationQuality(ctx, kCGInterpolationMedium);
        
        //Draw image scaled down to this 1x1 pixel
        [[self gradientImage] drawInRect:(CGRect){.size = size} blendMode:kCGBlendModeCopy alpha:1];
        
        //Read the RGB values from the context's buffer
        uint8_t *data = CGBitmapContextGetData(ctx);
        color = [UIColor colorWithRed:data[2] / 255.0f
                                green:data[1] / 255.0f
                                 blue:data[0] / 255.0f
                                alpha:1];
        UIGraphicsEndImageContext();
    }
    
    //Extract & Check to make sure we have an actual color to work with (Clear returns clear)
    CGFloat hue, saturation, brightness, alpha1;
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha1];
    
    //Check if color is transparent
    if (alpha1 == 0) {
        return [UIColor clearColor];
    }
    
    //Multiply our value by their max values to convert
    hue *= 360;
    saturation *= 100;
    brightness *= 100;
    
    //Select a color with a hue 180 degrees away on the colorwheel (i.e. for 50 it would be 230).
    hue += 180.0f;
    if (hue > 360.f) {
        hue -= 360.0f;
    }
    
    //Round to the nearest whole number after multiplying
    hue = roundf(hue);
    saturation = roundf(saturation);
    brightness = roundf(brightness);
    
    //Store complimentary nonflat color
    UIColor *complimentaryNonFlatColor = [UIColor colorWithHue:hue/360.0
                                                    saturation:saturation/100.0
                                                    brightness:brightness/100.0
                                                         alpha:alpha];
    
    //Retrieve LAB values from our complimentary nonflat color & return nearest flat color
    return [self colorWithFlatVersionOf:complimentaryNonFlatColor withAlpha:alpha];
}


+ (UIColor *)colorWithFlatVersionOf:(UIColor *)color {
    
    //Return flat version with default alpha of 1.0
    return [[self class] colorWithFlatVersionOf:color withAlpha:1.0];
}

+ (UIColor *)colorWithFlatVersionFrom:(UIColor *)color {
    CGFloat colorAlpha = 0;
    [color getLightness:nil valueForA:nil valueForB:nil alpha:&colorAlpha];
    colorAlpha = colorAlpha > 0.0 ? colorAlpha : 1.0;
    //Return flat version with default alpha of 1.0
    return [[self class] colorWithFlatVersionOf:color withAlpha:colorAlpha];
}

+ (UIColor * _Nullable)colorWithFlatVersionOf:(UIColor *)color withAlpha:(CGFloat)alpha {
    
    //Check if input UIColor is a gradient aka a pattern
    if (CGColorGetPattern(color.CGColor)) {
        
        //Let's find the average color of the image and contrast against that.
        CGSize size = {1, 1};
        
        //Create a 1x1 bitmap context
        UIGraphicsBeginImageContext(size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        //Set the interpolation quality to medium
        CGContextSetInterpolationQuality(ctx, kCGInterpolationMedium);
        
        //Draw image scaled down to this 1x1 pixel
        [[self gradientImage] drawInRect:(CGRect){.size = size} blendMode:kCGBlendModeCopy alpha:1];
        
        //Read the RGB values from the context's buffer
        uint8_t *data = CGBitmapContextGetData(ctx);
        color = [UIColor colorWithRed:data[2] / 255.0f
                                green:data[1] / 255.0f
                                 blue:data[0] / 255.0f
                                alpha:1];
        UIGraphicsEndImageContext();
    }
    
    //Create CGFloats to hold our color values
    CGFloat L, A, B, alpha1;
    
    //Get LAB values for our color
    [color getLightness:&L valueForA:&A valueForB:&B alpha:&alpha1];
    
    if (![color getLightness:&L valueForA:&A valueForB:&B alpha:&alpha1]) {
        return nil;
    }
    
    //Find the nearest flat color
    return [self nearestFlatColorForL:L A:A B:B alpha:alpha];
}

+ (UIColor *)colorWithContrastingBlackOrWhiteColorOn:(UIColor *)backgroundColor isFlat:(BOOL)flat {
    
    //Return color with default alpha value of 1.0
    return [[self class] colorWithContrastingBlackOrWhiteColorOn:backgroundColor isFlat:flat alpha:1.0];
}

+ (UIColor *)colorWithContrastingBlackOrWhiteColorOn:(UIColor *)backgroundColor
                                              isFlat:(BOOL)flat
                                               alpha:(CGFloat)alpha {
    
    //Check if UIColor is a gradient aka a pattern
    if (CGColorGetPattern(backgroundColor.CGColor)) {
        
        //Let's find the average color of the image and contrast against that.
        CGSize size = {1, 1};
        
        //Create a 1x1 bitmap context
        UIGraphicsBeginImageContext(size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        //Set the interpolation quality to medium
        CGContextSetInterpolationQuality(ctx, kCGInterpolationMedium);
        
        //Draw image scaled down to this 1x1 pixel
        [[self gradientImage] drawInRect:(CGRect){.size = size} blendMode:kCGBlendModeCopy alpha:1];
        
        //Read the RGB values from the context's buffer
        uint8_t *data = CGBitmapContextGetData(ctx);
        backgroundColor = [UIColor colorWithRed:data[2] / 255.0f
                                          green:data[1] / 255.0f
                                           blue:data[0] / 255.0f
                                          alpha:1];
        UIGraphicsEndImageContext();
    }
    
    //Calculate Luminance
    CGFloat luminance;
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha1 = 0.0;
    [backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha1];
    
    //Check if color is transparent
    if (alpha == 0) {
        return [UIColor clearColor];
    }
    
    // Relative luminance in colorimetric spaces - http://en.wikipedia.org/wiki/Luminance_(relative)
    red *= 0.2126f; green *= 0.7152f; blue *= 0.0722f;
    luminance = red + green + blue;
    
    if (flat == NO) {
        return (luminance > 0.6f) ? rgba(0, 0, 0, alpha) : rgba(255, 255, 255, alpha);
    } else {
        return (luminance > 0.6f) ? hsba(0, 0, 15, alpha) : hsba(192, 2, 95, alpha);
    }
}

+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string {
    
    //Color with string and a defualt alpha value of 1.0
    return [self colorWithHexString:string withAlpha:1.0];
}

+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string withAlpha:(CGFloat)alpha {
 
    //Quick return in case string is empty
    if (string.length == 0) {
        return nil;
    }
    
    //Check to see if we need to add a hashtag
    if('#' != [string characterAtIndex:0]) {
        string = [NSString stringWithFormat:@"#%@", string];
    }
    
    //Make sure we have a working string length
    if (string.length != 7 && string.length != 4) {
        
        #ifdef DEBUG
        NSLog(@"Unsupported string format: %@", string);
        #endif
        
        return nil;
    }
    
    //Check for short hex strings
    if(string.length == 4) {
        
        //Convert to full length hex string
        string = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                     [string substringWithRange:NSMakeRange(1, 1)],[string substringWithRange:NSMakeRange(1, 1)],
                     [string substringWithRange:NSMakeRange(2, 1)],[string substringWithRange:NSMakeRange(2, 1)],
                     [string substringWithRange:NSMakeRange(3, 1)],[string substringWithRange:NSMakeRange(3, 1)]];
    }
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(1, 2)]];
    unsigned red = [[self class] hexValueToUnsigned:redHex];
    
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(3, 2)]];
    unsigned green = [[self class] hexValueToUnsigned:greenHex];
    
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(5, 2)]];
    unsigned blue = [[self class] hexValueToUnsigned:blueHex];
    
    return [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
}

+ (unsigned)hexValueToUnsigned:(NSString *)hexValue {
    
    //Define default unsigned value
    unsigned value = 0;
    
    //Scan unsigned value
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    //Return found value
    return value;
}

#pragma mark - Chameleon - Random Color Methods

+ (NSInteger)generateRandomNumberWithMax:(NSInteger)max {
    
    //Choose a random number between 0 and our number of available colors
    return arc4random_uniform((UInt32)max);
}

+ (UIColor *)randomFlatColor {
    
    //Number of colors to choose from
    const uint32_t numberOfPossibleColors = 48;
    
    //Chose one of those colors at random
    NSInteger randomColorChosen = [[self class] generateRandomNumberWithMax:numberOfPossibleColors];
    
    //Check if a previous random number exists
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"previousRandomNumber"]) {
        
        //If no previous number exists, save it as such and find the matching color
        [[NSUserDefaults standardUserDefaults] setInteger:randomColorChosen forKey:@"previousRandomNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        
        //Keep generating a random number until it is different than the one generated last time
        while (randomColorChosen == [[NSUserDefaults standardUserDefaults] integerForKey:@"previousRandomNumber"]) {
            randomColorChosen = [[self class] generateRandomNumberWithMax:numberOfPossibleColors];
        }
        
        //Once a new number has been generated then store it as the previous number for next time and proceed
        [[NSUserDefaults standardUserDefaults] setInteger:randomColorChosen forKey:@"previousRandomNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return [self flatColors][randomColorChosen];
}

+ (UIColor * _Nullable)colorWithRandomColorInArray:(NSArray<UIColor *> *)colors {
    
    UIColor *randomColor;
    if (colors.count) {
        
        //Pick a random index
        NSInteger randomIndex = arc4random() % colors.count;
        
        //Return the color at the random index
        randomColor = colors[randomIndex];
        
    } else {
        return nil;
    }
    
    NSAssert([randomColor isKindOfClass:[UIColor class]], @"Hmm... one of your objects in your 'colors' array is not a UIColor object.");
    
    //Return
    return randomColor;
}

+ (UIColor *)colorWithRandomFlatColorExcludingColorsInArray:(NSArray<UIColor *> *)colors {
    
    //Set random flat color
    UIColor *randomColor = [[self class] randomFlatColor];
    
    //If the selected color is blacklisted select a new color
    while ([colors containsObject:randomColor]) {
        randomColor = [[self class] randomFlatColor];
    }
    
    //Return
    return randomColor;
}


#pragma mark - Chameleon Instance Methods

- (UIColor *)flatten {
    
    return [UIColor colorWithFlatVersionFrom:self];
}

- (NSString *)hexValue {
    
    UIColor *currentColor = self;
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        currentColor = [UIColor colorWithRed:components[0] green:components[0] blue:components[0] alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(currentColor.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(currentColor.CGColor))[0]*255.0), (int)((CGColorGetComponents(currentColor.CGColor))[1]*255.0), (int)((CGColorGetComponents(currentColor.CGColor))[2]*255.0)];
    
}

- (UIColor * _Nullable)darkenByPercentage:(CGFloat)percentage {
    
    //Define HSBA values
    CGFloat h, s, b, a;
    
    //Check if HSBA values exist
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a]) {
        
        //Make sure our percentage is greater than 0
        if (percentage > 0) {
            b = MIN(b - percentage, 1.0);
        }
        
        //Return darker color
        return [UIColor colorWithHue:h saturation:s brightness:b alpha:a];
    }
    
    return nil;
}

- (UIColor * _Nullable)lightenByPercentage:(CGFloat)percentage {
    
    //Define HSBA values
    CGFloat h, s, b, a;
    
    //Check if HSBA values exist
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a]) {
        
        //Make sure our percentage is greater than 0
        if (percentage > 0) {
           b = MIN(b + percentage, 1.0);
        }
        
        //Return lighter color
        return [UIColor colorWithHue:h saturation:s brightness:b alpha:a];
    }
    
    return nil;
}

- (UIColor * _Nullable)desaturateByPercentage:(CGFloat)percentage {
    
    //Define HSBA values
    CGFloat h, s, b, a;
    
    //Check if HSBA values exist
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a]) {
        
        //Make sure our percentage is greater than 0
        if (percentage > 0) {
            s = MIN(s - percentage, 1.0);
        }
        
        //Return darker color
        return [UIColor colorWithHue:h saturation:s brightness:b alpha:a];
    }
    
    return nil;
}

- (UIColor * _Nullable)saturateByPercentage:(CGFloat)percentage {
    
    //Define HSBA values
    CGFloat h, s, b, a;
    
    //Check if HSBA values exist
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a]) {
        
        //Make sure our percentage is greater than 0
        if (percentage > 0) {
           s = MIN(s + percentage, 1.0);
        }
        
        //Return lighter color
        return [UIColor colorWithHue:h saturation:s brightness:b alpha:a];
    }
    
    return nil;
}

- (BOOL)isEqualToColor:(UIColor *)color {
    
    //Check if both colors are in the Monochrome / RGB color space
    if ([self isMonochromeOrRGB] && [color isMonochromeOrRGB]) {
        
        //Return comparison
        return self.RGBAValue == color.RGBAValue;
    }
    
    //Return comparison
    return [self isEqual:color];
}

#pragma mark - Chameleon Internal Methods

//Array of all our colors
+ (NSArray *)flatColors {

    return @[FlatBlack, FlatBlackDark, FlatBlue, FlatBlueDark, FlatBrown, FlatBrownDark, FlatCoffee, FlatCoffeeDark, FlatForestGreen, FlatForestGreenDark, FlatGray, FlatGrayDark, FlatGreen, FlatGreenDark, FlatLime, FlatLimeDark, FlatMagenta, FlatMagentaDark, FlatMaroon, FlatMaroonDark, FlatMint, FlatMintDark, FlatNavyBlue, FlatNavyBlueDark, FlatOrange, FlatOrangeDark, FlatPink, FlatPinkDark, FlatPlum, FlatPlumDark, FlatPowderBlue, FlatPowderBlueDark, FlatPurple, FlatPurpleDark, FlatRed, FlatRedDark, FlatSand, FlatSandDark, FlatSkyBlue, FlatSkyBlueDark, FlatTeal, FlatTealDark, FlatWatermelon, FlatWatermelonDark, FlatWhite, FlatWhiteDark, FlatYellow, FlatYellowDark];
}

- (uint32_t)RGBAValue {
    
    CGFloat rgba[4];
    [self getRGBAComponents:rgba];
    uint8_t red = rgba[0]*255;
    uint8_t green = rgba[1]*255;
    uint8_t blue = rgba[2]*255;
    uint8_t alpha = rgba[3]*255;
    
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}

- (void)getRGBAComponents:(CGFloat[4])rgba {
    
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    switch (model) {
            
        case kCGColorSpaceModelMonochrome: {
            rgba[0] = components[0];
            rgba[1] = components[0];
            rgba[2] = components[0];
            rgba[3] = components[1];
            break;
        }
            
        case kCGColorSpaceModelRGB: {
            rgba[0] = components[0];
            rgba[1] = components[1];
            rgba[2] = components[2];
            rgba[3] = components[3];
            break;
        }

        case kCGColorSpaceModelXYZ:
        case kCGColorSpaceModelCMYK:
        case kCGColorSpaceModelDeviceN:
        case kCGColorSpaceModelIndexed:
        case kCGColorSpaceModelLab:
        case kCGColorSpaceModelPattern:
        case kCGColorSpaceModelUnknown: {
            
            #ifdef DEBUG
            NSLog(@"Unsupported color model: %i", model);
            #endif
            
            rgba[0] = 0.0f;
            rgba[1] = 0.0f;
            rgba[2] = 0.0f;
            rgba[3] = 1.0f;
            break;
        }
    }
}

//Check if color is in the monochrome or rgb color space
- (BOOL)isMonochromeOrRGB {
    
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    return model == kCGColorSpaceModelMonochrome || model == kCGColorSpaceModelRGB;
}

//Calculate the total sum of differences - Euclidian distance
//Chameleon is now using the CIEDE2000 formula to calculate distances between 2 colors.
//More info: http://en.wikipedia.org/wiki/Color_difference
+ (float)totalSumOfDifferencesFroml1:(CGFloat)L1 l2:(CGFloat)L2 a1:(CGFloat)A1
                                  a2:(CGFloat)A2 b1:(CGFloat)B1 b2:(CGFloat)B2 {

    //Get C Values in LCH from LAB Values
    CGFloat C1 = sqrt(pow(A1, 2) + pow(B1, 2));
    CGFloat C2 = sqrt(pow(A2, 2) + pow(B2, 2));
    
    //CIE Weights
    CGFloat KL = 1;
    CGFloat KC = 1;
    CGFloat KH = 1;
    
    //Variables specifically set for CIE:2000
    CGFloat DeltaPrimeL = L2 - L1;
    CGFloat MeanL = ((L1 + L2) / 2);
    CGFloat MeanC = ((C1 + C2) / 2);
    CGFloat A1Prime = A1 + A1 / 2 * (1 - sqrt(pow(MeanC, 7.0) / (pow(MeanC, 7.0) + pow(25.0, 7.0))));
    CGFloat A2Prime = A2 + A2 / 2 * (1 - sqrt(pow(MeanC, 7.0) / (pow(MeanC, 7.0) + pow(25.0, 7.0))));
    CGFloat C1Prime = sqrt(pow(A1Prime, 2) + pow(B1, 2));
    CGFloat C2Prime = sqrt(pow(A2Prime, 2) + pow(B2, 2));
    CGFloat DeltaPrimeC = C1Prime - C2Prime;
    CGFloat DeltaC = C1 - C2;
    CGFloat MeanCPrime = (C1Prime + C2Prime) / 2;
    CGFloat H1Prime = fmodf(atan2(B1, A1Prime), (360.0 * M_PI/180));
    CGFloat H2Prime = fmodf(atan2(B2, A2Prime), (360.0 * M_PI/180));
    
    //Run everything through our △H' Function
    CGFloat hDeltaPrime = 0;
    if (fabs(H1Prime - H2Prime) <= (180.0 * M_PI/180)) {
        
        hDeltaPrime = H2Prime - H1Prime;
        
    } else if (H2Prime <= H1Prime) {
        
        hDeltaPrime = (H2Prime - H1Prime) + ((360.0 * M_PI/180));
        
    } else {
        
        hDeltaPrime = (H2Prime - H1Prime) - ((360.0 * M_PI/180));
    }
    
    CGFloat deltaHPrime = 2 * (sqrt(C1Prime*C2Prime)) * sin(hDeltaPrime/2);
    
    //Get Mean H' Value
    CGFloat MeanHPrime = 0;
    if (fabs(H1Prime-H2Prime) > (180.0 * M_PI/180)) {
        
        MeanHPrime = (H1Prime + H2Prime + (360.0 * M_PI/180)) / 2;
        
    } else {
        
        MeanHPrime = (H1Prime + H2Prime) / 2;
    }
    
    CGFloat T =  1 - 0.17 * cos(MeanHPrime - (30.0 * M_PI/180)) + 0.24 * cos(2 * MeanHPrime)+0.32 * cos(3 * MeanHPrime + (6.0 * M_PI/180)) - 0.20 * cos(4 * MeanHPrime - (63.0 * M_PI/180));
    
    CGFloat SL = 1 + (0.015 * pow((MeanL - 50), 2))/sqrt(20 + pow((MeanL - 50), 2));
    CGFloat SC = 1 + 0.045 * MeanCPrime;
    CGFloat SH = 1 + 0.015 * MeanCPrime * T;
    
    CGFloat RT = -2 * sqrt(pow(MeanCPrime, 7) / (pow(MeanCPrime, 7) + pow(25.0, 7))) * sin((60.0 * M_PI/180)* exp(-1 * pow((MeanCPrime - (275.0 * M_PI/180)) / (25.0 * M_PI/180), 2)));
    
    
    //Get total difference
    CGFloat TotalDifference = sqrt(pow((DeltaPrimeL / (KL * SL)), 2) + pow((DeltaPrimeC / (KC * SC)), 2) + pow((deltaHPrime / (KH * SH)), 2) + RT * (DeltaC / (KC * SC)) * (deltaHPrime / (KH * SH)));
    
    return TotalDifference;
}

+ (UIColor *)nearestFlatColorForL:(CGFloat)l1 A:(CGFloat)a1 B:(CGFloat)b1 alpha:(CGFloat)alpha{
    
    //Keep track of our index
    int index = 0;
    
    //Start with a random big number to make sure the first comparison gets saved.
    float smallestDistance = 1000000;
    float previousDistance = 1000000;
    float currentDistance;
    
    //Our values
    CGFloat l2, a2, b2;
    
    //We're interested in the color with values returning the smallest sum of total differences so we need to cross reference our input color's values with every flat color's values
    for (int i=0; i<[[self flatColors] count]; i++ ) {
        
        //Check that index is not zero
        if (i!=0 ) {
            //Extract LAB values from colors in array and store it as the previous index
            [[self flatColors][i - 1] getLightness:&l2 valueForA:&a2 valueForB:&b2 alpha:nil];
            
            previousDistance = [self totalSumOfDifferencesFroml1:l1 l2:l2
                                                              a1:a1 a2:a2
                                                              b1:b1 b2:b2];
        }
        
        //Extract LAB values from colors in array and store it as the current index
        [[self flatColors][i] getLightness:&l2 valueForA:&a2 valueForB:&b2 alpha:nil];
        
        currentDistance = [self totalSumOfDifferencesFroml1:l1 l2:l2
                                                         a1:a1 a2:a2
                                                         b1:b1 b2:b2];
        
        //We're only interested in the smallest difference
        if (currentDistance < previousDistance) {
            if (currentDistance < smallestDistance) {
                smallestDistance = currentDistance;
                index = i;
            }
        }
    }

    
    //Collect the RGB Values of the color where the smallest difference was found
    CGFloat red, green, blue;
    [[self flatColors][index] getRed:&red green:&green blue:&blue alpha:nil];

    //Return the closest flat color
    return rgba(red * 255, green * 255, blue * 255, alpha);
}

- (BOOL)getLightness:(CGFloat *)L valueForA:(CGFloat *)A valueForB:(CGFloat *)B alpha:(CGFloat *)alpha {

    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {

        //Get RGB values from the input color
        CGFloat red = 0, green = 0, blue = 0, alpha1 = 0;
        [self getRed:&red green:&green blue:&blue alpha:&alpha1];

        //Run our input color's RGB values through the XYZ algorithm to convert them into XYZ values
        NSArray *XYZValues = [self arrayOfXYZValuesForR:red G:green B:blue A:alpha1];
        CGFloat X = [XYZValues[0] floatValue];
        CGFloat Y = [XYZValues[1] floatValue];
        CGFloat Z = [XYZValues[2] floatValue];

        if (L != nil && A != nil && B != nil) {
            //Run our new XYZ values through our LAB algorithm to convert them into LAB values
            NSArray *LABValues = [self arrayOfLABValuesForX:X Y:Y Z:Z alpha:alpha1];
            *L = [LABValues[0] floatValue];
            *A = [LABValues[1] floatValue];
            *B = [LABValues[2] floatValue];
        }

        return YES;
    }

    return NO;
}

- (NSArray *)arrayOfXYZValuesForR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {

    /*
     Let's begin by converting from RGB to sRGB.
     We're going to use the Reverse Transformation Equation.
     http://en.wikipedia.org/wiki/SRGB
     */

    void (^sRGB)(CGFloat *C);
    sRGB = ^(CGFloat *C) {
        if (*C > 0.04045) {
            *C = pow(((*C + 0.055)/ (1 + 0.055)), 2.40);
        } else {
            *C /= 12.92;
        }
    };

    sRGB(&red);
    sRGB(&green);
    sRGB(&blue);

    /*
     Now we're going to convert to XYZ values, using a matrix multiplication of the linear values
     http://upload.wikimedia.org/math/4/3/3/433376fc18cccd887758beffb7e7c625.png
     */

    CGFloat X = (red * 0.4124) + (green * 0.3576) + (blue * 0.1805);
    CGFloat Y = (red * 0.2126) + (green * 0.7152) + (blue * 0.0722);
    CGFloat Z = (red * 0.0193) + (green * 0.1192) + (blue * 0.9505);

    X *= 100;
    Y *= 100;
    Z *= 100;

    return @[@(X), @(Y), @(Z), @(alpha)];
}

- (NSArray *)arrayOfLABValuesForX:(CGFloat)X Y:(CGFloat)Y Z:(CGFloat)Z alpha:(CGFloat)alpha {

    /*
     The corresponding original XYZ values are such that white is D65 with unit luminance (X,Y,Z = 0.9505, 1.0000, 1.0890).
     Calculations are also to assume the 2° standard colorimetric observer.
     D65: http://en.wikipedia.org/wiki/CIE_Standard_Illuminant_D65
     Standard Colorimetric Observer: http://en.wikipedia.org/wiki/Standard_colorimetric_observer#CIE_standard_observer

     Since we mutiplied our XYZ values by 100 to produce a percentage we should also multiply our unit luminance values by 100.
     */

    X /= (0.9505 * 100);
    Y /= (1.0000 * 100);
    Z /= (1.0890 * 100);

    /*
     Next we need to use the forward transformation function for CIELAB-CIEXYZ conversions
     Function: http://upload.wikimedia.org/math/e/5/1/e513d25d50d406bfffb6ed3c854bd8a4.png
     */

    void (^XYZtoLAB)(CGFloat *f);
    XYZtoLAB = ^(CGFloat *f) {
        if ((*f > pow((6.0/29.0), 3.0)) ) {
            *f = pow(*f, 1.0/3.0);
        } else {
            *f = (1/3)*pow((29.0/6.0), 2.0) * *f + 4/29.0;
        }
    };

    XYZtoLAB(&X);
    XYZtoLAB(&Y);
    XYZtoLAB(&Z);

    /*
     Next we get our LAB values using the following equations and the results from the function above
     http://upload.wikimedia.org/math/0/0/6/006164b74314e2fdcdc34ac9d0aa6fe4.png
     */

    CGFloat L = (116 * Y) - 16;
    CGFloat A = 500 * (X - Y);
    CGFloat B = 200 * (Y - Z);


    return @[@(L), @(A), @(B), @(alpha)];
}

@end
