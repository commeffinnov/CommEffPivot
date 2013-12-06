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

#import "LocColAPIRequest.h"
#import "LocColQuizViewController.h"
#import "LocColQuestion.h"
#import "LocColPresentation.h"
#import "AFHTTPRequestOperation.h"


@interface LocColQuizViewController (){
    int currentQuestionID;
    __weak IBOutlet UIButton *choiceA;
    __weak IBOutlet UIButton *choiceB;
    __weak IBOutlet UIButton *choiceC;
    __weak IBOutlet UIButton *choiceD;
    NSInteger seconds;
    NSTimer * timer;
    bool pauseTimer;
    
    PTPusher *_client;
    PTPusherChannel *_channel;
    UIColor * selectedColor;
    UIColor * disabledColor;
    UIColor * normalColor;
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
int _nextQuestionIndex = 0;
bool _endOfQuiz = false;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) disableOptions
{
    [choiceA setEnabled:NO];
    [choiceB setEnabled:NO];
    [choiceC setEnabled:NO];
    [choiceD setEnabled:NO];
    
}

//(NSDictionary*)result_data
- (void) showStatsText
{
    [self.resultA setHidden:false];
    [self.resultB setHidden:false];
    [self.resultC setHidden:false];
    [self.resultD setHidden:false];
}

- (void) hideStatsText
{
    [self.resultA setHidden:true];
    [self.resultB setHidden:true];
    [self.resultC setHidden:true];
    [self.resultD setHidden:true];
}

-(void) displayQuestionStats: (NSMutableArray*) result
                  questionID: (NSString *) questionID
{
    [self showStatsText];
    // Get current question
    LocColQuestion *question = [self.questions objectAtIndex:currentQuestionID];
    // If the Statistics are not for the current question
    if ([question.ID isEqualToString:questionID] == NO){
        int qindex = 0;
        // Search out the corresponding question
        while (qindex < [self.questions count]){
            question = [self.questions objectAtIndex:qindex];
            if ([question.ID isEqualToString:questionID] == NO){
                // Not Found
                qindex += 1;
            }else{
                // Found
                break;
            }
        }
        // If the corresponding question is not found
        // Do nothing, return
        if (qindex >= [self.questions count]){
            return;
        }
        
        // Otherwise, we move our page to that question
        [self setupQuestion:qindex];
    }
    // Disable Options
    [self disableOptions];
    // Hide the timer
    [self hideTimer];
    
    NSString* correct_ans = [NSString stringWithFormat:@"%@", question.answer];
    
    // Complement the result set if it is less than length of 5
    while ([result count] < 1+4){
        [result addObject:[NSNumber numberWithInt:0]];
    }
    
    self.resultA.text=[NSString stringWithFormat:@"%@/%@", [result objectAtIndex:1],[result objectAtIndex:0]];
    self.resultB.text=[NSString stringWithFormat:@"%@/%@", [result objectAtIndex:2],[result objectAtIndex:0]];
    self.resultC.text=[NSString stringWithFormat:@"%@/%@", [result objectAtIndex:3],[result objectAtIndex:0]];
    self.resultD.text=[NSString stringWithFormat:@"%@/%@", [result objectAtIndex:4],[result objectAtIndex:0]];
    self.timerDisplay.text=@"14/20 students chose the correct answer";
    
    NSLog(@"correct answer:%@", correct_ans);
    
    if ([correct_ans isEqualToString:@"1"]){
        self.aText.textColor = [UIColor greenColor];
    }
    if ([correct_ans isEqualToString:@"2"]){
        self.bText.textColor = [UIColor greenColor];
    }
    if ([correct_ans isEqualToString:@"3"]){
        self.cText.textColor = [UIColor greenColor];
    }
    if ([correct_ans isEqualToString:@"4"]){
        self.dText.textColor = [UIColor greenColor];
    }
    
}

