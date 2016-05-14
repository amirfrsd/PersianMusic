//
//  DetailViewController.m
//  PersianMusic
//
//  Created by Amir Farsad on 5/14/16.
//  Copyright © 2016 Emersad. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

#pragma mark - Managing the detail item
- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [_timer invalidate];
        _buttonStatus = 0;
    }];
}

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}
-(void)getInfo {
    [self getArtist];
    [self getSongName];
    [self getArtwork];
    [self getLikes];
}
- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}
-(void)getArtist {
    NSString *urlFetcher = @"http://amirfarsad.me/geturl.php";
    NSURL *urlToGo = [NSURL URLWithString:urlFetcher];
    NSString *urlProcessor = [NSString stringWithContentsOfURL:urlToGo encoding:NSUTF8StringEncoding error:nil];
    NSString* scanString = @"";
    if (urlProcessor.length > 0) {
        
        NSScanner* scanner = [[NSScanner alloc] initWithString:urlProcessor];
        
        @try {
            [scanner scanUpToString:@"<span class=\"artist_name\">" intoString:nil];
            scanner.scanLocation += [@"<span class=\"artist_name\">" length];
            [scanner scanUpToString:@"</span>" intoString:&scanString];
        }
        @finally {
            _artistLbl.text = scanString;
        }
        
    }
}
-(void)getSongName {
    NSString *urlFetcher = @"http://amirfarsad.me/geturl.php";
    NSURL *urlToGo = [NSURL URLWithString:urlFetcher];
    NSString *urlProcessor = [NSString stringWithContentsOfURL:urlToGo encoding:NSUTF8StringEncoding error:nil];
    NSString* scanString = @"";
    if (urlProcessor.length > 0) {
        
        NSScanner* scanner = [[NSScanner alloc] initWithString:urlProcessor];
        
        @try {
            [scanner scanUpToString:@"<span class=\"song_name\">" intoString:nil];
            scanner.scanLocation += [@"<span class=\"song_name\">" length];
            [scanner scanUpToString:@"</span>" intoString:&scanString];
        }
        @finally {
            _songName.text = scanString;
        }
        
    }
}
-(void)getArtwork {
    NSString *urlFetcher = @"http://amirfarsad.me/geturl.php";
    NSURL *urlToGo = [NSURL URLWithString:urlFetcher];
    NSString *urlProcessor = [NSString stringWithContentsOfURL:urlToGo encoding:NSUTF8StringEncoding error:nil];
    NSString* scanString = @"";
    if (urlProcessor.length > 0) {
        
        NSScanner* scanner = [[NSScanner alloc] initWithString:urlProcessor];
        
        @try {
            [scanner scanUpToString:@"<img alt=\"\" id=\"song_bg\" src=\"" intoString:nil];
            scanner.scanLocation += [@"<img alt=\"\" id=\"song_bg\" src=\"" length];
            [scanner scanUpToString:@"\" />" intoString:&scanString];
        }
        @finally {
            _artwork.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:scanString]]];
        }
        
    }
}
-(void)getLikes {
    NSString *urlFetcher = @"http://amirfarsad.me/geturl.php";
    NSURL *urlToGo = [NSURL URLWithString:urlFetcher];
    NSString *urlProcessor = [NSString stringWithContentsOfURL:urlToGo encoding:NSUTF8StringEncoding error:nil];
    NSString* scanString = @"";
    if (urlProcessor.length > 0) {
        
        NSScanner* scanner = [[NSScanner alloc] initWithString:urlProcessor];
        
        @try {
            [scanner scanUpToString:@"<span class=\"rating\">" intoString:nil];
            scanner.scanLocation += [@"<span class=\"rating\">" length];
            [scanner scanUpToString:@" likes</span>" intoString:&scanString];
        }
        @finally {
            _likesLabel.text = scanString;
        }
        
    }
}
- (IBAction)playPause:(id)sender {
    if (_buttonStatus == 0) {
        [_player pause];
        _buttonStatus = 1;
        [_playPauseBtn setTitle:@"Play" forState:UIControlStateNormal];
    }
    else {
        [_player play];
        _buttonStatus = 0;
        [_playPauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
    }
}
- (IBAction)sliderAction:(id)sender {
        [_player setVolume:self.mixerSlider.value];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _buttonStatus = 0;
    if (_buttonStatus == 0) {
        [_playPauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else {
        [_playPauseBtn setTitle:@"Play" forState:UIControlStateNormal];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getInfo];
        });
        NSString *streamingString = @"http://208.85.241.142";
        NSURL *streamingURL = [NSURL URLWithString:streamingString];
        _player = [AVPlayer playerWithURL:streamingURL];
        [_player play];
        [_player setVolume:1.0];
        _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        dispatch_async(dispatch_get_main_queue(), ^{
     [hud hide:YES];
            _timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getInfo) userInfo:nil repeats: YES];
        });
    });

    //NSRange searchFromRange = [urlProcessor rangeOfString:@"<span class=\"artist_name\">"];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
