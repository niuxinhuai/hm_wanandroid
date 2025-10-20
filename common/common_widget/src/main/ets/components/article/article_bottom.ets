import { ClickUtil } from "@pura/harmony-utils";
import { DefaultUser, IconUnicode, icon_font_family } from "helper";
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
  private user: DefaultUser = DefaultUser.getInstance()



  build() {
    Row() {
      this.buildLeft()
      Text(this.user.collect_list.includes(`${this.data.title ?? ''}`) ? IconUnicode.favorite : IconUnicode.notFavorite)
        .fontFamily(icon_font_family)
        .fontSize(24)
        .fontColor(Color.Red)
        .onClick(() => {
          ClickUtil.throttle(()=> {
            if (!DefaultUser.getInstance().isLogin()) {
              showLogin()
              return
            }
            //收藏/取消收藏操作
            this.user.userTapFavorite(this.data)
          })

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