- (void) setOptionsToDefault
{
    [choiceA setTitleColor:normalColor forState:UIControlStateNormal];
    [choiceB setTitleColor:normalColor forState:UIControlStateNormal];
    [choiceC setTitleColor:normalColor forState:UIControlStateNormal];
    [choiceD setTitleColor:normalColor forState:UIControlStateNormal];
    
    [self.aText setTextColor:[UIColor blackColor]];
    [self.bText setTextColor:[UIColor blackColor]];
    [self.cText setTextColor:[UIColor blackColor]];
    [self.dText setTextColor:[UIColor blackColor]];
    
    [self enableOptions];
}

-(void) hideQuestionStats
{
    self.resultA.text=@"";
    self.resultB.text=@"";
    self.resultC.text=@"";
    self.resultD.text=@"";
}

-(void) enableOptions
{
    [choiceA setEnabled:YES];
    [choiceB setEnabled:YES];
    [choiceC setEnabled:YES];
    [choiceD setEnabled:YES];
    
}

- (void) fetchQuestions
{
    // init List of Questions
    if (self.questions == nil){
        self.questions = [[NSMutableArray alloc] init];
    }
    
    // Load questions if presentation is not nil
    if (self.presentation != nil){
        // Init URL
        NSString *url = [NSString stringWithFormat:@"%@%@%@",API_HOST, @"questions/",self.presentation.ID];
        NSURL *URL = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        // Init Operation Object
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        // Setup serializable format as JSON
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        
        // Bind Events
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
            NSLog(@"JSON: %@", responseObject);
            
            // Go to current Slide if status is not -1
            int presentation_status = [self.presentation.status intValue];
            if (presentation_status == -1){
                [self setToDefault];
                NSLog(@"Not started yet");
            }else{
                [self setupQuestion: presentation_status];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        // Add Operation to queue
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}

- (void) setupQuestion:(int)questionIndex{
    // TODO: this part is questionable as we should handle the logic better
    //       - Yitong
    if (questionIndex >= [self.questions count]){
        _endOfQuiz = true;
        return;
    }else{
        _endOfQuiz = false;
    }
    /////////////////////////
    
    [self hideStatsText];
    // Only operate when the index and questions array is legit
    if (self.questions == nil || questionIndex < 0 || questionIndex >= [self.questions count]){
        return;
    }
    
    // Hide previous question stats
    [self hideQuestionStats];
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
    // Ensure options are valid and restored to default state
    [self setOptionsToDefault];
    [self showOptions];
    
    // Current Question index
    currentQuestionID = questionIndex;
    // Next Question index
    _nextQuestionIndex = questionIndex+1;
}

- (IBAction)madeChoice:(UIButton *)sender {
    
    
    //After user made a choice, stop the timer. 
    [timer invalidate];
    int selectedNum = -1;
    
    if (sender == choiceA){
        NSLog(@"choice a selected");
        selectedNum = 1;
        //[self setupQuestion:_nextQuestionIndex];
    }
    if (sender == choiceB){
        NSLog(@"choice b selected");
        selectedNum = 2;
        //[self setupQuestion:_nextQuestionIndex];
    }
    if (sender == choiceC){
        NSLog(@"choice c selected");
        selectedNum = 3;
       //[self setupQuestion:_nextQuestionIndex];
    }
    if (sender == choiceD){
        NSLog(@"choice d selected");
        selectedNum = 4;
        //[self setupQuestion:_nextQuestionIndex];
    }
    
    //If pressed
    if (sender.enabled){
        // Send out Answer
        LocColQuestion *question = [self.questions objectAtIndex:currentQuestionID];
        [self sendAnswer:selectedNum questionID:question.ID];
        
        // Disable Options
        [self disableOptions];
        [sender setEnabled:true];
        
        // -------------
        // Change Colors
        // -------------
        // Highlight current choice
        UILabel *label = nil;
        if (selectedNum == 1){
            label = self.aText;
        }else if (selectedNum == 2){
            label = self.bText;
        }else if (selectedNum == 3){
            label = self.cText;
        }else if (selectedNum == 4){
            label = self.dText;
        }
        if (label != nil){
            [label setTextColor:selectedColor];
            [sender setTitleColor:selectedColor forState:UIControlStateNormal];
        }
        // ---------------
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

- (void) sendAnswer:(int) selectedNum
         questionID: (NSString *) questionID
{
    NSString *url = [NSString stringWithFormat:@"%@%@",API_HOST, @"answers"];
    NSNumber *choice = [NSNumber numberWithInt:selectedNum];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            (id)@"111", (id)@"uid",
                            (id)choice, (id)@"selectedNum",
                            (id)questionID, (id)@"questionID",
                            nil];
    [LocColAPIRequest send:url data:params method:@"POST"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Color set up
    selectedColor= [UIColor colorWithRed:153.0/256.0 green:0.0/256.0 blue:0.0/256.0 alpha:1.0];
    disabledColor= [UIColor colorWithRed:110.0/256.0 green:110.0/256.0 blue:110.0/256.0 alpha:1.0];
    normalColor = [UIColor colorWithRed:53.0/256.0 green:53.0/256.0 blue:255.0/256.0 alpha:1.0];
    
    
    [self initQuiz];
    [self subscribeChannels];
}

- (void)initQuiz
{
    // Made options selectable
    [self enableOptions];
    // Hide options
    [self hideOptions];
    // Read a list of questions
    [self fetchQuestions];
}

- (void) showOptions
{
    [self.aText setHidden:false];
    [self.bText setHidden:false];
    [self.cText setHidden:false];
    [self.dText setHidden:false];
    [choiceA setHidden:false];
    [choiceB setHidden:false];
    [choiceC setHidden:false];
    [choiceD setHidden:false];
}

- (void) hideOptions
{
    [self.aText setHidden:true];
    [self.bText setHidden:true];
    [self.cText setHidden:true];
    [self.dText setHidden:true];
    [choiceA setHidden:true];
    [choiceB setHidden:true];
    [choiceC setHidden:true];
    [choiceD setHidden:true];
}


- (void) setToDefault
{
    [self hideTimer];
    [self hideOptions];
    // Tag the currentQuestionID to -1
    currentQuestionID = -1;
    self.questionDisplay.text  = @"Please wait for the instructor.";
}

- (void) resetToDefault
{
    [self hideStatsText];
    [self hideTimer];
    [self hideOptions];
    self.questionDisplay.text  = @"Quiz Finished. Please wait for the instructor.";
}

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
    
    // Show timer
    [self showTimer];
    
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

- (void) hideTimer
{
    [self.timerDisplay setHidden:true];
}

- (void) showTimer
{
    [self.timerDisplay setHidden:false];
}

- (void)runTimer
{
    if (!pauseTimer && seconds > 0){
        seconds--;
        self.timerDisplay.text = [NSString stringWithFormat:@"Time: %li",(long)seconds];
    }
    
    if (seconds == 0){
        [self disableOptions];
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
        if (i >= 0){
            [self setupQuestion:i];
        }else if (i == -1){
            [self resetToDefault];
            NSLog(@"Goto Default Page");
        }
    }];
    
    // Show Question Statistics Event
    [_channel bindToEventNamed:@"question_stats_event" handleWithBlock:^(PTPusherEvent *channelEvent){
        NSLog(@"%@ slide_status_event", channelEvent.data);
        NSDictionary *dict = channelEvent.data;
        NSMutableArray * result = [[NSMutableArray alloc] init];
        NSArray *count = [dict valueForKey:@"count"];
        NSString *questionID = [dict valueForKey:@"questionID"];
        for (int i = 0; i < [count count]; i++){
            NSLog(@"%@", count);
            NSString *num =[count objectAtIndex:i];
            NSLog(@"NUM:%@", num);
            if ([num isKindOfClass:[NSNull class]]){
                num = @"0";
            }
            NSNumber *n = [NSNumber numberWithInteger:[num integerValue]];
            [result addObject:n];
        }
        [self displayQuestionStats:result questionID:questionID];
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
