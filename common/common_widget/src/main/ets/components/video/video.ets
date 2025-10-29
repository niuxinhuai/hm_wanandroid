@ComponentV2
export struct VideoView {
  @BuilderParam @Require url: string
  // 设置视频播放倍速
  @BuilderParam curRate?: PlaybackSpeed
  private controller: VideoController = new VideoController()


  build() {
    Column() {
      Video({ src: this.url, controller: this.controller ,currentProgressRate:this.curRate ?? PlaybackSpeed.Speed_Forward_1_00_X})
      .muted(false) // 设置是否静音
      .controls(true) // 设置是否显示默认控制条
      .autoPlay(true) // 设置是否自动播放
      .loop(true) // 设置是否循环播放
      .objectFit(ImageFit.Contain) // 设置视频填充模式
    }
  }
}