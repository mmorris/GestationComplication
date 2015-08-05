//
//  ComplicationController.m
//  objc-complication WatchKit Extension
//
//  Created by Matthew Morris on 8/5/15.
//  Copyright © 2015 Matthew Morris. All rights reserved.
//

#import "ComplicationController.h"

@interface ComplicationController ()

@end

@implementation ComplicationController

#pragma mark - Timeline Configuration

-(NSString*) getTagline
{
    NSArray* taglines = @[@"Don't Panic.", @"Pack a small bag.", @"This is not a drill.", @"Go get some sleep.", @"This is happening."];
    return taglines[arc4random_uniform(taglines.count)];
}

-(NSString*) getWeeksToTerm
{
    NSCalendar* calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    // Edit this line with the date at which you'll be 37 weeks.
    NSDate *termDate = [calendar dateWithEra:1 year:2015 month:8 day:27 hour:0 minute:0 second:0 nanosecond:0];
    
    NSDate* date1 = [calendar startOfDayForDate:termDate];
    NSDateComponents* components = [calendar components:NSCalendarUnitWeekOfYear|NSCalendarUnitDay
                                               fromDate:[calendar startOfDayForDate:[NSDate date]]
                                                 toDate:[calendar startOfDayForDate:date1]
                                                options:kNilOptions];
    return [NSString stringWithFormat:@"%dwks %dd to term", components.weekOfYear, components.day];
}

-(NSString*) getHeader
{
    NSCalendar* calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    // Edit this line with your due date:
    NSDate *dueDate = [calendar dateWithEra:1 year:2015 month:9 day:17 hour:0 minute:0 second:0 nanosecond:0];
    
    NSDate* conceptionDate = [calendar dateByAddingUnit:NSCalendarUnitWeekOfYear value:-40 toDate:dueDate options:kNilOptions];
    NSDate* date1 = [calendar startOfDayForDate:[NSDate date]];
    NSDateComponents* components = [calendar components:NSCalendarUnitWeekOfYear fromDate:conceptionDate toDate:date1 options:kNilOptions];
    
    NSString* message = [NSString stringWithFormat:@"%d Weeks Gestation", components.weekOfYear];
    
    return message;
}

- (void)getSupportedTimeTravelDirectionsForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler {
    handler(CLKComplicationTimeTravelDirectionForward|CLKComplicationTimeTravelDirectionBackward);
}

- (void)getTimelineStartDateForComplication:(CLKComplication *)complication withHandler:(void(^)(__nullable NSDate *date))handler {
    handler(nil);
}

- (void)getTimelineEndDateForComplication:(CLKComplication *)complication withHandler:(void(^)(__nullable NSDate *date))handler {
    handler(nil);
}

- (void)getPrivacyBehaviorForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationPrivacyBehavior privacyBehavior))handler {
    handler(CLKComplicationPrivacyBehaviorShowOnLockScreen);
}

#pragma mark - Timeline Population

- (void)getCurrentTimelineEntryForComplication:(CLKComplication *)complication withHandler:(void(^)(__nullable CLKComplicationTimelineEntry *))handler {
    // Call the handler with the current timeline entry
    
    CLKComplicationTemplateModularLargeStandardBody* template = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
    template.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:[self getHeader]];
    template.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:[self getWeeksToTerm]];
    template.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"Due Sept. 17th"];
    
    // If you want a jokey tagline...
    //template.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:[self getTagline]];
    
    CLKComplicationTimelineEntry* timelineEntry = [CLKComplicationTimelineEntry entryWithDate:[NSDate date] complicationTemplate:template];
    
    
    handler(timelineEntry);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication beforeDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(__nullable NSArray<CLKComplicationTimelineEntry *> *entries))handler {
    // Call the handler with the timeline entries prior to the given date
    handler(nil);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication afterDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(__nullable NSArray<CLKComplicationTimelineEntry *> *entries))handler {
    // Call the handler with the timeline entries after to the given date
    handler(nil);
}

#pragma mark Update Scheduling

- (void)getNextRequestedUpdateDateWithHandler:(void(^)(__nullable NSDate *updateDate))handler {
    // Call the handler with the date when you would next like to be given the opportunity to update your complication content
    handler([NSDate dateWithTimeIntervalSinceNow:10]);
}

#pragma mark - Placeholder Templates

- (void)getPlaceholderTemplateForComplication:(CLKComplication *)complication withHandler:(void(^)(__nullable CLKComplicationTemplate *complicationTemplate))handler {
    // This method will be called once per supported complication, and the results will be cached
    
    CLKComplicationTemplateModularLargeStandardBody* template = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
    template.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"header"];
    template.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"Body1"];
    template.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"Body2"];
    
    handler(template);
}

@end
