import { PreferencesUtil } from "@pura/harmony-utils";
import { preferences } from "@kit.ArkData";

export class SpHelper {
  /**
   * 检查缓存的Preferences实例中是否包含名为给定Key的存储键值对
   * @param key
   * @returns
   */
  static async hasKey(key: string): Promise<boolean> {
    return await PreferencesUtil.has(key)
  }

  static async putAsync(key: string, value: preferences.ValueType) {
    PreferencesUtil.putSync(key, value)
  }

  static async getAsync(key: string, defValue: preferences.ValueType): Promise<preferences.ValueType> {
    return PreferencesUtil.getSync(key, defValue)
  }

  /**
   * 获取string类型的缓存值
   * @param key
   * @returns
   */
  static getStringSync(key: string, defValue: string = ""): string {
    return PreferencesUtil.getSync(key, defValue) as string;
  }

  /**
   * 获取string类型的缓存值
   * @param key
   * @returns
   */
  static async getString(key: string, defValue: string = ""): Promise<string> {
    let value = await PreferencesUtil.get(key, defValue);
    return value as string;
  }


  /**
   * 获取number类型的缓存值
   * @param key
   * @returns
   */
  static getNumberSync(key: string, defValue: number = 0): number {
    return PreferencesUtil.getSync(key, defValue) as number;
  }

  /**
   * 获取number类型的缓存值
   * @param key
   * @returns
   */
  static async getNumber(key: string, defValue: number = 0): Promise<number> {
    let value = await PreferencesUtil.get(key, defValue);
    return value as number;
  }


  /**
   * 获取boolean类型的缓存值
   * @param key
   * @returns
   */
  static getBooleanSync(key: string, defValue: boolean = false): boolean {
    return PreferencesUtil.getSync(key, defValue) as boolean;
  }

  /**
   * 获取boolean类型的缓存值
   * @param key
   * @returns
   */
  static async getBoolean(key: string, defValue: boolean = false): Promise<boolean> {
    let value = await PreferencesUtil.get(key, defValue);
    return value as boolean;
  }


  /**
   * 删除缓存值
   * @param key
   * @param preferenceName
   * @returns
   */
  static deleteSync(key: string) {
    PreferencesUtil.deleteSync(key)
  }

  /**
   * 删除缓存值
   * @param key
   * @param preferenceName
   * @returns
   */
  static async delete(key: string): Promise<void> {
    PreferencesUtil.delete(key)
  }


  /**
   * 清空缓存的Preferences实例中的所有数据
   * @param preferenceName
   * @returns
   */
  static clearSync() {
    PreferencesUtil.clearSync()
  }

  /**
   * 清除缓存的Preferences实例中的所有数据
   * @param preferenceName
   * @returns
   */
  static async clear(): Promise<void> {
    PreferencesUtil.clear()
  }


  /**
   * 从缓存中移出指定的Preferences实例，若Preferences实例有对应的持久化文件，则同时删除其持久化文件。
   * @param context
   * @param name Preferences 实例的名称。
   */
  static async deletePreferences(context: Context, name: string): Promise<void> {
    return PreferencesUtil.deletePreferences(context, name)
  }
}