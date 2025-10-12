@ComponentV2
export struct CommonWebView {
  @Param @Require url:string
  @Param @Require controller: WebviewController;
  @Event titleCallback:(val:string)=>void
  build() {
    Web({
      src: this.url,
      controller: this.controller
    }).onPageEnd(() => {
      const title = this.controller.getTitle()
      this.titleCallback(title)
    }).width('100%').height('100%')
  }
}