# Rime Teochew（潮州話拍字法）

![拍字效果](assets/u-oinn-lai-chiah-te.GIF)

```
【漢字】有閒來食茶
【PUJ】Ũ-ôiⁿ lâi chia̍h-tê
【拍字】uoinn lai chiahte
```

## 簡介

本潮州話拍字法方案基於 [Rime 輸入法引擎](https://rime.im/)，支持白話字（PUJ）佮潮州話拼音（DP），可在全平台（Windows、macOS、Linux、iOS、Android）上使用。

## 特色

- **雙羅馬字系統**：支持 PUJ（白話字）佮 DP（潮州話拼音）
- **漢字輸入**：支持純漢字佮羅馬字混合輸入
- **自動標調**：使用數字聲調碼，自動轉換為正確聲調符號
- **Lua 過濾**：自定義 Lua 腳本實現精確音節過濾佮轉換
- **反查功能**：支持普通話拼音反查潮州音佮潮普對照；支持英文反查潮州話

## 安裝

### 電腦端

#### Windows（小狼毫）

```bash
# 下載潮州話拍字法方案
curl -LO https://github.com/hokkien-writing/rime-teochew/archive/master.zip
# 解壓並複製到配置目錄
unzip master.zip
cp -f rime-teochew-master/*.yaml %APPDATA%\Rime
cp -f rime-teochew-master/*.lua %APPDATA%\Rime
```

然後點擊 `開始菜單` > `【小狼毫】重新部署`。

#### macOS（鼠鬚管）

```bash
# 下載潮州話拍字法方案
curl -LO https://github.com/hokkien-writing/rime-teochew/archive/master.zip
# 解壓並複製到配置目錄
unzip master.zip
cp -f rime-teochew-master/*.yaml ~/Library/Rime
cp -f rime-teochew-master/*.lua ~/Library/Rime
# 重新部署
/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --reload
```

#### Linux

參考 [RIME 官網](https://rime.im/download/) 安裝對應前端（IBus-Rime 或 Fcitx-Rime），然後將文件複製到 `~/.config/ibus/rime` 或 `~/.local/share/fcitx5/rime`。

### 手機端

- **iOS**：推薦使用「[倉輸入法](https://apps.apple.com/cn/app/仓输入法/id6446617683)」
- **Android**：推薦使用「[同文輸入法](https://f-droid.org/packages/com.osfans.trime/)」

## 使用

### 切換輸入方案

按 `F4` 或 `Ctrl+`` 選擇以下方案：

- `teochew_puj`：白話字輸入
- `teochew_dp`：潮州話拼音輸入
- `teochew`：漢字佮羅馬字混合輸入

### 輸入規則

1. **聲調免拍**：無需輸入聲調數字
   - `lai` → 來

2. **鼻化韻**：使用 `nn` 表示鼻化
   - `ainn` → aiⁿ

3. **特殊韻母**：使用 `ur` 表示 ṳ
   - `lur` → lṳ́（汝）

4. **連字符**：無需輸入連字符
   - `chiahte` → chia̍h-tê（食茶）

5. **簡拼支持**：支持首字母簡拼
   - `lh` → 汝好

### 反查功能

- **潮州音查詢**：按 `` ` `` 鍵，輸入普通話拼音可查潮州音
- **普通話對照查詢**：按 `!` 鍵，輸入普通話拼音可查潮州話地道用詞
- **英文對照查詢**：按 `~` 鍵，輸入英文可查潮州話地道用詞

## 開發

如需重新構建字典或更新 Lua 過濾器：

```bash
./build.sh
```

此腳本會：
1. 清理 `build` 目錄
2. 獲取最新的 `rime-luna-pinyin` 依賴
3. 複製必要的 YAML 配置佮 Lua 腳本
4. 打包為 `teochew.zip`

## 文件結構

- `*.schema.yaml`：各輸入方案的配置定義
- `*.dict.yaml`：字典文件，包含音節佮漢字
- `lua/`：自定義 Lua 過濾器（[puj_filter.lua](lua/puj_filter.lua)、[dp_filter.lua](lua/dp_filter.lua)）
- [rime.lua](rime.lua)：Lua 主入口文件

## 參考

1. [簡明潮州白話字](https://hokkien-writing.github.io/simple_puj/)
3. [潮州白話字 - 維基百科](https://zh.wikipedia.org/wiki/%E6%BD%AE%E5%B7%9E%E7%99%BD%E8%A9%B1%E5%AD%97)
4. [Rime 輸入法引擎](https://rime.im/)
5. [潮語拼音輸入法](https://github.com/kahaani/dieghv)
6. [dataset](https://github.com/hokkien-writing/dataset)

## 貢獻

歡迎提交 Issue 佮 Pull Request 來改進本項目！

1. 拍字法配置方面，請修改 `*.schema.yaml` 文件
2. 用字方面，請前往 [dataset](https://github.com/hokkien-writing/dataset) 項目進行修改

## 授權

本項目採用開源授權。Rime 引擎相關組件請參考原始 Rime 授權。
