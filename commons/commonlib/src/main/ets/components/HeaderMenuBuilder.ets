
@Builder
export function HeaderMenuBuilder() {
  Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
    Column() {
      Row() {
        Text('菜篮子').fontSize(16).fontWeight(FontWeight.Medium).fontColor($r('sys.color.font_primary'))
          .height(48)
          .width('100%')
          .constraintSize({maxWidth: '100%'})
      }
      .onClick(() => {

      })
      .width(100).padding({left: 16, right: 16})
    }
  }
}