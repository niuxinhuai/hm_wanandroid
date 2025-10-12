import { BaseDataSource, CommonServices } from "helper";
import { KnowledgeStage, KnowledgeWrap } from "helper/src/main/ets/models/knowledge";

@ObservedV2
export class KnowledgeViewModel {

  @Trace dataList: BaseDataSource<KnowledgeStage> = new BaseDataSource<KnowledgeStage>()

  onCreate() {
    this.request()
  }

  async request() {
    this.dataList.clear()
    const wrap = await CommonServices.getKnowledge()
    if ((wrap?.data?.length ?? 0) > 0) {
      this.dataList.addAllData(wrap?.data ?? [])
    }
  }
}