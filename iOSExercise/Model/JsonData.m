//
//  JsonData.m
//  iOSExercise
//
//  Created by Silsila on 20/05/18.
//  Copyright © 2018 Abc. All rights reserved.
//

#import "JsonData.h"
#import "DataContent.h"
#import "DropboxContentViewController.h"
#import "AppDelegate.h"

@interface JsonData ()
{
    AppDelegate *appl;
}
@end
NSString *PageTitle;
@implementation JsonData

- (NSArray *)DataFromJSONFile:(NSURL *)url;
{
    // Create a NSURLRequest with the given URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:30.0];
    
    // Get the data
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    // Now create a NSDictionary from the JSON data
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"title is %@",jsonDictionary);
    PageTitle = [jsonDictionary objectForKey:@"title"];

    // Create a new array to hold the data
    NSMutableArray *rows = [[NSMutableArray alloc] init];
    
    // Get an array of dictionaries with the key "Rows"
    NSArray *array = [jsonDictionary objectForKey:@"rows"];
    // Iterate through the array of dictionaries
    for(NSDictionary *dict in array)
    {
        // Create a new data object for each one and initialise it with information in the dictionary
        DataContent *datacontent = [[DataContent alloc] initWithJSONDictionary:dict];
        // Add the data object to the array
        [rows addObject:datacontent];
    }
//    appl = [[UIApplication sharedApplication]delegate];
//    appl.PageTitle = self.PageTitle;
    // Return the array of data objects
    return rows;
}
@end
