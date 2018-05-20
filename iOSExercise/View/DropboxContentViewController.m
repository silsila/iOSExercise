//
//  DropboxContentViewController.m
//  iOSExercise
//
//  Created by Silsila on 20/05/18.
//  Copyright © 2018 Abc. All rights reserved.
//

#import "DropboxContentViewController.h"
#import "DropBoxTableViewCell.h"
#import "AppDelegate.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "UIImageView+AFNetworking.h"
@interface DropboxContentViewController ()
{
    AppDelegate *appl;
}

@end
extern NSString *PageTitle;
@implementation DropboxContentViewController
{
      NSArray *DataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    //call URL and get Data
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    JsonData *jsondata = [[JsonData alloc] init];
    NSURL *url =[[NSBundle mainBundle] URLForResource:@"Dropbox" withExtension:@"json"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        DataArray = [jsondata DataFromJSONFile:url];
         [self.DropboxTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    });
      //alloc and init and add tableview to Viewcontroller
    self.DropboxTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.DropboxTable.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.DropboxTable.delegate = self;
    self.DropboxTable.dataSource = self;
    self.DropboxTable.estimatedRowHeight  =350;
    self.DropboxTable.rowHeight = UITableViewAutomaticDimension;
    self.DropboxTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.DropboxTable];

}

#pragma mark Tableview Datasource Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.title =  PageTitle;
    static NSString *cellIdentifier = @"cellIdentifier";
    DropBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[DropBoxTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
   
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    cell.thumbImage.image = [UIImage imageNamed:@""];
    cell.thumbImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.thumbImage.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    cell.headingLabel.numberOfLines = 0;
    cell.descriptionLabel.numberOfLines = 0;
    DataContent *datacontent = [DataArray objectAtIndex:indexPath.row];
    if ([datacontent.HeadingString isKindOfClass:[NSString class]])
    {
        cell.headingLabel.text  =  datacontent.HeadingString;
        cell.headingLabel.hidden = NO;
    }
    else
    {
        cell.headingLabel.text  = @"";
        cell.headingLabel.hidden = YES;
    }
    if ([datacontent.DescString isKindOfClass:[NSString class]])
    {
        cell.descriptionLabel.text  =  datacontent.DescString;
        cell.descriptionLabel.hidden = NO;
    }
    else
    {
        cell.descriptionLabel.text  = @"";
        cell.descriptionLabel.hidden = YES;
        
    }
    if ([datacontent.ImageString isKindOfClass:[NSString class]])
    {
       
        [cell.thumbImage cancelImageDownloadTask];
        cell.thumbImage.hidden = NO;
        NSString *url1=datacontent.ImageString;
        [cell.thumbImage setImageWithURL:[NSURL URLWithString:url1]
                         placeholderImage:nil];
        
    }
    else
    {
    }
    return cell;
}

#pragma mark Tableview Delegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
@end
