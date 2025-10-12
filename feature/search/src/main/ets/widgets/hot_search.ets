import { HotSearchItem } from "helper/src/main/ets/models/search"
import { LengthMetrics } from "@kit.ArkUI"
import { RouterConstants, RouterUtils } from "helper"

@ComponentV2
export struct HotSearchWidget {
  @Param @Require items: HotSearchItem[]

  build() {

    Column() {
      Text('热搜').fontSize(22).fontColor(Color.Black).fontWeight(FontWeight.Bold).padding({bottom:12})
      this.buildGridRow()
    }.alignItems(HorizontalAlign.Start).width('100%')

  }

  @Builder
  buildGridRow() {
    Flex({wrap:FlexWrap.Wrap,space:{main:LengthMetrics.px(16),cross:LengthMetrics.px(16)}}){
      ForEach(this.items, (child: HotSearchItem) => {
        Text(child.name)
          .fontSize(12)
          .fontColor(Color.Black)
          .padding({
            left: 12,
            right: 12,
            top:5,
            bottom:5
          }).borderRadius(12).backgroundColor('#D8E3EB').height(22).width('auto').onClick(()=> {
          RouterUtils.push(RouterConstants.search_result,{keyword:child.name})
        })
      })
    }
  }
}