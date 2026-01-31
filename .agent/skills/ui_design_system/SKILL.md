---
name: ui_design_system
description: "App UI/UX Design System & Guidelines"
---

# UI/UX 核心規範

這份規範將「日系禪風極簡」從抽象的感覺轉化為具體的開發指標。核心精神是**「呼吸感」、「穩定感」與「無干擾」**。

## 1. 視覺風格與質感 (Visual Style & Texture)

*   **去投影化**：禁止使用 `BoxShadow` 或 `Elevation`。層級感應透過色彩明度與邊框來表現。
*   **極細邊框**：使用 `0.5dp` 的細線條（Hairline Border）作為容器邊界，增加精緻感。
*   **圓角規範 (ZenRadius)**：
    *   `sm`: 8.0 (小元件、Tag)
    *   `md`: 12.0 (卡片、Dialog)
    *   `lg`: 24.0 (大型 Container)
    *   `full`: 999.0 (圓形按鈕、Pill 樣式)
    *  **禁止直接寫死 12.0，應使用 `context.zen.radius.md`**。
*   **佈局規範 (ZenLayout)**：
    *   `maxContentWidth`: 600.0 (主要內容區塊最大寬度)
    *   `cardWidth`: 400.0 (標準卡片寬度)
    *  **調用方式**：`context.zen.layout.maxContentWidth`。

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

## 3. 間距系統 (ZenSpacing)

遵循 **8pt 網格系統** 的演進版，提供六個層級以確保佈局具備隱形的數學秩序。

| 代幣 (Token) | 數值 (Value) | 用途建議 |
| --- | --- | --- |
| `xs` | 4.0 | 元件內部的極微小調整 |
| `sm` | 8.0 | 按鈕內距、小型群組間距 |
| `md` | 16.0 | 卡片內距、標準元件間距 |
| `lg` | 24.0 | 頁面標準邊距 (Page Edge) |
| `xl` | 32.0 | 區塊間的大型留白 |
| `xxl` | 48.0 | 頁面底部或頂部的大型呼吸空間 |

*   **調用方式**：`context.zen.spacing.md`。
*   **禁止代幣運算**：禁止對設計標記進行數學運算（如 `spacing.xs / 2` 或 `spacing.md * 1.5`）。
    *   **原則**：應直接使用最接近的現有代幣。
    *   **例外**：若現有代幣確實無法滿足精確對齊需求，應優先考慮擴充 `ZenSpacing` 代幣系統，而非在 UI 代碼中進行運算。
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

### **字體層級系統 (Typography System)**

嚴格遵循 Material Design 3 的字體層級，但調整為適應日文/繁體中文的閱讀體驗。

| 層級 (Role) | 大小 (Size) | 字重 (Weight) | 用途建議 |
| --- | --- | --- | --- |
| **Display Medium** | 45sp | Regular | 極大標題，如首頁歡迎語 |
| **Headline Medium** | 28sp | Regular | 頁面主標題 |
| **Title Medium** | 16sp | Medium | 卡片標題、重要區塊標頭 |
| **Body Large** | 16sp | Regular | 主要閱讀內文 (單字卡) |
| **Body Medium** | 14sp | Regular | 一般說明文字 |
| **Label Large** | 14sp | Medium | 按鈕文字、Input 標籤 |
| **Label Medium** | 12sp | Medium | 輔助標籤、Tag |

*   **字重規範**：除非極度強調，否則**禁止使用 Bold (w700)**。請多使用 Medium (w500) 或 Regular (w400) 來維持畫面的「輕盈感」。
*   **行高 (Height)**：CJK 文字建議設定 `height: 1.5` 以確保舒適的閱讀呼吸感。

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
    *   **左右 (Horizontal)**：
        *   **預設開啟**：所有 `SafeArea`, `SliverSafeArea` 必須設定 `left: true` 與 `right: true`（預設值），以避開橫向模式的 Notch 或 Dynamic Island。
        *   **最小邊距 (Minimum Edge)**：
            *   即使在無 Notch 裝置上，**所有頁面內容**（背景色除外）左右兩側必須保留至少 **16dp** 的安全間距，避免內容貼齊螢幕邊緣。
            *   實作建議：使用 `SliverPadding(padding: EdgeInsets.symmetric(horizontal: max(safeArea, 16)))` 或確保 `Container` margin 至少為 16dp。
        *   **寬螢幕適配**：在 Tablet/Web 上，應結合「最大內容寬度 (600dp)」與 `Center` 佈局，而非單純依賴 Safe Area。
