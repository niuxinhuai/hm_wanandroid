import { HashMap } from "@kit.ArkTS";
import { TabConstants } from "helper";

@ObservedV2
export class TabHashMap extends HashMap<string, TabModel> {
}

export default class TabViewModel {
  private newsList: TabHashMap = new HashMap();

  constructor() {
    this.newsList.set(TabConstants.home_key,
      new TabModel('首页', $r('app.media.tab_home'), $r('app.media.tab_home_active'), $r('app.media.tab_index_anim'),
        $r('app.media.tab_index_anim'), false,TabConstants.home_constants));

    this.newsList.set(TabConstants.knowledge_key,
      new TabModel('体系', $r('app.media.tab_zero'), $r('app.media.tab_zero_active'), $r('app.media.tab_index_anim'),
        $r('app.media.tab_index_anim'), false,TabConstants.knowledge_constants));

    this.newsList.set(TabConstants.wechat_key,
      new TabModel('公众号', $r('app.media.tab_vip'), $r('app.media.tab_vip_active'), $r('app.media.tab_index_anim'),
        $r('app.media.tab_index_anim'), false,TabConstants.wechat_constants));

    this.newsList.set(TabConstants.navigation_key,
      new TabModel('导航', $r('app.media.tab_shop'), $r('app.media.tab_shop_active'), $r('app.media.tab_index_anim'),
        $r('app.media.tab_index_anim'), false,TabConstants.navigation_constants));

    this.newsList.set(TabConstants.project_key,
      new TabModel('项目', $r('app.media.tab_user'), $r('app.media.tab_user_active'), $r('app.media.tab_index_anim'),
        $r('app.media.tab_index_anim'), false,TabConstants.project_constants));

  }

  getNewList(): TabHashMap {
    return this.newsList;
  }
}

export class TabModel {
  private label: string = '';
  private normal: ResourceStr = '';
  private active: ResourceStr = '';
  private lottie: ResourceStr = '';
  private top: ResourceStr = '';
  private local: boolean = false;
  private index: number = 0;

  constructor(label: string = '',
    normal: ResourceStr = '',
    active: ResourceStr = '',
    lottie: ResourceStr = '',
    top: ResourceStr = '',
    local: boolean = false,index: number = 0) {
    this.label = label;
    this.normal = normal;
    this.active = active;
    this.lottie = lottie;
    this.top = top;
    this.local = local;
    this.index = index;
  }

  getTabLabel(): string {
    return this.label;
  }

  getTableNormalImage(): ResourceStr {
    return this.normal;
  }

  getTabActiveImage(): ResourceStr {
    return this.active;
  }

  getTabLottie(): ResourceStr {
    return this.lottie;
  }

  getTabTop(): ResourceStr {
    return this.top;
  }

  getTabLocal(): boolean {
    return this.local;
  }

  getTabIndex() : number {
    return this.index;
  }
}