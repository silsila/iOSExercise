//
//  DropBoxTableViewCell.h
//  iOSExercise
//
//  Created by Silsila on 20/05/18.
//  Copyright © 2018 Abc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropBoxTableViewCell : UITableViewCell
//label used to display heading in tableviewcell
@property (nonatomic, strong) UILabel *headingLabel;
//label used to display description in tableviewcell
@property (nonatomic, strong) UILabel *descriptionLabel;
//Imageview used to display image in tableviewcell
@property (nonatomic, strong) UIImageView *thumbImage;
@end
