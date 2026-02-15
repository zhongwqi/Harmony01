import { TabListItem } from '../types/Types'
import { MainEntryVM } from '../viewmodels/MainEntryVM'

@Builder
export function MainEntryBuilder() {
  MainEntry()
}

@ComponentV2
struct MainEntry {
  private controller: TabsController = new TabsController()
  @Local vm: MainEntryVM = MainEntryVM.instance

  build() {
    NavDestination() {
      Column() {
        Tabs({barPosition:BarPosition.End, index: this.vm.curIndex, controller: this.controller}) {
          ForEach(this.vm.tabList, (item: TabListItem, index: number) => {
            TabContent() {
              item.component.builder()
            }
            .tabBar(this.tabBarBuilder(item, index))
            .clip(index != 0)
            .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
          }, (item: TabListItem, index: number) => item.label)
        }
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
        .scrollable(false)
        .height('100%')
        .barHeight(48)
        .animationDuration(0)
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          this.vm.curIndex = index;
        })
      }
      .backgroundColor(Color.White)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
      .height('100%')
    }
    .hideTitleBar(true)
  }

  @Builder
  tabBarBuilder(item: TabListItem, index: number) {
    Column() {
      Image(this.vm.curIndex == index ? item.iconChecked : item.icon)
        .width(24)
        .height(24)
      Text(item.label)
        .fontColor(this.vm.curIndex == index ? '#FD4238' : '#99000000')
        .fontSize(10)
        .margin({top: 4})
    }.width('100%').margin({top: 10})
  }
}