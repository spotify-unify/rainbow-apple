//
//  ViewController.h
//  rainbowapple
//
//  Created by Tom Macmichael on 16/05/2015.
//  Copyright (c) 2015 Spotify Unify. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitySelectionDelegate <NSObject>
@required
- (void) citySelected:(NSString*)city;
@end

@interface ViewController : UIViewController <CitySelectionDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UILabel *city;
-(void)updateUI;
@end

