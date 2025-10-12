import { BaseDataSource, CommonServices } from "helper"
import { LoadingStatus } from "helper/src/main/ets/models/common_model"
import { HomeArticleBean, HomeTopArticleWrap } from "helper/src/main/ets/models/home_article"
import { HomeBannerWrap } from "helper/src/main/ets/models/home_banner"

@ObservedV2
export class HomeViewModel {

  //banner数据
  @Trace bannerWrap?: HomeBannerWrap

  //文章列表
  // @Trace articleList?: HomeArticleBean[]
  //页码
  private page:number = 0
  @Trace articleList: BaseDataSource<HomeArticleBean> = new BaseDataSource<HomeArticleBean>()
  @Trace loadingStatus: LoadingStatus = LoadingStatus.idle;

  async onCreate() {
    this.refresh()
  }

  async requestBanner() {
    this.bannerWrap = await CommonServices.getHomeBanner()
    this.bannerWrap?.data?.forEach((e) => {
      console.log(">>>>>>>>>>count" + e.imagePath)
    })
  }

  async refresh() {
    this.loadingStatus = LoadingStatus.loading
    this.page = 0
    this.requestBanner()
    await this.topArticle()
    await this.getArticleList()
    this.loadingStatus = LoadingStatus.complete
  }

  async loadMore() {
    this.loadingStatus = LoadingStatus.loading
    this.page ++
    await this.getArticleList()
    this.loadingStatus = LoadingStatus.complete
  }

  ///置顶文章
  async topArticle() {
    this.articleList.clear()
    const topArticleWrap = await CommonServices.getTopArticle()
    if ((topArticleWrap?.data?.length ?? 0) > 0) {
      this.articleList.addAllData(topArticleWrap?.data ?? [])
    }
  }

  ///文章列表
  async getArticleList() {
    const articleWrap = await CommonServices.getHomeArticleList(this.page)
    console.log(">>>>>>>>文章列表" + articleWrap.data?.datas?.length)
    if ((articleWrap?.data?.datas?.length ?? 0) != 0) {
      this.articleList.addAllData(articleWrap?.data?.datas ?? [])
    }
  }
}