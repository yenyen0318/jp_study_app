---
name: ui_design_system
description: "App UI/UX Design System & Guidelines"
---

# UI/UX 核心規範

這份規範將「日系禪風極簡」從抽象的感覺轉化為具體的開發指標。核心精神是**「呼吸感」、「穩定感」與「無干擾」**。

## 1. 視覺風格與質感 (Visual Style & Texture)

*   **去投影化**：禁止使用 `BoxShadow` 或 `Elevation`。層級感應透過色彩明度與邊框來表現。
*   **極細邊框**：使用 `0.5dp` 的細線條（Hairline Border）作為容器邊界，增加精緻感。
*   **圓角規範**：使用 `8dp` (Small) 或 `12dp` (Medium) 的適度圓角，避免 M3 預設的過度圓潤感。

## 2. 完整語意化色彩系統 (Semantic Colors) - 含深色模式

為了確保開發時不混淆，我們透過 **`ThemeExtension`** 定義兩套對應的色票。深色模式不再只是純黑，而是深炭色，以保持溫潤感。

| 語意變數 (Semantic Token) | 亮色模式 (Light Mode) | 深色模式 (Dark Mode) | 用途建議 |
| --- | --- | --- | --- |
| `color.bg.primary` | **#F5F5F0** (和紙色) | **#121212** (深炭) | 全域背景 |
| `color.bg.surface` | **#FFFFFF** | **#1E1E1E** | 卡片、容器 |
| `color.text.primary` | **#2B2B2B** (墨色) | **#E1E1E1** (銀白) | 標題、主要內文 |
| `color.text.secondary` | **#757575** | **#A0A0A0** | 說明、次要資訊 |
| `color.success` | **#92B5A9** (青磁) | **#4D6B61** (暗青) | 正確、完成狀態 |
| `color.error` | **#D36151** (朱紅) | **#964236** (深朱) | 錯誤、警示狀態 |
| `color.border.subtle` | **#E0E0E0** | **#333333** | 極細邊框與分割線 |

## 3. 間距與尺寸系統 (Spacing System)

遵循 **8pt 網格系統**，確保佈局具備隱形的數學秩序。

*   **頁面邊距 (Screen Edge)**：固定為 **24dp**。這多出的空間是「呼吸感」的來源。
*   **元件垂直間距**：段落間使用 **24dp** 或 **32dp**，讓資訊不擁擠。
*   **最小觸控尺寸**：所有可點擊元件必須至少為 **48x48dp**，確保操作從容。

## 4. 元件規範 (Component Specifications)

為了維持「非工程師感」，元件設計應像「紙張上的印刷」一樣簡約。

### **按鈕 (Buttons)**
*   **主要按鈕 (Primary)**：
    *   樣式：**外框 (Outline)** 搭配 **0.8dp** 極細邊框，或**淡色填充 (Soft Fill)**。
    *   內距：垂直 12dp，水平 24dp。
    *   特徵：不使用陰影，僅透過文字粗細與對比色來強調。
*   **次要按鈕 (Secondary)**：
    *   樣式：**純文字 (Plain Text)** 搭配下底線或稍大的間距。
    *   特徵：完全融入背景，點擊時僅有輕微透明度變化與觸覺回饋。

### **輸入框 (Text Fields)**
*   **樣式**：**下底線式 (Underline)**。
*   **細節**：預設僅顯示一條極細的 `color.border.subtle` 底線。當焦點進入 (Focus) 時，底線稍微加粗或轉為 `color.text.primary`。
*   **呼吸感**：輸入框上方必須預留至少 8dp 的標籤空間，確保排版不擁擠。

## 5. 字體實作與「無圖示」原則 (Typography & Icon-less)

### **字體實作指引**
*   **套件**：強制使用 **`google_fonts`** 套件，以動態載入減少初始包體大小。
*   **設定**：
    *   繁體中文：使用 `GoogleFonts.notoSansTc()`。
    *   日文：使用 `GoogleFonts.notoSansJp()`。
