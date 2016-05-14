//
//  DetailViewController.h
//  PersianMusic
//
//  Created by Amir Farsad on 5/14/16.
//  Copyright © 2016 Emersad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

