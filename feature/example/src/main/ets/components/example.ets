import { Route } from "@hzw/zrouter";
import { RouterConstants } from "helper";
import { LengthMetrics } from "@kit.ArkUI";
import { ExampleViewModel } from "../vm/ExampleViewModel";
import { ArrayUtil, ClickUtil } from "@pura/harmony-utils";
import { ImageView, VideoView } from "common_widget";


@Route({ name: RouterConstants.example })
@ComponentV2
export struct ExamplePage {
  private viewModel: ExampleViewModel = new ExampleViewModel()
  @Local private fileImageList: string[] = []
  @Local private fileVideoList: string[] = []

  build() {
    NavDestination() {
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


    }.title('测试页面')
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
        ClickUtil.throttle(()=> {
          this.fileImageList = []
          this.fileVideoList = []
          onEvent()
        })
      })
  }
}