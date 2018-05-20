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

@implementation DropboxContentViewController
{
      NSArray *DataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    JsonData *jsondata = [[JsonData alloc] init];
      NSURL *url = [[NSBundle mainBundle] URLForResource:@"Dropbox" withExtension:@"json"];
    
    //NSString* urlString = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        DataArray = [jsondata DataFromJSONFile:url];
         [self.DropboxTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    });
    self.DropboxTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.DropboxTable.delegate = self;
    self.DropboxTable.dataSource = self;
    self.DropboxTable.estimatedRowHeight  =250;
    self.DropboxTable.rowHeight = UITableViewAutomaticDimension;
    self.DropboxTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.DropboxTable];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    appl = (AppDelegate *)[[UIApplication sharedApplication]delegate];
     self.navigationItem.title = appl.PageTitle;
    static NSString *cellIdentifier = @"cellIdentifier";
    
    DropBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[DropBoxTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
    }
    cell.thumbImage.image = [UIImage imageNamed:@""];
    cell.headingLabel.textAlignment = NSTextAlignmentCenter;
    cell.headingLabel.numberOfLines = 0;
    cell.descriptionLabel.numberOfLines = 0;
    DataContent *datacontent = [DataArray objectAtIndex:indexPath.row];
    if ([datacontent.HeadingArray isKindOfClass:[NSString class]])
    {
        cell.headingLabel.text  =  datacontent.HeadingArray;
        cell.headingLabel.hidden = NO;
    }
    else
    {
        cell.headingLabel.text  = @"";
        cell.headingLabel.hidden = YES;
    }
    if ([datacontent.DescArray isKindOfClass:[NSString class]])
    {
        cell.descriptionLabel.text  =  datacontent.DescArray;
        cell.descriptionLabel.hidden = NO;
    }
    else
    {
        cell.descriptionLabel.text  = @"";
        cell.descriptionLabel.hidden = YES;

    }
    if ([datacontent.ImageArray isKindOfClass:[NSString class]])
    {
        cell.thumbImage.hidden = NO;
        NSString *url1=datacontent.ImageArray;
        [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:url1]
        placeholderImage:[UIImage imageNamed:@"waiting.png"]];

    }
    else
    {
        cell.thumbImage.hidden = YES;
    }
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
