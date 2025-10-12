import { ZRouter } from '@hzw/zrouter';
import { CommonServices, TabConstants } from 'helper';
import { HomePage } from 'home';
import { KnowledgePage } from 'knowledge';
import { NavigationPage } from 'navigation';
import { ProjectPage } from 'project';
import { WeChatPage } from 'wechat';
import TabViewModel, { TabHashMap, TabModel } from './model/tab';

@Entry
@ComponentV2
struct Index {
  @Local curIndex: number = TabConstants.home_constants;
  private tabController: TabsController = new TabsController();
  private tabViewModel: TabViewModel = new TabViewModel();
  private newsList: TabHashMap = this.tabViewModel.getNewList();

  @Builder
  TabBuilder(model: TabModel) {
    Column() {
      Image(this.curIndex == model.getTabIndex() ? model.getTabActiveImage() : model.getTableNormalImage())
        .width($r(model.getTabLocal() == false ? 'app.float.tab_local_width' : 'app.float.tab_service_width'))
        .height($r(model.getTabLocal() == false ? 'app.float.tab_local_height' : 'app.float.tab_service_height'))

      Text(model.getTabLabel())
        .fontSize($r('app.float.title_font_10'))
        .fontColor(this.curIndex == model.getTabIndex() ? $r('app.color.primaryColor') : $r('app.color.grayColor'))
        .margin({ top: $r('app.float.tab_top_margin') })
    }.onClick(() => {
      this.curIndex = model.getTabIndex();
      this.tabController.changeIndex(this.curIndex);
    })
  }

  build() {
    Navigation(ZRouter.getNavStack()) {
      Tabs({ barPosition: BarPosition.End, controller: this.tabController, index: this.curIndex }) {
        TabContent() {
          HomePage()
        }.tabBar(this.TabBuilder(this.newsList.get(TabConstants.home_key)))

        TabContent() {
          KnowledgePage()
        }.tabBar(this.TabBuilder(this.newsList.get(TabConstants.knowledge_key)))

        TabContent() {
          WeChatPage()
        }.tabBar(this.TabBuilder(this.newsList.get(TabConstants.wechat_key)))

        TabContent() {
          NavigationPage()
        }.tabBar(this.TabBuilder(this.newsList.get(TabConstants.navigation_key)))

        TabContent() {
          ProjectPage()
        }.tabBar(this.TabBuilder(this.newsList.get(TabConstants.project_key)))
      }.scrollable(false).onTabBarClick((idx) => {
        this.curIndex = idx;
      })
    }.hideToolBar(true)

  }
}
