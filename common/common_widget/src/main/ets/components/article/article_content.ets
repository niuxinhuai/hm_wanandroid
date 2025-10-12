import { HomeArticleBean } from "helper/src/main/ets/models/home_article"

@ComponentV2
export struct ArticleContentWidget {

  @Param @Require data:HomeArticleBean

  build() {
    Row(){
      if ((this.data.envelopePic ?? '') != '') {
        Image(this.data.envelopePic).objectFit(ImageFit.Cover).width(120).padding({right:8})
      }
      Column() {
        Text(this.data.title)
          .fontColor(Color.Black)
          .fontSize(16)
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        if ((this.data.desc ?? '') != '') {
          Text(this.data.desc)
            .fontColor('#666666')
            .fontSize(14)
            .maxLines(7)
            .textOverflow({ overflow: TextOverflow.Ellipsis }).padding({top:8})
        }
      }.justifyContent(FlexAlign.Start).alignItems(HorizontalAlign.Start).layoutWeight(1)
    }.alignItems(VerticalAlign.Top)
  }
}