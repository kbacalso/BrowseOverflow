//
//  QuestionListTableDataSource.m
//  BrowseOverflow
//
//  Created by taki bacalso on 15/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "QuestionListTableDataSource.h"
#import "Topic.h"
#import "QuestionSummaryCell.h"
#import "Question.h"
#import "Person.h"

@implementation QuestionListTableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_topic recentQuestions] count] ? : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (_topic.recentQuestions.count) {
        Question *question = _topic.recentQuestions[indexPath.row];
        
        self.summaryCell = [tableView dequeueReusableCellWithIdentifier:@"question"];
        
        if (!_summaryCell) {
            [[NSBundle bundleForClass:[self class]] loadNibNamed:@"QuestionSummaryCell"
                                                           owner:self
                                                         options:nil];
        }
        
        _summaryCell.titleLabel.text = question.title;
        _summaryCell.scoreLabel.text = [NSString stringWithFormat:@"%ld", question.score];
        _summaryCell.nameLabel.text = question.asker.name;
        
        cell = _summaryCell;
        _summaryCell = nil;
        
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"placeholder"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"placeholder"];
        }
        
        cell.textLabel.text = @"There was a problem connecting to the network.";
        
    }
    
    return cell;
    
}

@end
