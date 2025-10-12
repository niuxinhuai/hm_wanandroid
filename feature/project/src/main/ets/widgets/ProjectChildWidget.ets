import { HomeArticleWidget } from "common_widget"
import { LoadingStatus } from "helper/src/main/ets/models/common_model"
import { HomeArticleBean } from "helper/src/main/ets/models/home_article"
import { KnowledgeChild } from "helper/src/main/ets/models/knowledge"
import { ProjectArticleViewModel } from "../vm/ProjectArticleViewModel"

@ComponentV2
export struct ProjectChildWidget {
  @Param @Require child: KnowledgeChild
  @Param @Require index: number

  private viewModel:ProjectArticleViewModel = new ProjectArticleViewModel(this.child.id ?? 0)
  @Provider() isRefreshing: boolean = false;
  aboutToAppear(): void {
    this.viewModel.onCreate()
  }

  build() {
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
  }
}