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
#import <AFNetworking/UIImageView+AFNetworking.h> //third party framework used for image download
#import "UIImageView+AFNetworking.h"  //third party framework used for image download
#import <AFNetworking/UIImageView+AFNetworking.h>  //third party framework used for image download
#import <AFNetworking/AFImageDownloader.h> //third party framework used for image download
#import <AFNetworking/AFAutoPurgingImageCache.h>  //third party framework used for image download
@interface DropboxContentViewController ()
{
    AppDelegate *appl;
}

@end
//Global String declared for displaying the page title
extern NSString *PageTitle;

@implementation DropboxContentViewController
{
    //array declared to hold json data
    NSArray *DataArray;
    
    //refresh controller for refreshing the content
    UIRefreshControl *refreshController;
    
    //declared to access the methods and parse Json
    JsonData *jsondata;
    
    //url declared for creating the JSON URL
    NSURL *url;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    //used to change navigationbar tint color
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    //allocate json
    jsondata = [[JsonData alloc] init];
    
    //create Json URL
    url =[[NSBundle mainBundle] URLForResource:@"Dropbox" withExtension:@"json"];

    //calling method for removing the cache
    [self removecache];
    //calling method for Json Parsing
    [self getJsonData];
    
      //alloc and init tableview
    self.DropboxTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //addedd flexible width and height to tableview
    self.DropboxTable.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
   
    //deledate and datasource are adapted
    self.DropboxTable.delegate = self;
    self.DropboxTable.dataSource = self;
    
    //declared row height
    self.DropboxTable.estimatedRowHeight  =350;
    
    //tableview cell  height will change according tothe content
    self.DropboxTable.rowHeight = UITableViewAutomaticDimension;
    
    //removed footerview
    self.DropboxTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //tableview added to UIview
    [self.view addSubview:self.DropboxTable];
    
    //allocated the refresh control
    refreshController = [[UIRefreshControl alloc] init];
    //added method to refresh the content
    [refreshController addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    //refresh controller added to tableview
    [self.DropboxTable addSubview:refreshController];
    
    //created barbutton for refresh the table content
    UIBarButtonItem *barBtn1 =[[UIBarButtonItem alloc]initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refreshtablecontent:)];
    //barbutton added to navigationcontroller
    self.navigationItem.rightBarButtonItem=barBtn1;

}
//method used for refreshing the tablecontent
-(void)refreshtablecontent : (id)sender
{
    //calling method for removing the cache
    [self removecache];
    //calling method for Json Parsing
    [self getJsonData];
    //assign page title
    self.navigationItem.title =  PageTitle;
    //end the refresh process
    [refreshController endRefreshing];
}
-(void)handleRefresh : (id)sender
{
    [self removecache];
    [self getJsonData];

    [refreshController endRefreshing];
   
}
-(void) removecache
{
    //get the default instance of the imageloader(thirdparty library)
    AFImageDownloader *imageDownloader = [AFImageDownloader defaultInstance];
    //used to get all the cached files
    NSURLCache *urlCache = imageDownloader.sessionManager.session.configuration.URLCache;
    //remove the cache
    [urlCache removeAllCachedResponses];
    [imageDownloader.imageCache removeAllImages];
}
-(void) getJsonData
{
    //created GCD for parsing data in background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        DataArray = [jsondata DataFromJSONFile:url];
        
        //once data loaded from json refresh the tableview
        [self.DropboxTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    });
}

#pragma mark Tableview Datasource Method

//declare tableview section count
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//declare tableview rows in each section count
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DataArray.count;
}
//display tableview rows with json content
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     //assign page title
    self.navigationItem.title =  PageTitle;
    [self removecache];
    //created cell idnetifier
    static NSString *cellIdentifier = @"cellIdentifier";
    //dequeing the cell for further use
    DropBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        //if cell is empty creating new cell
        cell = [[DropBoxTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
   //extended separator line
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    //assigned imageview with empty image
    cell.thumbImage.image = [UIImage imageNamed:@""];
    //image content mode added
    cell.thumbImage.contentMode = UIViewContentModeScaleAspectFit;
    //added background color for imageview
    cell.thumbImage.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    //heading and description label assigned with n number of lines
    cell.headingLabel.numberOfLines = 0;
    cell.descriptionLabel.numberOfLines = 0;
    
    //getting the data for each row using datacontent
    DataContent *datacontent = [DataArray objectAtIndex:indexPath.row];
    //check the heading is empty
    if ([datacontent.HeadingString isKindOfClass:[NSString class]])
    {
        //assign the heading according to the index
        cell.headingLabel.text  =  datacontent.HeadingString;
        cell.headingLabel.hidden = NO;
    }
    else
    {
        cell.headingLabel.text  = @"";
        cell.headingLabel.hidden = YES;
    }
    //check the description is empty
    if ([datacontent.DescString isKindOfClass:[NSString class]])
    {
        //assign the descriptionLabel according to the index
        cell.descriptionLabel.text  =  datacontent.DescString;
        cell.descriptionLabel.hidden = NO;
    }
    else
    {
        cell.descriptionLabel.text  = @"";
        cell.descriptionLabel.hidden = YES;
        
    }
    //check the imagestring is empty
    if ([datacontent.ImageString isKindOfClass:[NSString class]])
    {
       //assign the image according to the index
        [cell.thumbImage cancelImageDownloadTask];
        cell.thumbImage.hidden = NO;
        //getting image url string for the index
        NSString *url1=datacontent.ImageString;
        //assigning image to imageview using thirdparty library
        [cell.thumbImage setImageWithURL:[NSURL URLWithString:url1]
                         placeholderImage:nil];
        
    }
    else
    {
    }
    return cell;
}

#pragma mark Tableview Delegate Method
//tableview height will be assigned as per the content
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
