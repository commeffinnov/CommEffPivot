//
//  LocColQuizViewController.m
//  CommEffPivot
//
//  Created by Cassandra Shi on 10/21/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColQuizViewController.h"

@interface LocColQuizViewController (){
    NSInteger currentQuestionID;
    __weak IBOutlet UIButton *choiceA;
    __weak IBOutlet UIButton *choiceB;
    __weak IBOutlet UIButton *choiceC;
    __weak IBOutlet UIButton *choiceD;
    bool endOfQuiz;
    NSInteger seconds;
    NSTimer * timer;
}

@property (weak, nonatomic) IBOutlet UILabel *timerDisplay;
@property (weak, nonatomic) IBOutlet UILabel *questionDisplay;
@property (weak, nonatomic) IBOutlet UILabel *aText;
@property (weak, nonatomic) IBOutlet UILabel *bText;
@property (weak, nonatomic) IBOutlet UILabel *cText;
@property (weak, nonatomic) IBOutlet UILabel *dText;


@end

@implementation LocColQuizViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setupQuestion:(NSInteger)questionID{
    
    currentQuestionID = questionID;
    
    self.questionDisplay.text= @"A full binary tree with 2n+1 nodes contain";
    self.aText.text = @"n leaf nodes";
    self.bText.text = @"n non-leaf nodes";
    self.cText.text = @"n-1 leaf nodes";
    self.dText.text = @"n-1 non-leaf nodes";
    [self setupTimer:30];
    
}

- (IBAction)madeChoice:(UIButton *)sender {
    
    
    //After user made a choice, stop the timer. 
    [timer invalidate];
    
    //If the user reached the end of the quiz, show an alert box.
    if (endOfQuiz==true){
        UIAlertView *alertFinish = [[UIAlertView alloc] initWithTitle:@"Quiz finished"
                                                        message:[NSString stringWithFormat:@"Congratulation, you've finished all the questions"]
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil, nil];
        
        [alertFinish show];
    }
    if (sender == choiceA){
        NSLog(@"choice a selected");
        [self setupQuestion:1];
    }
    if (sender == choiceB){
        NSLog(@"choice b selected");
        [self setupQuestion:1];
    }
    if (sender == choiceC){
        NSLog(@"choice c selected");
        [self setupQuestion:1];
    }
    if (sender == choiceD){
        NSLog(@"choice d selected");
        [self setupQuestion:1];
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Set up a question right after view did load
    [self setupQuestion:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTimer:(NSInteger) second;
{
    // 1
    seconds = second;
    
    
    // 2
    self.timerDisplay.text = [NSString stringWithFormat:@"Time: %li", (long)seconds];
    
    // 3
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(subtractTime)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)subtractTime {
    // 1
    seconds--;
    self.timerDisplay.text = [NSString stringWithFormat:@"Time: %li",(long)seconds];
    
    // 2
    if (seconds == 0) {
        [timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!"
                                                        message:[NSString stringWithFormat:@"Your time is up"]
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Next question", nil];
        
        [alert show];
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Next question"])
    {
        NSLog(@"Next question button was selected.");
        [self setupQuestion:1];
    }
}

@end
