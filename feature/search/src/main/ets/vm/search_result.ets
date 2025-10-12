import { BaseDataSource, CommonServices } from "helper";
import { LoadingStatus } from "helper/src/main/ets/models/common_model";
import { HomeArticleBean } from "helper/src/main/ets/models/home_article";

@ObservedV2
export class SearchResultViewModel {
  @Trace articleList: BaseDataSource<HomeArticleBean> = new BaseDataSource<HomeArticleBean>()
  private keyword: string = ''
  private page: number = 0
  @Trace loadingStatus: LoadingStatus = LoadingStatus.idle;
  constructor() {
    this.page = 0
  }

  onCreate(keyword:string) {
    this.keyword = keyword
    this.refresh()
  }

  private async request() {
    const wrap = await CommonServices.getSearch(this.page,this.keyword)
    console.log('>>>>>>>>>数量:' + wrap?.data?.datas?.length)
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