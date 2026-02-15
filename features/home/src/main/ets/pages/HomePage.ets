import { BaseHeader, HeaderRefreshBuilder } from "commonlib"
import { HomePageVM } from "../viewmodels/HomePageVM"

@Builder
export function HomePageBuilder() {
  HomePage()
}

@Preview
@ComponentV2
struct HomePage {
  vm: HomePageVM = HomePageVM.instance

  build() {
    NavDestination() {
      BaseHeader({showSearch: this.vm.isSearchVisible, showRightMenu: this.vm.isSearchVisible})
      Refresh({refreshing: $$this.vm.isRefreshing, builder: HeaderRefreshBuilder()}) {
        Scroll() {
          Column() {
            Swiper() {
              ForEach(this.vm.bannerUr, (item: ResourceStr, index: number) => {
                Image(item)
                .width(this.vm.gridCount === 2 ? '100%' : 340)
                .height('100%')
                .borderRadius(16)
              }, (item: ResourceStr) => JSON.stringify(item))
            }
            .width('100%')
            .height(this.vm.gridCount === 2 ? 270 : 192)
            .itemSpace(12)
            .nextMargin(this.vm.gridCount === 2 ? 0 : 12)
            .autoPlay(true)
            .loop(true)
            .indicator(
              new DotIndicator()
                .itemWidth(6)
                .itemHeight(6)
                .selectedItemWidth(12)
                .selectedItemHeight(6)
                .color('#33FFFFFF')
                .selectedColor('#E84026')
            )
            .borderRadius(16)
            .displayCount(this.vm.gridCount / 2)
          }
        }
        .padding({left: 16, right: 16})
      }
    }
    .hideTitleBar(true)
  }
}