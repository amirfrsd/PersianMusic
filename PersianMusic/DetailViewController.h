//
//  DetailViewController.h
//  PersianMusic
//
//  Created by Amir Farsad on 5/14/16.
//  Copyright © 2016 Emersad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"


@interface DetailViewController : UIViewController
@property int buttonStatus;
@property (weak, nonatomic) IBOutlet UISlider *mixerSlider;
@property (weak, nonatomic) IBOutlet UIButton *playPauseBtn;
@property MPMoviePlayerController *moviePlayer;
@property AVPlayer *player;
@property (weak, nonatomic) IBOutlet UILabel *dislikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property NSTimer *timer;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *artwork;
@property (weak, nonatomic) IBOutlet UILabel *artistLbl;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

