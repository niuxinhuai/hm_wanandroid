import { display } from '@kit.ArkUI';
import { SmartDialog } from 'ohos_smart_dialog';

/*
 * 页面镂空效果
 * */
@ComponentV2
export struct PageCutOut {

  @BuilderParam @Require frame:ViewFrame
  @Event onClickEvent: () => void = () => {}
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    if (this.frame.x != 0) {
      // Stack(){
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .onReady(() => {
            // 设置全局合成操作模式为XOR
            this.context.globalCompositeOperation = 'xor';
            this.context.beginPath();
            // 计算屏幕宽度和高度并绘制矩形
            this.context.rect(0, 0, this.getUIContext().px2vp(display.getDefaultDisplaySync().width),
              this.getUIContext().px2vp(display.getDefaultDisplaySync().height));
            this.context.closePath();
            this.context.fillStyle = '#000000';
            this.context.fill();
            this.context.beginPath();
            this.context.rect(this.frame.x,this.frame.y,this.frame.width,this.frame.height);
            this.context.closePath();
            this.context.fillStyle = '#000000';
            this.context.fill();
          }).expandSafeArea([SafeAreaType.CUTOUT], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])//
          .opacity(0.6).onClick(()=> {
          this.onClickEvent()
          SmartDialog.dismiss()
        });
      // }
    }

  }
}

export class ViewFrame {
  x:number = 0
  y:number = 0
  width:number = 0
  height:number = 0
}