*   **邊界避讓 (Edge Constraints)**：
    *   在大曲面螢幕手機上，關鍵操作元件（如按鈕）應距離實體邊緣至少 `16dp`，避免誤觸。

## 10. 手勢與互動衝突處理 (Gesture Handling & Conflicts)

確保複雜互動（如繪圖）與捲動行為共存時的流暢體驗。

*   **衝突場景**：當繪圖板 (`Canvas`) 或其他需要連續手勢的元件嵌入於可捲動容器 (`ListView`, `SingleChildScrollView`) 時，垂直拖曳通常會被容器搶奪。
*   **解決方案**：
    *   **優先權宣告**：使用 `RawGestureDetector` 搭配自定義的 `GestureRecognizer`。
    *   **立即搶佔 (Eager Claim)**：實作 `ImmediatePanGestureRecognizer` (繼承自 `PanGestureRecognizer`)，並在 `addAllowedPointer` 時立即呼叫 `resolve(GestureDisposition.accepted)`，確保手勢不被父層攔截。
    *   **程式碼範例**：
        ```dart
        class _ImmediatePanGestureRecognizer extends PanGestureRecognizer {
          @override
          void addAllowedPointer(PointerDownEvent event) {
            super.addAllowedPointer(event);
            resolve(GestureDisposition.accepted);
          }
        }
        ```
*   **測試驗證**：必須撰寫 Widget Test 模擬巢狀結構，驗證拖曳是否正確觸發目標行為而非捲動。

## 11. 佈局與對齊原則 (Layout & Alignment Principles)

幾何中心不等於視覺中心。為了追求極致的穩定感，我們採用「光學對齊 (Optical Alignment)」。

*   **視覺中心優先 (Optical Centering)**：
    *   **場景**：當一個元件（如卡片）包含主要內容（如假名）與次要標註（如 Romaji）時。
    *   **問題**：若使用 `Column` 垂直排列，主要內容會被次要內容「頂」離中心點，導致視覺重心不穩。
    *   **強制規範**：必須使用 `Stack`。
        *   主要內容：使用 `Center` 確保絕對居中。
        *   次要內容：使用 `Positioned` 浮動於角落，完全脫離主要內容的佈局流。
*   **群組親密性 (Grouping Proximity)**：
    *   **原則**：標題與其所屬內容的間距，必須小於標題與上方內容的間距。
    *   **數值**：小標題 (Header) 與下方內容清單的間距固定為 **16dp**，以強化群組歸屬感。
*   **佈局穩定性 (Layout Stability)**：
    *   **原則**：在切換狀態或內容（如上一題/下一題、Loading/Loaded）時，容器的高度與位置必須保持絕對靜止。
    *   **反模式**：禁止讓主要內容的動態高度（如不同長度的文字、不同類型的元件）直接撐開父容器，這會導致介面在切換瞬間產生「視覺跳動 (Visual Jump)」，增加認知負荷。
    *   **解決方案**：為可變內容預留固定的「舞台空間 (Fixed Stage)」。
        *   範例：測驗區塊應設定 `SizedBox(height: 120)`，無論內部是 80dp 的圖示還是 100dp 的文字，外部框架都應保持不變。

## 12. 選擇元件規範 (Selection Components)

為了確保使用者能夠直覺地理解元件的選擇語意,我們建立了明確的單選/多選元件視覺規範。

### **單選元件 (Single Selection)**

單選元件提供兩種樣式,根據選項數量和使用場景選擇:

#### **Segmented Button 樣式**
*   **適用場景**: 2-4 個選項的單選,通常用於模式切換或類型切換
*   **視覺特徵**:
    *   整體外框包裹 (`borderRadius: 20`, `border: 0.5dp`)
    *   選項之間使用極細分隔線 (`0.5dp`)
    *   選中項填充 `theme.textPrimary` 背景色
    *   未選中項透明背景
    *   選中項文字使用 `theme.bgSurface` (反色)
    *   未選中項文字使用 `theme.textSecondary`
