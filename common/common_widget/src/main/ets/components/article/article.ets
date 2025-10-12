import { RouterUtils } from "helper"
import { HomeArticleBean } from "helper/src/main/ets/models/home_article"
import { ArticleBottomWidget } from "./article_bottom"
import { ArticleContentWidget } from "./article_content"
import { ArticleHeaderWidget } from "./article_header"

@ComponentV2
export struct HomeArticleWidget {
  @Param @Require data: HomeArticleBean

  build() {
    Stack() {
      Column() {
        ArticleHeaderWidget({ data: this.data }).padding({ bottom: 10 })
        ArticleContentWidget({ data: this.data })
        ArticleBottomWidget({ data: this.data }).padding({ top: 10 })

      }.alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .margin({ top: 8 })
    .borderRadius(12)
    .backgroundColor(Color.White)
    .padding({
      left: 12,
      top: 10,
      bottom: 10,
      right: 12
    })
    .onClick(() => {
      RouterUtils.pushWeb(this.data.link ?? '')
    })
  }
}