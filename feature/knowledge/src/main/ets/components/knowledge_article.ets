import { Route, ZRouter } from "@hzw/zrouter";
import { RouterConstants } from "helper";
import { KnowledgeChild } from "helper/src/main/ets/models/knowledge";
import { KnowledgeArticleChildWidget } from "../widgets/article_child";

@Route({name:RouterConstants.article})
@ComponentV2
export struct KnowledgeArticlePage {

  private tabController: TabsController = new TabsController()
  @Local curIndex: number = 0
  @Local children: KnowledgeChild[] = []

  aboutToAppear(): void {
    this.children = ZRouter.getInstance().getParamByKey('arg') as KnowledgeChild[]
    this.curIndex = ZRouter.getInstance().getParamByKey('index')

  }

  build() {
    NavDestination(){
      Column() {
        if ((this.children.length ?? 0) > 0) {
          Tabs({ barPosition: BarPosition.Start, controller: this.tabController, index: $$this.curIndex }) {
            ForEach(this.children, (item: KnowledgeChild, index: number) => {
              TabContent() {
                KnowledgeArticleChildWidget({cid:item.id})
              }.tabBar(this.TabBuilder(item,index))
            })
          }.backgroundColor('#FFFFFF').barHeight(40).barMode(BarMode.Scrollable)
        }
      }.height('100%').width('100%')
    }.title('文章列表')
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