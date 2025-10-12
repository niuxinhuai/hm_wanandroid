import { KnowledgeChild } from "helper/src/main/ets/models/knowledge"
import { WeChartViewModel } from "../vm/WeChartViewModel"
import { WeChartChildWidget } from "../widgets/child"

@ComponentV2
export struct WeChatPage {

  viewModel: WeChartViewModel = new WeChartViewModel()
  private tabController: TabsController = new TabsController()
  @Local curIndex: number = 0

  aboutToAppear(): void {
    this.viewModel.onCreate()
  }

  build() {
    Column() {
      if ((this.viewModel.wrap?.data?.length ?? 0) > 0) {
        Tabs({ barPosition: BarPosition.Start, controller: this.tabController, index: $$this.curIndex }) {
          ForEach(this.viewModel.wrap?.data, (item: KnowledgeChild, index: number) => {
            TabContent() {
              WeChartChildWidget({child: item,index:index})
            }.tabBar(this.TabBuilder(item,index))
          })
        }.backgroundColor('#FFFFFF').barHeight(40).barMode(BarMode.Scrollable)
      }
    }.height('100%').width('100%')
  }

  @Builder
  TabBuilder(model: KnowledgeChild,index:number) {
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
    }).height(40).padding({right:12,left:12})
  }
}