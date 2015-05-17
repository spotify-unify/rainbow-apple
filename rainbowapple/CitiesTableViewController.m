//
//  CitiesTableViewController.m
//  rainbowapple
//
//  Created by Tom Macmichael on 17/05/2015.
//  Copyright (c) 2015 Spotify Unify. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "CityTableViewCell.h"
#import "ViewController.h"

@interface CitiesTableViewController ()

@end

@implementation CitiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"city-country" forIndexPath:indexPath];
    NSDictionary *cityData = [self cityDataForIndex:indexPath.row];
    cell.cityLabel.text = [cityData objectForKey:@"city"];
    cell.countryLabel.text = [cityData objectForKey:@"country"];
    return cell;
}

-(NSDictionary*)cityDataForIndex:(NSInteger)index {
    NSMutableDictionary *cityData = [NSMutableDictionary new];
    switch (index) {
        case 0:
            [cityData setObject:@"Stockholm" forKey:@"city"];
            [cityData setObject:@"Sweden" forKey:@"country"];
            break;
        case 1:
            [cityData setObject:@"London" forKey:@"city"];
            [cityData setObject:@"UK" forKey:@"country"];
            break;
        case 2:
            [cityData setObject:@"Berlin" forKey:@"city"];
            [cityData setObject:@"Germany" forKey:@"country"];
            break;
        case 3:
            [cityData setObject:@"Amsterdam" forKey:@"city"];
            [cityData setObject:@"Netherlands" forKey:@"country"];
            break;
        case 4:
            [cityData setObject:@"New York" forKey:@"city"];
            [cityData setObject:@"USA" forKey:@"country"];
            break;
        case 5:
            [cityData setObject:@"Stockholm" forKey:@"city"];
            [cityData setObject:@"Sweden" forKey:@"country"];
            break;
        case 6:
            [cityData setObject:@"Stockholm" forKey:@"city"];
            [cityData setObject:@"Sweden" forKey:@"country"];
            break;
        case 7:
            [cityData setObject:@"Stockholm" forKey:@"city"];
            [cityData setObject:@"Sweden" forKey:@"country"];
            break;
        case 8:
            [cityData setObject:@"Stockholm" forKey:@"city"];
            [cityData setObject:@"Sweden" forKey:@"country"];
            break;
        case 9:
            [cityData setObject:@"Stockholm" forKey:@"city"];
            [cityData setObject:@"Sweden" forKey:@"country"];
            break;
            
    }
    return cityData;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cityData = [self cityDataForIndex:indexPath.row];
    NSString *selectedCity = [cityData objectForKey:@"city"];
    [self.delegate citySelected:selectedCity];
}



@end
