import { Route } from "@hzw/zrouter";
import { RouterConstants } from "helper";
import { inputMethod } from '@kit.IMEKit'
import { SearchBarWidget } from "../widgets/search_bar";
import { SearchViewModel } from "../vm/search";
import { HotSearchWidget } from "../widgets/hot_search";
import { ArrayUtil } from "@pura/harmony-utils";
import { HistorySearchWidget } from "../widgets/history_search";
import { apng } from "@ohos/apng";

@Route({ name: RouterConstants.search })
@ComponentV2
export struct SearchPage {
  private viewModel: SearchViewModel = new SearchViewModel()
  @Local topRectHeight: number | undefined = AppStorage.get('topRectHeight');

  aboutToAppear(): void {
    this.viewModel.onCreate()
  }

  aboutToDisappear(): void {
    this.viewModel.onDisappear()
  }

  build() {
    NavDestination() {
      this.buildNormalSearch()
    }.title(this.buildSearchBar()).hideBackButton(true).onClick(() => {
      inputMethod.getController().stopInputSession()
    }).margin({top: this.getUIContext().px2vp(this.topRectHeight),})
  }

  @Builder
  buildSearchBar() {
    SearchBarWidget({
      onSubmit: (text) => {
        this.viewModel.doSearch(text)
      },deleteHistory:()=> {
        this.viewModel.deleteHistory()
      }
    })
  }

  @Builder
  buildNormalSearch() {
    Column() {
      if ((this.viewModel.hotWrap?.data?.length ?? 0) > 0) {
        HotSearchWidget({ items: this.viewModel.hotWrap?.data ?? [] })
      }
      if (ArrayUtil.isNotEmpty(this.viewModel.history)) {
        HistorySearchWidget({ items: this.viewModel.history ?? [] }).padding({ top: 20 })
      }

    }.width('100%').height('100%').padding({ left: 12, right: 12 })
  }
}