*   **動畫**: 200ms 的背景色過渡動畫
*   **觸覺回饋**: 選擇時調用 `HapticFeedback.selectionClick()`
*   **標準元件**: 使用 `ZenSegmentedButton`

#### **Chip 樣式**
*   **適用場景**: 3+ 個選項的單選,通常用於分類選擇或篩選
*   **視覺特徵**:
    *   獨立的 Chip 設計 (`borderRadius: 20`, `border: 0.5dp`)
    *   選中項填充 `theme.textPrimary` 背景色
    *   未選中項使用 `theme.bgSurface` 背景色
    *   選中項文字使用 `theme.bgPrimary` (反色)
    *   未選中項文字使用 `theme.textSecondary`
    *   Chip 間距為 `8dp`
*   **佈局**: 使用 `SingleChildScrollView` 支援水平捲動
*   **動畫**: 200ms 的背景色過渡動畫
*   **觸覺回饋**: 選擇時調用 `HapticFeedback.selectionClick()`
*   **標準元件**: 使用 `ZenChipSelector`

### **多選元件 (Multiple Selection)**

多選元件必須有明確的視覺提示,區別於單選元件:

*   **視覺特徵**:
    *   未選中項使用**虛線邊框** (`BorderSide(style: BorderStyle.dashed)`)
    *   選中項使用**實線邊框** + 淡色背景 (`theme.textPrimary.withValues(alpha: 0.05)`)
    *   邊框寬度為 `0.5dp`
    *   圓角為 `8dp`
*   **佈局**: 使用 `Wrap` 支援自動換行
*   **間距**: 元件間距為 `8dp`
*   **動畫**: 200ms 的邊框樣式與背景色過渡動畫
*   **觸覺回饋**: 選擇/取消選擇時調用 `HapticFeedback.selectionClick()`
*   **標準元件**: 使用 `ZenMultiSelector`

### **元件選擇決策樹**

```
選擇元件
├─ 單選?
│  ├─ 2-4 個選項? → ZenSegmentedButton
│  └─ 3+ 個選項? → ZenChipSelector
└─ 多選? → ZenMultiSelector
```

### **禁止事項**

*   **禁止混用**: 同一場景內的選擇元件應使用相同樣式
*   **禁止自訂**: 不得在頁面中自訂選擇元件,必須使用標準元件
*   **禁止誤導**: 多選元件不得使用與單選相同的視覺樣式

## 13. 架構與代碼規範 (Architecture & Code Standards)

為了維護設計系統的一致性與可維護性，嚴格禁止在 UI Widget 中硬編碼樣式邏輯。

*   **禁止硬編碼 (No Hardcoding)**：
    *   **禁止**：在 Widget 的 `build` 方法中直接寫死顏色值（如 `Color(0xFF...)`）或根據 `Brightness` 寫死判斷邏輯（如 `isDark ? 0.5 : 0.1`）。
    *   **強制**：所有顏色與樣式變數必須定義於 `ZenTheme` 中，並透過 `Theme.of(context).extension<ZenTheme>()` 存取。
*   **語意化優先**：
    *   若發現新的設計需求（例如「引導層顏色」），應先擴充 `ZenTheme` 屬性（如 `guideOverlay`），再於 Widget 中使用。
    *   以此確保修改主題時唯一來源 (Single Source of Truth) 的可靠性。
*   **禁止代碼內運算 (Zero-calculation Policy)**：
    *   **規則**：在 Widget 層級，禁止對 `ZenSpacing` 或 `ZenRadius` 進行任何形式的乘法、除法或加減運算。
    *   **理由**：任何「數值計算」都會破壞系統的穩定感與數學秩序，並增加日後維護時查找 Magic Numbers 的難度。
    *   **替代方案**：若遇到需要運算的情況（如 `xs / 2` 或 `xxl * 1.5`），**不應新增代幣或進行運算**，應直接取用最接近的現有代幣（如直接使用 `xs` 或 `xxl`）。
