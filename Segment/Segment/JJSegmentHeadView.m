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
//  子视图
@property(nonatomic, strong) UICollectionView *collectV;
//  选中标签索引
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
    }
    return self;
}

//MARK: - 注册
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier{
    [self.collectV registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

//MARK: - 复用cell
- (UICollectionViewCell *)segmentHeadViewDequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    
    return [self.collectV dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.delegate JJSegmentNumber];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.delegate JJSegmentHeadView:self cellForItemAtIndexPath:indexPath withSelectIndex:self.selectIndex];
}

#pragma mark -  UICollectionViewDelegateFlowLayout

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
    
    return [self.delegate JJSegmentHeadView:self itemSizeWithIndex:indexPath.row];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectIndex == indexPath.row) {
        return;
    }
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.collectV reloadData];
    self.selectIndex = indexPath.row;
    [self.delegate JJSegmentHeadView:self itemSelectWithIndex:indexPath.row];
}

//MARK: - 选中标签
- (void)setSelectItemWithIndex:(NSInteger)index{
    if (index > [self.delegate JJSegmentNumber] || index < 0) {
        return;
    }
    [self.collectV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.selectIndex = index;
    [self.collectV reloadData];
}

//MARK: - 重新加载
- (void)reloadData {
    [self.collectV reloadData];
}

@end

