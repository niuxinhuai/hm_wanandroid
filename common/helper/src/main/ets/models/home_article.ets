import { CommonModel } from "./common_model";

export interface HomeTopArticleWrap extends CommonModel<HomeArticleBean[]> {}

export interface HomeArticleWrap extends CommonModel<HomeArticleStage> {}

export interface HomeArticleStage {
  curPage?:number
  datas?: HomeArticleBean[]
  offset?:number
  over?:boolean
  pageCount?:number
  size?:number
  total?:number
}

export interface HomeArticleBean {
  apkLink?: string;
  audit?: number;
  author?: string;
  canEdit?: boolean;
  chapterId?: number;
  chapterName?: string;
  //这个字段不是收藏
  collect?: boolean;
  courseId?: number;
  desc?: string;
  descMd?: string;
  envelopePic?: string;

  //是否是新发布的文章
  fresh?: boolean;
  host?: string;
  id?: number;
  link?: string;
  niceDate?: string;
  niceShareDate?: string;
  origin?: string;
  originId?: number;
  prefix?: string;
  projectLink?: string;
  publishTime?: number;
  realSuperChapterId?: number;
  selfVisible?: number;
  shareDate?: number;
  shareUser?: string;
  superChapterId?: number;
  superChapterName?: string;
  tags?: ArticleTagBean[];
  title?: string;

  //1代表置顶，
  type?: number;
  userId?: number;
  visible?: number;
  zan?: number;
}

export interface ArticleTagBean {
  name?: string
  url?: string
}