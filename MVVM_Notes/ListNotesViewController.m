//
//  ViewController.m
//  MVVM_Notes
//
//  Created by Rushi Sangani on 27/08/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#import "ListNotesViewController.h"
#import "CreateNewNoteViewController.h"
#import "FBKVOController.h"
#import "Constants.h"

@interface ListNotesViewController () <UITableViewDataSource, UITableViewDelegate>
{
    BOOL isEdit;
    NSIndexPath *selectedIndexPath;
    FBKVOController *_KVOController;
}

@end

@implementation ListNotesViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
 
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        _KVOController = [FBKVOController controllerWithObserver:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupObservers];
}

#pragma mark - Private Methods
- (void)setupObservers
{
    [_KVOController observe:self.listViewModel keyPath:@"notes" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
        [self.tableView reloadData];
    }];
}

#pragma mark - Getters
-(ListNotesViewModel *)listViewModel{
    
    if(!_listViewModel){
        _listViewModel = [[ListNotesViewModel alloc] init];
    }
    
    return _listViewModel;
}

#pragma mark - TableView DataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listViewModel.notes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Note *note = [self.listViewModel getNoteAtIndexPath:indexPath];
    cell.textLabel.text = [note valueForKey:kNoteModel_Title];
    cell.detailTextLabel.text = [note valueForKey:kNoteModel_ModifiedDate];
    
    return cell;
}

#pragma mark - TableView Delegate Methods
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.listViewModel removeNoteAtIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedIndexPath = indexPath;
    isEdit = YES;
    [self performSegueWithIdentifier:kCreateNewNoteIdentifier sender:nil];
}

#pragma mark - Action Methods

- (IBAction)createNewNote:(id)sender {
    isEdit = NO;
    [self performSegueWithIdentifier:kCreateNewNoteIdentifier sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:kCreateNewNoteIdentifier]){
        
        CreateNewNoteViewController *createNewNoteViewController = (CreateNewNoteViewController *)segue.destinationViewController;
        
        if(isEdit){
            Note *note = [self.listViewModel getNoteAtIndexPath:selectedIndexPath];
            createNewNoteViewController.noteModel = [[CreateNoteViewModel alloc] initWithDelegate:self.listViewModel noteId:[note valueForKey:kNoteModel_Id] isEdit:isEdit];
        }
        else{
            createNewNoteViewController.noteModel = [[CreateNoteViewModel alloc] initWithDelegate:self.listViewModel noteId:nil isEdit:isEdit];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
