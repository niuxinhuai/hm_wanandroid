import { BaseDataSource, CommonServices } from "helper";
import { LoadingStatus } from "helper/src/main/ets/models/common_model";
import { HomeArticleBean } from "helper/src/main/ets/models/home_article";

@ObservedV2
export class KnowledgeArticleViewModel {
  @Trace articleList: BaseDataSource<HomeArticleBean> = new BaseDataSource<HomeArticleBean>()
  private id: number = 0
  private page: number = 0
  @Trace loadingStatus: LoadingStatus = LoadingStatus.idle;
  constructor(id:number) {
    this.id = id
    this.page = 0
  }

  onCreate() {
    this.refresh()
  }

  private async request() {
    const wrap = await CommonServices.getKnowledgeUserArticle(this.id,this.page)
    if ((wrap?.data?.datas?.length ?? 0) != 0) {
      this.articleList.addAllData(wrap?.data?.datas ?? [])
    }
  }

  async refresh() {
    this.loadingStatus = LoadingStatus.loading
    this.page = 0
    await this.request()
    this.loadingStatus = LoadingStatus.complete
  }

  async loadMore() {
    this.loadingStatus = LoadingStatus.loading
    this.page ++
    await this.request()
    this.loadingStatus = LoadingStatus.complete
  }

}