//
//  DropBoxTableViewCell.m
//  iOSExercise
//
//  Created by Silsila on 20/05/18.
//  Copyright © 2018 Abc. All rights reserved.
//

#import "DropBoxTableViewCell.h"

@implementation DropBoxTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Allo and init description label
        self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        
        //alloc and init imageview
        self.thumbImage = [[UIImageView alloc] init];
        
        //alloc and init header label
        self.headingLabel = [[UILabel alloc] init];
        self.headingLabel.textColor = [UIColor blackColor];
        self.headingLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
       
        //add programatically created view to cell
        [self addSubview:self.descriptionLabel];
        [self addSubview:self.thumbImage];
        [self addSubview:self.headingLabel];
        
        //add constraints to header , image and description
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.headingLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.thumbImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_thumbImage
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1.0
                                                                      constant:10.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_thumbImage
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:-10.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_thumbImage
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:10.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_thumbImage
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_thumbImage
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:_headingLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:-20.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_thumbImage
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0
                                                          constant:150.0]];

        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_headingLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0
                                                          constant:10.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_headingLabel
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0
                                                          constant:-10.0]];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_headingLabel
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_descriptionLabel
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:-20.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0
                                                          constant:10.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0
                                                          constant:-10.0]];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottomMargin
                                                        multiplier:1.0
                                                          constant:10.0]];
    }
    

    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
