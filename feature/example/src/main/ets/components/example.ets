import { Route } from "@hzw/zrouter";
import { RouterConstants } from "helper";
import { LengthMetrics } from "@kit.ArkUI";
import { ExampleViewModel } from "../vm/ExampleViewModel";
import { ArrayUtil, ClickUtil, RandomUtil } from "@pura/harmony-utils";
import { ImageView, VideoView } from "common_widget";
import { PageCutOut, ViewFrame } from "./page_cutout";
import { common } from "@kit.AbilityKit";
import { SmartDialog } from "ohos_smart_dialog";


@Route({ name: RouterConstants.example })
@ComponentV2
export struct ExamplePage {
  private viewModel: ExampleViewModel = new ExampleViewModel()
  @Local private fileImageList: string[] = []
  @Local private fileVideoList: string[] = []
  @Local private showCanvas: boolean = true
  private textKey = 'target'
  uiContext = this.getUIContext()?.getHostContext() as common.UIAbilityContext;
  private windowClass = this.uiContext.windowStage.getMainWindowSync();

  aboutToAppear(): void {
    this.onShown()
    showCanvas(this.textKey,this.getUIContext())
  }

  aboutToDisappear(): void {
    this.onHidden()
  }

  build() {
    NavDestination() {
      Stack() {
        Column() {
          Row()
            .width('100%')
            .height(88)
            .backgroundColor(Color.Green)
            .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
          Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.px(16), cross: LengthMetrics.px(16) } }) {
            this.buildButton('选择图片', async () => {
              this.fileImageList = await this.viewModel.selected()
            })
            this.buildButton('选择单图', async () => {
              this.fileImageList = await this.viewModel.selectSingleImage()
            })
            this.buildButton('选择单个视频', async () => {
              this.fileVideoList = await this.viewModel.selectSingleVideo()
            })
          }.width('100%').height(300)

          this.buildFileImage()
          this.buildFileVideo()
          ForEach([1, 2, 3, 4, 5, 6], (s: number) => {
            Text(`${s}`).width('100%').height(300).backgroundColor(RandomUtil.getRandomColor()).margin({ bottom: 10 })
          })
        }.alignItems(HorizontalAlign.Start)

        Text('引导专用')
          .width(80)
          .height(40)
          .borderRadius(8)
          .backgroundColor(Color.Green)
          .textAlign(TextAlign.Center)
          .position({ right: 10, bottom: 200 })
          .key(this.textKey)
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.TopStart)

    }.hideTitleBar(true)

  }

  //设置状态栏内容颜色
  onShown() {
    this.windowClass.setWindowSystemBarProperties({
      statusBarContentColor: '#FFFFFF'
    });
  }

  onHidden() {
    this.windowClass.setWindowSystemBarProperties({
      statusBarContentColor: '#000000'
    });
  }

  //本地图片选择展示
  @Builder
  buildFileImage() {
    if (ArrayUtil.isNotEmpty(this.fileImageList)) {
      Grid() {
        ForEach(this.fileImageList, (item: string) => {
          GridItem() {
            ImageView({
              url: item,
              imageWidth: 100,
              imageHeight: 100,
              objectFit: ImageFit.Fill
            })
          }
        })
      }
    }
  }

  //本地视频选择展示
  @Builder
  buildFileVideo() {
    if (ArrayUtil.isNotEmpty(this.fileVideoList)) {
      Grid() {
        ForEach(this.fileVideoList, (item: string) => {
          GridItem() {
            VideoView({
              url: item,
            }).width(200).height(200)
          }
        })
      }
    }
  }

  @Builder
  buildButton(name: string, onEvent: () => void = () => {
  }) {
    Text(name)
      .fontSize(12)
      .fontColor(Color.Black)
      .borderWidth(1.0)
      .borderColor('#43C494')
      .padding({
        left: 7,
        right: 7,
      })
      .borderRadius(12)
      .height(22)
      .width('auto')
      .onClick(() => {
        ClickUtil.throttle(() => {
          this.fileImageList = []
          this.fileVideoList = []
          onEvent()
        })
      })
  }
}

@Builder
function showC(frame:ViewFrame) {
  PageCutOut({
    frame: frame, onClickEvent: () => {
      // this.showCanvas = false
    }
  })
}

export function showCanvas(textKey:string,context:UIContext) {
  // 绑定指定组件，返回对应的监听句柄
  let observer = context.getUIInspector().createComponentObserver(textKey);
  // 通过句柄向对应的查询条件注册回调，当组件布局完成时会触发该回调。type:必须填写字符串'layout'或'draw'。layout:组件布局完成。draw:组件绘制送显完成
  observer.on('layout', () => {
    let node = context.getComponentUtils().getRectangleById(textKey);
    if (node) {
      const viewFrame = new ViewFrame()

      viewFrame.x = node.localOffset.x/3.0
      viewFrame.y = node.localOffset.y/3.0
      viewFrame.width = node.size.width/3.0
      viewFrame.height = node.size.height/3.0
      SmartDialog.show({
        builder: showC,
        animationTime: 0,
        builderArgs:viewFrame,
        maskColor:Color.Transparent
      })
    }
    // 通过句柄向对应的查询条件取消注册回调，当组件布局完成时不再触发指定的回调
    observer.off('layout');
  })

}