//
//  MainWindow.m
//  lovestep
//
//  Created by Raymond kennedy on 11/19/13.
//  Copyright (c) 2013 Zachary Waleed Saraf. All rights reserved.
//

#import "MainWindow.h"
#import "SequencerView.h"
#import "Novocaine.h"
#import "RingBuffer.h"
#import "AudioFileReader.h"
#import "AudioFileWriter.h"

@interface MainWindow ()

@property (nonatomic, weak) IBOutlet SequencerView *sequencerView;
@property (nonatomic, strong) Novocaine *audioManager;
@property (nonatomic, strong) AudioFileReader *fileReader;
@property (nonatomic, strong) AudioFileWriter *fileWriter;
@property (nonatomic, assign) RingBuffer * ringBuffer;

@end

@implementation MainWindow

const Float64 kGraphSampleRate = 44100.0;

- (void)awakeFromNib
{
    self.audioManager = [Novocaine audioManager];
    self.ringBuffer = new RingBuffer(32768, 2);

    __weak MainWindow * wself = self;
    __block int counter = 0;
    
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
    {
        for (int i = 0; i < numFrames; i++) {
            data[i * numChannels] = rand() % 32768;
         
            for (int j = 1; j < numChannels; j++) data[i * numChannels + j] = data[i * numChannels];
        }
        
         [wself.fileReader retrieveFreshAudio:data numFrames:numFrames numChannels:numChannels];
         counter++;
         if (counter % 80 == 0)
             NSLog(@"Time: %f", wself.fileReader.currentTime);
         
     }];
    
    [self.audioManager play];
}

@end