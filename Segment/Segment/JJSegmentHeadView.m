//
//  JJSegmentHeadView.m
//  Tools
//
//  Created by itclimb on 19/05/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "JJSegmentHeadView.h"
#import "Masonry.h"
#import "JJSegmentHeadViewCell.h"

@interface JJSegmentHeadView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
//  子视图
@property(nonatomic, strong) UICollectionView *collectV;
//  选中标签索引
@property(nonatomic, assign) NSInteger selectIndex;
//  标签字体大小
@property(nonatomic, assign) CGFloat fontSize;
//  选中标签颜色
@property(nonatomic, strong) UIColor *selectColor;
//  标签栏数据
@property(nonatomic, strong) NSArray *titleDatas;

@end

@implementation JJSegmentHeadView

- (instancetype)initWithFrame:(CGRect)frame andTitleDatas:(NSArray *)titleDatas fontOfSize:(CGFloat)size selectColor:(UIColor *)selectColor{
    self = [super initWithFrame:frame];
    if (self) {
        self.fontSize = size;
        self.selectColor = selectColor;
        self.titleDatas = titleDatas;
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
        [self.collectV registerClass:[JJSegmentHeadViewCell class] forCellWithReuseIdentifier:@"jjSegmentCell"];
    }
    return self;
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.delegate JJSegmentNumber];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JJSegmentHeadViewCell *cell = (JJSegmentHeadViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"jjSegmentCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titleDatas[indexPath.row];
    cell.fontSize = self.fontSize;
    if (self.selectIndex == indexPath.item) {
        cell.line.backgroundColor = self.selectColor?:[UIColor orangeColor];
        cell.titleLabel.textColor = self.selectColor?:[UIColor orangeColor];
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
    
    CGRect cellRect = [collectionView convertRect:cell.frame toView:collectionView];
    
    return cell;
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
    //    [collectionView setContentOffset:CGPointMake(indexPath.row * collectionView.bounds.size.width, 0) animated:YES];
    
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect cellRect = [collectionView convertRect:cell.frame toView:collectionView];
    
    self.selectIndex = indexPath.row;
    [self.collectV reloadData];
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

