
#import <Cocoa/Cocoa.h>
#include <iostream>
#include <chrono>

@interface TimerApp : NSObject <NSApplicationDelegate>
@property (strong, nonatomic) NSWindow *window;
@property (strong, nonatomic) NSButton *button;
@property (strong, nonatomic) NSTextField *timeLabel;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) std::chrono::steady_clock::time_point startTime;
@property (nonatomic) bool isRunning;
- (void)toggleTimer:(id)sender;
- (void)timerTick;
- (void)colorButtonRed:(NSButton *)button;
- (void)colorButtonYellow:(NSButton *)button;
@end

@implementation TimerApp

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create window
        self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(200, 200, 350, 200)
                                                  styleMask:(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable)
                                                    backing:NSBackingStoreBuffered
                                                      defer:NO];
        [self.window setTitle:@"Objective-C++ Timer"];
        [self.window makeKeyAndOrderFront:nil];

        // Create time label
        self.timeLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(50, 120, 250, 40)];
        [self.timeLabel setStringValue:@"00:00:00.000"];
        [self.timeLabel setFont:[NSFont systemFontOfSize:24]];
        [self.timeLabel setBezeled:NO];
        [self.timeLabel setDrawsBackground:NO];
        [self.timeLabel setEditable:NO];
        [self.timeLabel setAlignment:NSTextAlignmentCenter];

        // Create button
        self.button = [[NSButton alloc] initWithFrame:NSMakeRect(120, 60, 120, 40)];
        [self.button setTitle:@"Start Timer"];
        [self.button setTarget:self];
        [self.button setAction:@selector(toggleTimer:)];

        // Add elements to window
        NSView *contentView = [self.window contentView];
        [contentView addSubview:self.timeLabel];
        [contentView addSubview:self.button];

        [self colorButtonRed:self.button];
        self.isRunning = false;
    }
    return self;
}

- (void)toggleTimer:(id)sender {
    if (self.isRunning) {
        [self colorButtonRed:self.button];        
        // Stop timer
        [self.timer invalidate];
        self.timer = nil;
        self.isRunning = false;
        [self.button setTitle:@"Start Timer"];
        std::cout << "Timer stopped!" << std::endl;
    } else {
        [self colorButtonYellow:self.button];        
        // Start timer
        self.startTime = std::chrono::steady_clock::now();
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01  // Update every 10ms
                                                      target:self
                                                    selector:@selector(timerTick)
                                                    userInfo:nil
                                                     repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        self.isRunning = true;
        [self.button setTitle:@"Stop Timer"];
        std::cout << "Timer started!" << std::endl;
    }
}

- (void)timerTick {
    // Calculate elapsed time
    auto now = std::chrono::steady_clock::now();
    auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(now - self.startTime).count();

    int hours = elapsed / 3600000;
    int minutes = (elapsed % 3600000) / 60000;
    int seconds = (elapsed % 60000) / 1000;
    int milliseconds = elapsed % 1000;

    // Format time as HH:MM:SS.mmm
    NSString *timeString = [NSString stringWithFormat:@"%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds];

    // Update label
    [self.timeLabel setStringValue:timeString];

    // Print to console
    std::cout << "Elapsed time: " << [timeString UTF8String] << std::endl;
}

- (void)colorButtonRed:(NSButton *)button {
    [button setWantsLayer:YES];
    button.layer.backgroundColor = [[NSColor redColor] CGColor];
}

- (void)colorButtonYellow:(NSButton *)button {
    [button setWantsLayer:YES];
    button.layer.backgroundColor = [[NSColor yellowColor] CGColor];
}

@end

int main() {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        TimerApp *delegate = [[TimerApp alloc] init];
        [app setDelegate:delegate];
        [app run];
    }
    return 0;
}
