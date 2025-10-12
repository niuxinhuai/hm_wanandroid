import { ArticleTagBean, HomeArticleBean } from "helper/src/main/ets/models/home_article"

@ComponentV2
export struct ArticleHeaderWidget {
  @Param @Require data: HomeArticleBean

  build() {
    Row() {
      this.buildLeft()
      Text(this.data.niceDate).fontSize(13).fontColor('#999999')
    }.justifyContent(FlexAlign.SpaceBetween).width('100%')
  }

  @Builder
  buildLeft() {
    Row() {
      if (this.data.fresh) {
        Text('新').fontSize(13).fontColor('#1578FF')
      }
      Text((this.data.author ?? '') != '' ? this.data.author : this.data.shareUser)
        .fontSize(13)
        .fontColor(Color.Black)
        .padding({ left: this.data.fresh ? 3 : 0, right: 3 })
    }

    if ((this.data.tags ?? 0) > 0) {
      List() {
        ForEach(this.data.tags, (item: ArticleTagBean, idx: number) => {
          ListItem() {
            Text(item.name)
              .fontSize(11)
              .fontColor('#1578FF')
              .padding({
                top: 1,
                bottom: 1,
                left: 2,
                right: 3
              })
              .borderRadius(3)
              .borderWidth(0.5)
              .borderColor('#1578FF')
          }
        })
      }.layoutWeight(1)
    }
  }
}