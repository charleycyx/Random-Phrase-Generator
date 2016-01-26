//
//  EditPageControllerViewController.m
//  RandomPhrase
//
//  Created by Charley Chen on 1/26/16.
//  Copyright © 2016 Charley Chen. All rights reserved.
//

#import "EditPageControllerViewController.h"
#import "ViewController.h"

@interface EditPageControllerViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *verbNounSegment;
@property (strong, nonatomic) IBOutlet UITableView *wordTable;
@property (strong, nonatomic) IBOutlet UITextField *wordTextField;
@property (strong, nonatomic) IBOutlet UIButton *addButton;



@end

@implementation EditPageControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.verbNounSegment addTarget:self action:@selector(segmentSelectionChanged) forControlEvents:UIControlEventAllEvents];
    
    self.wordTable.dataSource = self;
    self.wordTable.delegate = self;
    
    [self.addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) segmentSelectionChanged {
    [self.wordTable reloadData];
}

- (void) addButtonClicked {
    NSString *text = self.wordTextField.text;
    if (![text isEqualToString: @""]) {
        if (self.verbNounSegment.selectedSegmentIndex == 0) {
            [self.verbArray addObject:text];
        } else {
            [self.nounArray addObject:text];
        }
    }
    self.wordTextField.text = @"";
    [self.wordTable reloadData];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ((ViewController*) segue.destinationViewController).verbArray = self.verbArray;
    ((ViewController*) segue.destinationViewController).nounArray = self.nounArray;
}

#pragma  mark start of tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.verbNounSegment.selectedSegmentIndex == 0) {
        return self.verbArray.count;
    } else {
        return self.nounArray.count;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.wordTable dequeueReusableCellWithIdentifier:@"wordCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wordCell"];
    }
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.verbNounSegment.selectedSegmentIndex == 0) {
        cell.textLabel.text = self.verbArray[indexPath.row];
    } else {
        cell.textLabel.text = self.nounArray[indexPath.row];
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.verbNounSegment.selectedSegmentIndex == 0) {
            [self.verbArray removeObjectAtIndex:indexPath.row];
        } else {
            [self.nounArray removeObjectAtIndex:indexPath.row];
        }
    }
    [self.wordTable reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
