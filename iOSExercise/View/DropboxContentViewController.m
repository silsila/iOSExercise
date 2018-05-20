//
//  DropboxContentViewController.m
//  iOSExercise
//
//  Created by Silsila on 20/05/18.
//  Copyright © 2018 Abc. All rights reserved.
//

#import "DropboxContentViewController.h"
#import "DropBoxTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"
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
      NSURL *url = [[NSBundle mainBundle] URLForResource:@"Dropbox" withExtension:@"json"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        DataArray = [jsondata DataFromJSONFile:url];
         [self.DropboxTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    });
      //alloc and init and add tableview to Viewcontroller
    self.DropboxTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.DropboxTable.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.DropboxTable.delegate = self;
    self.DropboxTable.dataSource = self;
    self.DropboxTable.estimatedRowHeight  =250;
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
    cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
    cell.thumbImage.image = [UIImage imageNamed:@""];
    cell.headingLabel.textAlignment = NSTextAlignmentCenter;
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
        cell.thumbImage.hidden = NO;
        NSString *url1=datacontent.ImageString;
        [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:url1]
                           placeholderImage:[UIImage imageNamed:@"waiting.png"]];
        
    }
    else
    {
        cell.thumbImage.hidden = YES;
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
@end