*   **回退機制**：必須設定 `fontFamilyFallback`，確保日文漢字與繁體中文在同一行時不會出現字重不一的情況。

### **無圖示原則 (Icon-less Challenge)**
*   **核心規則**：盡量不使用 Icon。
*   **替代方案**：
    *   **導航**：使用「純文字標籤」。例如：不再使用 🏠 圖示，而是直接寫「日日」或「學習」。
    *   **狀態**：使用「色彩」或「符號文字」。例如：正確時使用 `color.success` 標記文字，而非打勾。
    *   **返回**：使用「←」符號文字或「返回」二字。
*   **例外**：僅在無法透過文字精確傳達，且會嚴重影響 UX 時，才允許使用極少量的自定義線條路徑（直接用 `CustomPainter` 繪製）。

## 6. 微互動與狀態回饋 (Micro-interactions)

讓 App 的「手感」像真實物體一樣溫潤。

*   **觸覺回饋 (Haptics)**：
    *   點擊按鈕、切換選項或完成測驗時，調用 `HapticFeedback.selectionClick()`。
*   **過渡動效**：
    *   全局頁面切換強制使用 **淡入淡出 (Fade Transition)**。禁止使用生硬的滑動，以維持視覺平靜。
*   **狀態色彩規則**：
    *   正確時使用「青磁色」外框，錯誤時使用「朱紅色」震動提示。

## 7. 加載與空白狀態 (Loading & Empty States)

避免出現「開發中」的工程師感。

*   **骨架屏 (Zen Skeleton)**：
    *   資料加載時顯示帶有微弱「呼吸效果」的漸變區塊，而非旋轉進度圈。
*   **空白狀態**：
    *   使用**繁體中文**鼓勵語句，如需圖像則僅使用簡單的幾何線條或文字排版，避免使用任何通用圖示庫 (Includes Lucide)。例如：「準備好開始日日的練習了嗎？」

## 8. 響應式與平板適配 (Responsive & Tablet)

在平板等大螢幕設備上，重點在於「避免視線過度發散」，維持專注的閱讀體驗。

*   **最大內容寬度 (Max Content Width)**：
    *   主要閱讀與操作區塊（如單字卡、測驗區）應限制最大寬度為 **600dp**。
    *   使用 `Center` 搭配 `ConstrainedBox` 讓內容居中，兩側留白作為「呼吸空間」。
*   **分欄佈局 (Multi-column)**：
    *   在寬度足夠時 (> 900dp)，可採用 **Master-Detail (左列表、右詳細)** 佈局，但右側詳細頁仍需遵循最大寬度限制。
*   **邊距加倍**：
    *   平板的全局邊距 (Screen Edge) 應從 `24dp` 提升至 **48dp** 或更寬，確保握持時拇指不會遮擋內容。

## 9. 邊界與安全區域 (Boundaries & Safe Area)

確保內容在任何裝置上都不會被遮擋，同時維持視覺延伸感。

*   **沉浸式背景 (Immersive Background)**：
    *   `Scaffold` 的背景色 (`color.bg.primary`) 必須延伸至 Status Bar 與 Bottom Navigation Bar 區域。**禁止**出現黑邊。
    *   實作上，`SystemChrome` 需設定為透明 (`transparent`)。
*   **安全區域 (Safe Area)**：
    *   **頂部 (Top)**：除了全螢幕背景圖外，所有內容必須包裹在 `SafeArea` (top: true) 內，避免與瀏海 (Notch) 重疊。
    *   **底部 (Bottom)**：
        *   捲動列表 (ScrollView) 底部必須預留 `padding.bottom` + `24dp`，避免內容被 Home Indicator 遮擋或觸控衝突。
        *   固定底部按鈕 (Sticky Button) 必須包裹在 `SafeArea` (bottom: true) 內，並額外增加 `16dp` 垂直間距。
*   **邊界避讓 (Edge Constraints)**：
    *   在大曲面螢幕手機上，關鍵操作元件（如按鈕）應距離實體邊緣至少 `16dp`，避免誤觸。
