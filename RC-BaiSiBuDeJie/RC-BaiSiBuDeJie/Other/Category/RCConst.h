
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    RCDuanZiTypeAll=1,
    RCDuanZiTypePicture = 10,
    RCDuanZiTypeDuanZi = 29,
    RCDuanZiTypeVoice = 31,
    RCDuanZiTypeVideo = 41
}RCDuanZiType;

/** 标签栏View的高度*/
UIKIT_EXTERN CGFloat const RCTitilesViewH;
/** 标签栏View的Y*/
UIKIT_EXTERN CGFloat const RCTitilesViewY;
/**默认头像*/
UIKIT_EXTERN NSString const * DefaultIcon;
/**cell文字的Y值 */
UIKIT_EXTERN CGFloat const RCCellTextY;
/**cell底部按钮View的H */
UIKIT_EXTERN CGFloat const RCCellButttomViewH;
/**cell 固定的间距 10 */
UIKIT_EXTERN CGFloat const RCCellMargin;
/**图片高度超过此值*/
UIKIT_EXTERN CGFloat const RCPictureMaxH ;

/**RCUserModel中性别属性值*/
UIKIT_EXTERN NSString * const RCUserModelSexMale;
UIKIT_EXTERN NSString * const RCUserModelSexFemale;