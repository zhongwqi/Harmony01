import { BreakpointType } from "commonlib/src/main/ets/constants/GridRowColSetting";
import { BreakpointModel } from "commonlib/src/main/ets/models/BreakpointModel";
import { AppStorageV2 } from "@kit.ArkUI";
import { RecipeBriefInfo, TabItem } from "featured_recipes";
import LazyDataSource from "featured_recipes/src/main/ets/utils/LazyDataSource";
import { queryRecipeList } from "network";

const TAG = '[HomePageVM]'

@ObservedV2
export class HomePageVM {
  private static _instance: HomePageVM;
  //搜索框是否可见
  @Trace isSearchVisible: boolean = false
  @Trace isLoading: boolean = false;
  @Trace isRefreshing: boolean = false
  @Trace totalCount = 75; //实际以接口为准
  @Trace breakPointModel: BreakpointModel = AppStorageV2.connect(BreakpointModel, () => new BreakpointModel())!;
  @Trace dishesList: LazyDataSource<RecipeBriefInfo> = new LazyDataSource();
  @Trace bannerUr: ResourceStr[] =
    [$r('app.media.banner1'), $r('app.media.banner2'),
    $r('app.media.banner_img1'), $r('app.media.banner_img2')]
  columnOptions: BreakpointType<number> = new BreakpointType<number>({
    sm: 2,
    md: 4,
    lg: 4,
    xl: 4,
  });
  @Trace tabList: TabItem[] = [
    {
      label: '家常菜',
      icon: $r('app.media.ic_home_dish'),
    },
    {
      label: '下饭菜',
      icon: $r('app.media.ic_meal_dish'),
    },
    {
      label: '快手菜',
      icon: $r('app.media.ic_fast'),
    },
    {
      label: '减脂餐',
      icon: $r('app.media.ic_fat'),
    },
    {
      label: '更多',
      icon: $r('app.media.ic_more'),
    },
  ];

  public async getDishesList() {
    const res = await queryRecipeList()
    if (res.status == 200) {
      this.dishesList.pushArrayData(res.data)
    }
  }


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