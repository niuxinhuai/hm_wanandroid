import { HomeArticleBean } from "helper/src/main/ets/models/home_article"

@ComponentV2
export struct ArticleBottomWidget {
  @Param @Require data: HomeArticleBean

  build() {
    Row() {
      this.buildLeft()
      SymbolGlyph($r('sys.symbol.compass_circle')).fontSize(24).effectStrategy(SymbolEffectStrategy.SCALE)
    }.justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  buildLeft() {
    Row() {
      if ((this.data.type ?? 0) == 1) {
        Text('置顶').fontSize(13).fontColor(Color.Red).padding({right:3})
      }
      Text((this.data.superChapterName ? `${this.data.superChapterName} · ` : '') + this.data.chapterName)
        .fontSize(13)
        .fontColor('#999999')
    }.layoutWeight(1)
  }
}