export default class Uri {
  ///base
  static readonly baseUri = "https://www.wanandroid.com/"
  ///首页banner
  static readonly home_banner = "banner/json";

  ///首页文章列表
  static home_article(page: number): string {
    return `article/list/${page}/json`;
  };

  ///置顶文章
  static readonly top_article = "article/top/json";
  ///知识体系
  ///方法：GET
  static readonly knowledge = "tree/json";

  ///知识体系下的文章
  ///方法：GET
  static knowledge_article(id: number, page: number) {
    return `article/list/${page}/json?cid=${id}`
  }

  ///微信公众号文章
  ///方法：GET
  static readonly wxArticle = "wxarticle/chapters/json";

  ///微信公众号下对应的用户id的文章
  ///方法：GET
  static wxUserArticleList(id: number, page: number): string {
    return `wxarticle/list/${id}/${page}/json`;
  }

  ///导航
  ///方法：GET
  static readonly navigationJson = "navi/json";
  ///项目
  ///方法： GET
  static readonly projectTree = "project/tree/json";

  ///项目列表下的数据,
  ///方法：GET
  ///参数：
  ///	cid 分类的id，上面项目分类接口
  ///	页码：拼接在链接中，从1开始。
  static projectList(cid: number, page: number): string {
    return `project/list/${page}/json?cid=${cid}`
  }

  ///搜索
  ///方法：POST
  ///页码：拼接在链接上，从0开始。
  ///k ： 搜索关键词
  static searchJson(page:number):string {
    return `article/query/${page}/json`
  };

  ///热搜
  static readonly hotSearch = "hotkey/json";

  ///登录
  static readonly login = 'user/login'

  ///注册
  static readonly register = 'user/register'

  ///收藏文章列表
  ///方法 - GET
  static collectList(page:number,pageSize:number):string {
    return `lg/collect/list/${page}/json?page_size=${pageSize}`
  };

  ///收藏站内文章
  ///方法：POST
  static collectIn(id:number | string):string {
    return `lg/collect/${id}/json`
  }

  ///收藏站外文章
  ///方法：POST
  ///title，author，link
  static readonly collectOut = "lg/collect/add/json";

  ///取消收藏
  static unCollect(id:number | string) {
    return `lg/uncollect_originId/${id}/json`
};
}