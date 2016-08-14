//
//  ViewController.m
//  Contacts
//
//  Created by SnehithNitin on 8/13/16.
//  Copyright © 2016 Snehith. All rights reserved.
//

#import "ViewController.h"

#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface ViewController ()<CNContactPickerDelegate, UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSource;
    UITableView *table;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
    
    UIBarButtonItem *add=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContactSellected)];
    self.navigationItem.rightBarButtonItem=add;
    
    dataSource=[[NSMutableArray alloc]init];
    
    table=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
}

-(void)addContactSellected{
    self.view.backgroundColor=[UIColor blueColor];
    CNContactPickerViewController *peoplePicker=[[CNContactPickerViewController alloc]init];
    peoplePicker.delegate=self;
    [self presentViewController:peoplePicker animated:YES completion:nil];
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker;{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty;{
    
    [dataSource addObject:contactProperty];
    
    NSLog(@"contactProperty %@",contactProperty);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    UITableViewCell *cell=[table dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    CNContactProperty *contactProperty=[dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",contactProperty.contact.givenName,contactProperty.contact.familyName];
    if ([contactProperty.value isKindOfClass:[NSString class]]) {
        NSString * value=contactProperty.value;
        cell.detailTextLabel.text=value;
    }
    else if ([contactProperty.value isKindOfClass:[CNPhoneNumber class]]){
        CNPhoneNumber *phone=contactProperty.value;
        cell.detailTextLabel.text=phone.stringValue;
    }//    else if ([contactProperty.value isKindOfClass:[CNPostalAddress class]]){
//        CNPhoneNumber *phone=contactProperty.;
//        cell.detailTextLabel.text=phone.str;
//    }
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
