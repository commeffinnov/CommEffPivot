//
//  LocColQuizViewController.m
//  CommEffPivot
//
//  Created by Cassandra Shi on 10/21/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//
#import "AFHTTPRequestOperation.h"

#import "PTPusher.h"
#import "PTPusherEvent.h"
#import "PTPusherChannel.h"

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
    bool pauseTimer;
    
    PTPusher *_client;
    PTPusherChannel *_channel;
}

@property (weak, nonatomic) IBOutlet UILabel *timerDisplay;
@property (weak, nonatomic) IBOutlet UILabel *questionDisplay;
@property (weak, nonatomic) IBOutlet UILabel *aText;
@property (weak, nonatomic) IBOutlet UILabel *bText;
@property (weak, nonatomic) IBOutlet UILabel *cText;
@property (weak, nonatomic) IBOutlet UILabel *dText;
@property (strong, nonatomic) IBOutlet UILabel *resultA;
@property (strong, nonatomic) IBOutlet UILabel *resultB;
@property (strong, nonatomic) IBOutlet UILabel *resultC;
@property (strong, nonatomic) IBOutlet UILabel *resultD;

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

-(void) disable_options
{
    [choiceA setEnabled:NO];
    [choiceB setEnabled:NO];
    [choiceC setEnabled:NO];
    [choiceD setEnabled:NO];
    
}

//(NSDictionary*)result_data

-(void) display_result: (NSMutableArray*) result
{
    NSString* correct_ans = @"B";
    self.resultA.text=@"10%/10";
    self.resultB.text=@"10%/10";
    self.resultC.text=@"30%/20";
    self.resultD.text=@"50%/50";
    self.timerDisplay.text=@"14/20 students chose the correct answer";
    if ([correct_ans isEqualToString:@"A"]){
        self.aText.textColor = [UIColor greenColor];
    }
    if ([correct_ans isEqualToString:@"B"]){
        self.bText.textColor = [UIColor greenColor];
    }
    if ([correct_ans isEqualToString:@"C"]){
        self.cText.textColor = [UIColor greenColor];
    }
    if ([correct_ans isEqualToString:@"D"]){
        self.dText.textColor = [UIColor greenColor];
    }
    
}

-(void) enable_options
{
    [choiceA setEnabled:YES];
    [choiceB setEnabled:YES];
    [choiceC setEnabled:YES];
    [choiceD setEnabled:YES];
    
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
                question.index = [dict valueForKey:@"index"];
                question.answer = [dict valueForKey:@"answer"];
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
        //[self setupQuestion:_nextQuestionIndex];
    }
    if (sender == choiceB){
        NSLog(@"choice b selected");
        //[self setupQuestion:_nextQuestionIndex];
    }
    if (sender == choiceC){
        NSLog(@"choice c selected");
       //[self setupQuestion:_nextQuestionIndex];
    }
    if (sender == choiceD){
        NSLog(@"choice d selected");
        //[self setupQuestion:_nextQuestionIndex];
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
        [self.aText setHidden:true];
        [self.bText setHidden:true];
        [self.cText setHidden:true];
        [self.dText setHidden:true];
        self.questionDisplay.text  = @"Please wait for the instructor.";
        [choiceA setHidden:true];
        [choiceB setHidden:true];
        [choiceC setHidden:true];
        [choiceD setHidden:true];
        //[self startQuiz];
        
        
    }
    [self subscribeChannels];
}

- (void)startQuiz
{
    [self enable_options];
    [self.aText setHidden:false];
    [self.bText setHidden:false];
    [self.cText setHidden:false];
    [self.dText setHidden:false];
    [choiceA setHidden:false];
    [choiceB setHidden:false];
    [choiceC setHidden:false];
    [choiceD setHidden:false];
    [self fetchQuestions];

}

//-(void)displayResult{
  //  NSDictionary *result_data = [NSDictionary dictionaryWithObjects:@"1",@"2",@"3"];
    //[self performSegueWithIdentifier:@"GoToPresentationList"
      //                        sender:[self.courseData objectAtIndex:indexPath.row]];
    
//}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTimer:(NSInteger) second;
{
    // Clean old data
    if (timer != nil){
        [timer invalidate];
    }
    // Init
    seconds = second;
    self.timerDisplay.text = [NSString stringWithFormat:@"Time: %li", (long)seconds];
    pauseTimer = false;
    // Bind Interval
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(runTimer)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)runTimer
{
    if (!pauseTimer && seconds > 0){
        seconds--;
        self.timerDisplay.text = [NSString stringWithFormat:@"Time: %li",(long)seconds];
    }
}

- (void) pauseTimer
{
    pauseTimer = true;
}

- (void) resumeTimer
{
    pauseTimer = false;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Next question"])
    {
        NSLog(@"Next question button was selected.");
        [self setupQuestion:_nextQuestionIndex];
    }
}

// Channels and Events
- (void) subscribeChannels
{
    _client = [PTPusher pusherWithKey:PUSHER_APP_KEY delegate:self encrypted:YES];
    [self subscribePresentationChannel];
}

- (void) subscribePresentationChannel
{
    NSString *channelName = [NSString stringWithFormat:@"presentation_channel_%@", self.presentation.ID];
    _channel = [_client subscribeToChannelNamed:channelName];
    
    // Move Question/Slide Event
    [_channel bindToEventNamed:@"slide_event" handleWithBlock:^(PTPusherEvent *channelEvent) {
        NSLog(@"%@ slide_event", channelEvent.data);
        NSDictionary *dict = channelEvent.data;
        NSString *index = [dict valueForKey:@"index"];
        int i = [index intValue];
        if (i == 0){
            [self startQuiz];
        }else{
            [self setupQuestion:i];
        }
    }];
    
    // Show Question Statistics Event
    [_channel bindToEventNamed:@"question_stats_event" handleWithBlock:^(PTPusherEvent *channelEvent){
        NSLog(@"%@ slide_status_event", channelEvent.data);
        NSDictionary *dict = channelEvent.data;
        NSMutableArray * result = [[NSMutableArray alloc] init];
        NSArray *count = [dict valueForKey:@"count"];
        for (int i = 0; i < [count count]; i++){
            NSLog(@"%@", count);
            NSNumber *num =[count objectAtIndex:i];
            [result addObject:num];
        }
        [self display_result:result];
    }];
    
    // Pause/Resume Timer Event
    [_channel bindToEventNamed:@"slide_status_event" handleWithBlock:^
        (PTPusherEvent *channelEvent){
        NSLog(@"%@ slide_status_event", channelEvent.data);
        NSDictionary *dict = channelEvent.data;
            NSNumber *active = [dict valueForKey:@"active"];
            NSLog(@"active:%@ ", active);
            if ([active intValue] == 0){
                [self pauseTimer];
            }else{
                [self resumeTimer];
            }
    }];
}

@end
