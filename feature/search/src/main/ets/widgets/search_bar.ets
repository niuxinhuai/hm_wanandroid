import { RouterUtils } from "helper"
import { inputMethod } from '@kit.IMEKit'

@ComponentV2
export struct SearchBarWidget {

  private controller:TextInputController = new TextInputController()
  @Event onSubmit:(val:string)=>void
  @Event deleteHistory:()=>void

  build() {
    this.buildSearchBar()
  }

  @Builder
  buildSearchBar() {
    Row() {
      Text('返回')
        .fontSize(16)
        .fontColor(Color.Red)
        .fontWeight(FontWeight.Bold)
        .padding({
          left: 8,
          right: 8,
          top: 4,
          bottom: 4
        })
        .borderRadius(4)
        .backgroundColor('999999')
        .margin({ right: 12 })
        .onClick(() => {
          RouterUtils.pop()
        })
      TextInput({ placeholder: "开始搜索" ,controller:this.controller})
        .placeholderFont({ size: 13, weight: FontWeight.Normal })
        .placeholderColor('#666666')
        .height(33)
        .layoutWeight(1)
        .fontSize(16)
        .fontColor(Color.Black)
        .enterKeyType(EnterKeyType.Search)
        .onSubmit((enterKey: EnterKeyType, event: SubmitEvent) => {
          console.log('>>>>>>>输入的字符串' + event.text)
          this.onSubmit(event.text)

        })
        .defaultFocus(true).cancelButton({
        style:CancelButtonStyle.CONSTANT,
        icon:{
          size:22,
          color:Color.Blue,
          src:$r('app.media.startIcon')
        }
      })

      Text('历史记录')
        .fontSize(16)
        .fontColor(Color.Red)
        .fontWeight(FontWeight.Bold)
        .padding({
          left: 8,
          right: 8,
          top: 4,
          bottom: 4
        })
        .borderRadius(4)
        .backgroundColor('999999')
        .margin({ left: 12 })
        .onClick(() => {
          this.deleteHistory()
        })
    }.width('100%').padding({ left: 12, right: 12 })
  }
}