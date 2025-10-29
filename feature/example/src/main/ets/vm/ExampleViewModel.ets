import { PhotoHelper } from "@pura/picker_utils";
import { photoAccessHelper } from "@kit.MediaLibraryKit";
import { ArrayUtil, FileUtil } from "@pura/harmony-utils";

@ObservedV2
export class ExampleViewModel {

  async selected():Promise<string[]> {
     const result = await PhotoHelper.select()
    return result.photoUris
  }

  //相册选择图片（单选）
  async selectSingleImage():Promise<string[]>{
    let options: photoAccessHelper.PhotoSelectOptions = {
      MIMEType: photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber: 1,
      isOriginalSupported: true,
      isPreviewForSingleSelectionSupported: true //单选模式下是否需要进大图预览
    }

    const uri = await PhotoHelper.selectEasy(options);
    return uri
  }

  //相册选择视频（单选）
  async selectSingleVideo():Promise<string[]>{
    let options: photoAccessHelper.PhotoSelectOptions = {
      MIMEType: photoAccessHelper.PhotoViewMIMETypes.VIDEO_TYPE,
      maxSelectNumber: 1,
      isOriginalSupported: true,
      isPreviewForSingleSelectionSupported: true //单选模式下是否需要进大图预览
    }
    const uri = await PhotoHelper.selectEasy(options);
    return uri
    // return uri
  }

}