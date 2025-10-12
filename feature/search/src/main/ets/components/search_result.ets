import { Route, ZRouter } from "@hzw/zrouter";
import { HomeArticleWidget } from "common_widget";
import { RouterConstants } from "helper";
import { LoadingStatus } from "helper/src/main/ets/models/common_model";
import { HomeArticleBean } from "helper/src/main/ets/models/home_article";
import { KnowledgeChild } from "helper/src/main/ets/models/knowledge";
import { SearchResultViewModel } from "../vm/search_result";

@Route({name:RouterConstants.search_result})
@ComponentV2
export struct SearchResultPage {

  private viewModel: SearchResultViewModel = new SearchResultViewModel()
  @Provider() isRefreshing: boolean = false;
  @Local keyword:string = ''

  aboutToAppear(): void {
    const keyword = ZRouter.getInstance().getParamByKey('keyword') as string
    this.keyword = keyword
    this.viewModel.onCreate(keyword)
  }

  build() {
    NavDestination(){
      Refresh({ refreshing: $$this.isRefreshing }) {
        Scroll() {
          Column() {
            if ((this.viewModel.articleList?.totalCount() ?? 0) != 0) {
              List() {
                LazyForEach(this.viewModel.articleList, (item: HomeArticleBean) => {
                  ListItem() {
                    HomeArticleWidget({ data: item })
                  }
                })
              }
              .width('100%')
              .scrollBar(BarState.Off)
              .edgeEffect(EdgeEffect.None).padding({left:12,right:12})
            }
          }
        }.edgeEffect(EdgeEffect.Spring).onReachEnd(() => {
          if (this.viewModel.loadingStatus == LoadingStatus.complete) {
            this.viewModel.loadMore()
          }
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7F7F7')
      .onRefreshing(async () => {
        await this.viewModel.refresh()
        this.isRefreshing = false
      })
      .refreshOffset(64)
      .pullToRefresh(true)
    }.title(`搜索结果页--${this.keyword}`)
  }
}