import { DefaultUser } from "helper";
import { HomeArticleBean } from "helper/src/main/ets/models/home_article"
import { LoginPage } from "login";
import { SmartDialog } from 'ohos_smart_dialog';

function showLogin() {
  SmartDialog.show({
    builder: buildLoginDialog,
    alignment: Alignment.Bottom
  })
}

@Builder
function buildLoginDialog() {
  LoginPage()
}

@ComponentV2
export struct ArticleBottomWidget {
  @Param @Require data: HomeArticleBean

  build() {
    Row() {
      this.buildLeft()
      SymbolGlyph($r('sys.symbol.compass_circle'))
        .fontSize(24)
        .effectStrategy(SymbolEffectStrategy.SCALE)
        .onClick(() => {
          if (!DefaultUser.getInstance().isLogin()) {
            showLogin()
            return
          }
          //收藏/取消收藏操作

        })
    }.justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  buildLeft() {
    Row() {
      if ((this.data.type ?? 0) == 1) {
        Text('置顶').fontSize(13).fontColor(Color.Red).padding({ right: 3 })
      }
      Text((this.data.superChapterName ? `${this.data.superChapterName} · ` : '') + this.data.chapterName)
        .fontSize(13)
        .fontColor('#999999')
    }.layoutWeight(1)
  }
}