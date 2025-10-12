import { HomeArticleBean } from "helper/src/main/ets/models/home_article"
import { LengthMetrics } from "@kit.ArkUI"
import { RouterUtils } from "helper"


@ComponentV2
export struct NavigationChildWidget {

  @Param @Require items: HomeArticleBean[]

  build() {
    this.buildGridRow()
  }

  @Builder
  buildGridRow() {
    Flex({wrap:FlexWrap.Wrap,space:{main:LengthMetrics.px(16),cross:LengthMetrics.px(16)}}){
      ForEach(this.items, (child: HomeArticleBean) => {
        Text(child.title)
          .fontSize(13)
          .fontColor(Color.Black)
          .backgroundColor('#45DC94')
          .padding({
            left: 10,
            right: 10,
            top:8,
            bottom:9
          }).borderRadius(4).width('auto').onClick(()=> {
            RouterUtils.pushWeb(child.link ?? '')
        })
      })
    }
  }
}

