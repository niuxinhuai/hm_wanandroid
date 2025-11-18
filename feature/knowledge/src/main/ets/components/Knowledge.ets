import { KnowledgeStage } from "helper/src/main/ets/models/knowledge"
import { KnowledgeViewModel } from "../vm/KnowledgeViewModel"
import { KnowledgeItemWidget } from "../widgets/child"

@ComponentV2
export struct KnowledgePage {
  viewModel: KnowledgeViewModel = new KnowledgeViewModel()
  @Local topRectHeight: number | undefined = AppStorage.get('topRectHeight');

  aboutToAppear(): void {
    this.viewModel.onCreate()
  }

  build() {
    if (this.viewModel.dataList.totalCount() > 0) {
      List({ space: 10 }) {
        LazyForEach(this.viewModel.dataList, (item: KnowledgeStage) => {
          ListItem() {
            KnowledgeItemWidget({ item: item })
          }
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7F7F7')
      .padding({ left: 12, right: 12, top: this.getUIContext().px2vp(this.topRectHeight), })
    }
  }
}