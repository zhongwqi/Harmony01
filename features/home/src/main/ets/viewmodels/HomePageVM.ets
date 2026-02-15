import { BreakpointType } from "commonlib/src/main/ets/constants/GridRowColSetting";
import { BreakpointModel } from "commonlib/src/main/ets/models/BreakpointModel";
import { AppStorageV2 } from "@kit.ArkUI";

const TAG = '[HomePageVM]'

@ObservedV2
export class HomePageVM {
  private static _instance: HomePageVM;
  //搜索框是否可见
  @Trace isSearchVisible: boolean = false
  @Trace isRefreshing: boolean = false
  @Trace breakPointModel: BreakpointModel = AppStorageV2.connect(BreakpointModel, () => new BreakpointModel())!;

  @Trace bannerUr: ResourceStr[] =
    [$r('app.media.banner1'), $r('app.media.banner2'),
    $r('app.media.banner_img1'), $r('app.media.banner_img2')]
  columnOptions: BreakpointType<number> = new BreakpointType<number>({
    sm: 2,
    md: 4,
    lg: 4,
    xl: 4,
  });


  public static get instance() {
    if (!HomePageVM._instance) {
      HomePageVM._instance = new HomePageVM();
    }
    return HomePageVM._instance
  }

  @Computed
  get gridCount() {
    let count = this.columnOptions.getValue(this.breakPointModel.currentBreakpoint)
    console.log('gridCount = ' + count);
    return count
  }
}