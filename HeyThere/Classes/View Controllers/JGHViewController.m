//
//  JGHViewController.m
//  
//
//  Created by Julian Grosshauser on 12/03/15.
//
//

#import "JGHViewController.h"

@interface JGHViewController ()

@property (nonatomic) LYRClient *layerClient;
@property (nonatomic) LYRConversation *conversation;

@property (nonatomic) UITextField *messageTextField;

@end

@implementation JGHViewController

- (instancetype)initWithLayerClient:(LYRClient *)layerClient {
    self = [super init];

    if (self) {
        self.layerClient = layerClient;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *sendMessageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendMessageButton setTitle:NSLocalizedString(@"Send Message", nil) forState:UIControlStateNormal];
    [sendMessageButton sizeToFit];
    sendMessageButton.center = self.view.center;
    [sendMessageButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessageButton];

    CGRect messageTextFieldFrame = { .origin.x = self.view.center.x - 100.f, .origin.y = 100.f, .size.height = 30.f, .size.width = 200.f };
    self.messageTextField = [[UITextField alloc] initWithFrame:messageTextFieldFrame];
    self.messageTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.messageTextField.placeholder = NSLocalizedString(@"Message", nil);
    [self.view addSubview:self.messageTextField];
}

- (void)sendMessage:(id)sender {
    NSString *messageText = self.messageTextField.text;

    // If no conversations exist, create a new conversation object with two participants
    // For the purposes of this Quick Start project, the 3 participants in this conversation are 'Device'  (the authenticated user id), 'Simulator', and 'Dashboard'.
    if (!self.conversation) {
        NSError *error = nil;
        self.conversation = [self.layerClient newConversationWithParticipants:[NSSet setWithArray:@[ @"Simulator", @ "Dashboard" ]] options:nil error:&error];
        if (!self.conversation) {
            NSLog(@"New Conversation creation failed: %@", error);
        }
    }

    // Creates a message part with text/plain MIME Type
    LYRMessagePart *messagePart = [LYRMessagePart messagePartWithText:messageText];

    // Creates and returns a new message object with the given conversation and array of message parts
    LYRMessage *message = [self.layerClient newMessageWithParts:@[messagePart] options:@{LYRMessageOptionsPushNotificationAlertKey: messageText} error:nil];

    // Sends the specified message
    NSError *error;
    BOOL success = [self.conversation sendMessage:message error:&error];
    if (success) {
        NSLog(@"Message queued to be sent: %@", messageText);
    } else {
        NSLog(@"Message send failed: %@", error);
    }
}

@end
