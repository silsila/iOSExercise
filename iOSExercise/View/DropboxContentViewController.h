//
//  DropboxContentViewController.h
//  iOSExercise
//
//  Created by Silsila on 20/05/18.
//  Copyright © 2018 Abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonData.h"
#import "DataContent.h"
@interface DropboxContentViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

//declared for tableview
@property (strong,nonatomic) UITableView *DropboxTable;

@end
