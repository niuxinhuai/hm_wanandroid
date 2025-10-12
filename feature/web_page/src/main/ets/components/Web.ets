import { Route, ZRouter } from "@hzw/zrouter";
import { RouterConstants } from "helper";
import json from "@ohos.util.json";
import { CommonWebView } from "common_widget";
import { webview } from "@kit.ArkWeb";

@Route({ name: RouterConstants.web })
@ComponentV2
export struct WebPage {
  private webController: WebviewController = new webview.WebviewController();
  @Local url?: string
  @Local title?: string

  aboutToAppear(): void {
    const param = ZRouter.getInstance().getParamByKey('link') as string
    this.url = param
  }

  build() {
    NavDestination() {
      CommonWebView({
        url: this.url, controller: this.webController, titleCallback: (title) => {
          this.title = title
        }
      })
        .width('100%')
        .height('100%')
    }.title(this.title)
  }
}