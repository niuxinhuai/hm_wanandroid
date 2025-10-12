import { RouterConstants, RouterUtils } from "helper"
import { KnowledgeChild } from "helper/src/main/ets/models/knowledge"
import { ProjectViewModel } from "../vm/ProjectViewModel"
import { ProjectChildWidget } from "../widgets/ProjectChildWidget"

@ComponentV2
export struct ProjectPage {
  private viewModel: ProjectViewModel = new ProjectViewModel()
  private tabController: TabsController = new TabsController()
  @Local curIndex: number = 0

  aboutToAppear(): void {
    this.viewModel.onCreate()
  }

  build() {
    Column() {

      this.buildSearchBar()
      if ((this.viewModel.wrap?.data?.length ?? 0) > 0) {
        Tabs({ barPosition: BarPosition.Start, controller: this.tabController, index: $$this.curIndex }) {
          ForEach(this.viewModel.wrap?.data, (item: KnowledgeChild, index: number) => {
            TabContent() {
              ProjectChildWidget({ child: item, index: index })
            }.tabBar(this.TabBuilder(item, index))
          })
        }.backgroundColor('#FFFFFF').barHeight(40).barMode(BarMode.Scrollable)
      }
    }.height('100%').width('100%')
  }

  @Builder
  buildSearchBar() {
    Row() {
      TextInput({ placeholder: "开始搜索" })
        .placeholderFont({ size: 13, weight: FontWeight.Normal })
        .placeholderColor('#666666')
        .height(30)
        .layoutWeight(1)
        .focusOnTouch(false).onClick(() =>{
        RouterUtils.push(RouterConstants.search)
      })
      Text('搜索')
        .fontSize(16)
        .fontColor(Color.Red)
        .fontWeight(FontWeight.Bold)
        .padding({
          left: 8,
          right: 8,
          top: 4,
          bottom: 4
        })
        .borderRadius(4)
        .backgroundColor('999999')
        .margin({ left: 12 })
    }.width('100%').padding({ left: 12, right: 12 })
  }

  @Builder
  TabBuilder(model: KnowledgeChild, index: number) {
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
    }).height(40).padding({ right: 12, left: 12 })
  }
}