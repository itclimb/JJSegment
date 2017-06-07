//
//  JJSegmentHeadView.m
//  Tools
//
//  Created by itclimb on 19/05/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "JJSegmentHeadView.h"
#import "Masonry.h"

@interface JJSegmentHeadView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectV;
@property(nonatomic, assign) NSInteger selectIndex;

@end

@implementation JJSegmentHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectV = collectionView;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.selectIndex = 0;
        
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:collectionView];
        [self.collectV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [collectionView registerClass:[JJSegmentHeadViewCell class] forCellWithReuseIdentifier:@"jjSegmentCell"];
    }
    return self;
}


//MARK: - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.delegate jjSegmentNumber];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JJSegmentHeadViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"jjSegmentCell" forIndexPath:indexPath];
    cell.titleLabel.text = [self.delegate textForCellWithIndex:indexPath.item];
    
    if (self.selectIndex == indexPath.item) {
        
        cell.line.backgroundColor = self.lineColor?:[UIColor orangeColor];
        cell.titleLabel.textColor = self.titleLabelColor?:[UIColor orangeColor];
        
        [UIView animateWithDuration:0.3 animations:^{
            cell.line.transform = CGAffineTransformMakeScale(1.2, 1.2);
            cell.titleLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }];
        
    }else {
        
        cell.line.backgroundColor = [UIColor clearColor];
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.line.transform = CGAffineTransformMakeScale(1.0, 1.0);
        cell.titleLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
    
    return cell;
}

//MARK: - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
        
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return  UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.delegate jjSegmentItemSimeWithIndex:indexPath.item];
}

//MARK: - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectIndex == indexPath.row) {
        return;
    }
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.collectV reloadData];
    self.selectIndex = indexPath.row;
    [self.delegate selectWithIndex:indexPath.row];
}

- (void)setSelectItemWithIndex:(NSInteger)index{
    if (index > [self.delegate jjSegmentNumber] || index < 0) {
        return;
    }
    [self.collectV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.selectIndex = index;
    [self.collectV reloadData];
}
- (void)reloadData {
    [self.collectV reloadData];
}

@end


//MARK: - headView cell
@implementation JJSegmentHeadViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:13.0];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-4);
        }];
        
        self.line = [[UIView alloc] init];
        [self.contentView addSubview:self.line];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.leading.trailing.mas_equalTo(self.titleLabel);
            make.height.mas_equalTo(2);
        }];
    }

    return self;
}


@end
