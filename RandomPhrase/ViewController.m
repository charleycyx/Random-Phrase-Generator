//
//  ViewController.m
//  RandomPhrase
//
//  Created by Charley Chen on 1/23/16.
//  Copyright © 2016 Charley Chen. All rights reserved.
//

#import "ViewController.h"
#import "EditPageControllerViewController.h"

@interface ViewController () {
    
}

@property (strong, nonatomic) IBOutlet UILabel *Label2;

@property (strong, nonatomic) IBOutlet UILabel *Label1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ((EditPageControllerViewController*)segue.destinationViewController).verbArray = [NSMutableArray arrayWithArray:self.verbArray];
    ((EditPageControllerViewController*)segue.destinationViewController).nounArray = [NSMutableArray arrayWithArray:self.nounArray];
}

- (IBAction)UnWindToRandomPhraseView:(UIStoryboardSegue *)unwindSegue {
}

- (IBAction)getVerbButtonClicked:(id)sender {
    int index = arc4random_uniform(_verbArray.count);
    self.Label1.text = [_verbArray objectAtIndex:index];
}

- (IBAction)getNounButtonClicked:(id)sender {
    int index = arc4random_uniform(_nounArray.count);
    self.Label2.text = [_nounArray objectAtIndex:index];
}

- (IBAction)editSelectionClicked:(id)sender {
    [self performSegueWithIdentifier:@"SegueFromDIsplayToSelect" sender:nil];
}

@end
