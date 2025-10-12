import Uri from "../../constants/uri";
import { HomeArticleWrap, HomeTopArticleWrap } from "../../models/home_article";
import { HomeBannerWrap } from "../../models/home_banner";
import { KnowledgeChild, KnowledgeWrap } from "../../models/knowledge";
import { NavigationWrap } from "../../models/navigation";
import { ProjectWrap } from "../../models/project";
import { HotSearchWrap } from "../../models/search";
import { WeChartWrap } from "../../models/we_chat";
import ServiceHelper, { apiRequest } from "../../service_helper/service_helper";

export class CommonServices {

  ///首页banner
  static async getHomeBanner():Promise<HomeBannerWrap> {
    return await apiRequest.get(Uri.home_banner)
  }

  ///置顶文章
  static async getTopArticle(): Promise<HomeTopArticleWrap> {
    return await apiRequest.get(Uri.top_article)
  }

  ///文章列表
  static async getHomeArticleList(page:number): Promise<HomeArticleWrap> {
    return await apiRequest.get(Uri.home_article(page))
  }

  ///知识库
  static async getKnowledge():Promise<KnowledgeWrap> {
    return await apiRequest.get(Uri.knowledge)
  }

  ///知识体系下的文章
  static async getKnowledgeUserArticle(id:number,page:number): Promise<HomeArticleWrap> {
    return await apiRequest.get(Uri.knowledge_article(id,page))
  }

  ///公众号相关
  static async getWeChartTab():Promise<WeChartWrap> {
    return await apiRequest.get(Uri.wxArticle)
  }

  ///公众号文章列表
  static async getWxArticleList(id:number,page:number): Promise<HomeArticleWrap> {
    return await apiRequest.get(Uri.wxUserArticleList(id,page))
  }

  ///导航
  static async getNavigationData(): Promise<NavigationWrap> {
    return await apiRequest.get(Uri.navigationJson)
  }

  ///项目
  static async getProjectArticles():Promise<ProjectWrap> {
    return await apiRequest.get(Uri.projectTree)
  }

  ///项目文章列表
  static async getProjectArticleList(id:number,page:number): Promise<HomeArticleWrap> {
    return await apiRequest.get(Uri.projectList(id,page))
  }

  ///热搜数据
  static async getHotSearch():Promise<HotSearchWrap> {
    return await apiRequest.get(Uri.hotSearch)
  }

  ///搜索
  ///支持多个关键词，用空格隔开
  static async getSearch(page:number,keyword:string):Promise<HomeArticleWrap> {
    return await apiRequest.post(Uri.searchJson(page),{'k':keyword})
  }
}