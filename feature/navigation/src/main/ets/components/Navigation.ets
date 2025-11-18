import { NavigationStage } from "helper/src/main/ets/models/navigation"
import { NavigationViewModel } from "../vm/NavigationViewModel"
import { NavigationChildWidget } from "../widgets/NavigationChildWidget"

@ComponentV2
export struct NavigationPage {
  private viewModel: NavigationViewModel = new NavigationViewModel()
  @Local curIndex: number = 0
  private tabController: TabsController = new TabsController()
  @Local topRectHeight: number | undefined = AppStorage.get('topRectHeight');

  aboutToAppear(): void {
    this.viewModel.onCreate()
  }

  build() {
    Column() {
      if ((this.viewModel.wrap?.data?.length ?? 0) > 0) {
        Tabs({ barPosition: BarPosition.Start, controller: this.tabController, index: $$this.curIndex }) {
          ForEach(this.viewModel.wrap?.data, (item: NavigationStage, index: number) => {
            TabContent() {
              NavigationChildWidget({ items: item.articles }).height('100%').padding({left:12,right:12,top:8})
            }.tabBar(this.TabBuilder(item, index))
          })
        }
        .backgroundColor('#FFFFFF')
        .barHeight('100%')
        .barWidth('25%')
        .barMode(BarMode.Scrollable)
        .vertical(true)
        .divider({ strokeWidth: 5, color: '#F7F7F7' })
        .margin({top: this.getUIContext().px2vp(this.topRectHeight),})
      }
    }.height('100%').width('100%').backgroundColor('#F7F7F7')
  }

  @Builder
  TabBuilder(model: NavigationStage, index: number) {
    Column() {
      Text(model.name)
        .fontSize(13)
        .fontWeight(index == this.curIndex ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(index == this.curIndex ? '#333333' : '#999999')
        .height(18)
      Stack() {
        if (index == this.curIndex) {
          Text()
            .backgroundColor(Color.Orange)
            .width(16)
            .height(3)
            .margin({ top: 4 })
            .borderRadius(2)
        }
      }.height(7)

    }.justifyContent(FlexAlign.Center).onClick(() => {
      this.curIndex = index
      this.tabController.changeIndex(this.curIndex)
    }).height(40)
  }
}