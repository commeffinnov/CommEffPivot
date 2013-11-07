//
//  LocColQuizViewController.m
//  CommEffPivot
//
//  Created by Cassandra Shi on 10/21/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColQuizViewController.h"
#import "LocColQuestion.h"
#import "LocColPresentation.h"
#import "AFHTTPRequestOperation.h"


@interface LocColQuizViewController (){
    NSInteger currentQuestionID;
    __weak IBOutlet UIButton *choiceA;
    __weak IBOutlet UIButton *choiceB;
    __weak IBOutlet UIButton *choiceC;
    __weak IBOutlet UIButton *choiceD;
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

// private variables:
@synthesize presentation=_presentation;
NSInteger _nextQuestionIndex = 0;
bool _endOfQuiz = false;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) fetchQuestions
{
    if (self.presentation != nil){
        NSString *url = [NSString stringWithFormat:@"%@%@%@",API_HOST, @"questions/",self.presentation.ID];
        NSURL *URL = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *array = responseObject;
            
            for (NSDictionary *dict in array){
                LocColQuestion *question = [[LocColQuestion alloc] init];
                question.title = [dict valueForKey:@"title"];
                question.ctime = [dict valueForKey:@"ctime"];
                question.ID = [dict valueForKey:@"_id"];
                question.presentationID = [dict valueForKey:@"presentationID"];
                question.number = [dict valueForKey:@"number"];
                question.selections = [dict valueForKey:@"selections"];
                [self.questions addObject:(id) question];
                
            }
            [self setupQuestion:0];
            
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}

- (void) setupQuestion:(NSInteger)questionIndex{
    if (questionIndex >= [self.questions count]){
        _endOfQuiz = true;
        return;
    }else{
        _endOfQuiz = false;
    }
    // Get current question
    LocColQuestion *question = [self.questions objectAtIndex:questionIndex];
    if (question != nil){
        self.questionDisplay.text= question.title;
        self.aText.text = [question.selections objectAtIndex:0];
        self.bText.text = [question.selections objectAtIndex:1];
        self.cText.text = [question.selections objectAtIndex:2];
        self.dText.text = [question.selections objectAtIndex:3];
        [self setupTimer:30];
    }
    _nextQuestionIndex = questionIndex+1;
}

- (IBAction)madeChoice:(UIButton *)sender {
    
    
    //After user made a choice, stop the timer. 
    [timer invalidate];
    
    if (sender == choiceA){
        NSLog(@"choice a selected");
        [self setupQuestion:_nextQuestionIndex];
    }
    if (sender == choiceB){
        NSLog(@"choice b selected");
        [self setupQuestion:_nextQuestionIndex];
    }
    if (sender == choiceC){
        NSLog(@"choice c selected");
        [self setupQuestion:_nextQuestionIndex];
    }
    if (sender == choiceD){
        NSLog(@"choice d selected");
        [self setupQuestion:_nextQuestionIndex];
    }

    //If the user reached the end of the quiz, show an alert box.
    if (_endOfQuiz==true){
        UIAlertView *alertFinish = [[UIAlertView alloc] initWithTitle:@"Quiz finished"
                                                              message:[NSString stringWithFormat:@"Congratulations, you've finished all the questions"]
                                                             delegate:self
                                                    cancelButtonTitle:@"Done"
                                                    otherButtonTitles:nil, nil];
        
        [alertFinish show];
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.questions == nil){
        [self setQuestions:[[NSMutableArray alloc] init]];
        [self fetchQuestions];
    }
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
