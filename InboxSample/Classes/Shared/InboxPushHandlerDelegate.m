/*
 Copyright 2009-2015 Urban Airship Inc. All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE URBAN AIRSHIP INC ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL URBAN AIRSHIP INC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "InboxPushHandlerDelegate.h"
#import "UAInboxPushHandler.h"
#import "UAInboxMessage.h"
#import "UAInboxAlertHandler.h"
#import "InboxSampleAppDelegate.h"
#import "InboxSampleViewController.h"

@interface InboxPushHandlerDelegate()
@property (nonatomic, strong) UAInboxAlertHandler *alertHandler;
@end

@implementation InboxPushHandlerDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        self.alertHandler = [[UAInboxAlertHandler alloc] init];
    }
    return self;
}


/*
 Called when a new rich push message is available for viewing.
 */
- (void)richPushMessageAvailable:(UAInboxMessage *)message {
    // Display an alert, and if the user taps "View", display the message
    NSString *alertText = message.title;
    [self.alertHandler showNewMessageAlert:alertText withViewBlock:^{
        [self showInboxMessage:message];
    }];
}

/*
 Called when a new rich push message is available after launching from a
 push notification.
 */
- (void)launchRichPushMessageAvailable:(UAInboxMessage *)message {
    InboxSampleAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.viewController showInboxMessage:message];
}

- (void)richPushNotificationArrived:(NSDictionary *)notification {
    // Add custom notification handling here
}

- (void)applicationLaunchedWithRichPushNotification:(NSDictionary *)notification {
    // Add custom launch notification handling here
}

/**
 * Called when the inbox is requested to be displayed.
 */
- (void)showInbox {
    InboxSampleAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.viewController showInbox];
}

/*
 * Called when an inbox gmessage is requested to be displayed.
 *
 * @param message The message to display.
 */
- (void)showInboxMessage:(UAInboxMessage *)inboxMessage {
    InboxSampleAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.viewController showInboxMessage:inboxMessage];
}

@end
