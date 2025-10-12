import { KnowledgeChild, KnowledgeStage } from "helper/src/main/ets/models/knowledge"
import { LengthMetrics } from "@kit.ArkUI"
import { RouterConstants, RouterUtils } from "helper"

@ComponentV2
export struct KnowledgeItemWidget {
  @Param @Require item: KnowledgeStage

  @Builder
  buildGridRow() {
    Flex({wrap:FlexWrap.Wrap,space:{main:LengthMetrics.px(16),cross:LengthMetrics.px(16)}}){
      ForEach(this.item.children, (child: KnowledgeChild) => {
        Text(child.name)
          .fontSize(12)
          .fontColor(Color.Black)
          .borderWidth(1.0)
          .borderColor('#43C494')
          .padding({
            left: 7,
            right: 7,
          }).borderRadius(12).height(22).width('auto').onClick(()=> {
            RouterUtils.push(RouterConstants.article,{arg:this.item.children,index:this.item.children?.indexOf(child)})
        })
      })
    }
  }

  build() {
    Column() {
      Text(this.item.name).fontSize(16).fontColor(Color.Black).padding({bottom:12})
      if ((this.item.children ?? []).length > 0) {
        this.buildGridRow()
      }
    }
    .backgroundColor(Color.White)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({
      top: 12,
      bottom: 12,
      left: 12,
      right: 12
    }).borderRadius(8)
  }
}