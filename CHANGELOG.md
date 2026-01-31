# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0] - 2026-01-31

### Added
- **極簡導航中心 (HomePage)**：導入全新導航結構，提供「五十音」、「單字」與「測驗」三大入口，落實「禪意」留白美學。
- **測驗設定整頁化**：將測驗範圍選擇由彈窗轉型為全螢幕頁面 (`ExamSetupPage`)，解決資訊擁擠問題並優化操作流。
- **單字擴展性預留**：重構測驗設定架構，模組化支援未來「單字測驗」功能。

### Changed
- **路由架構升級**：更新 `GoRouter` 配置，將 `/` 設為首頁中心，導航更具層次。
- **視覺重心調整**：五十音頁面標題字重提升（w300），並將小標題在地化為日文（かな、ことば、しけん）。

### Fixed
- **導航冗餘移除**：移除五十音頁面的 FloatingActionButton 與實體返回按鈕，完全依賴系統原生手勢，維持極致視覺純淨。

## [0.2.0] - 2026-01-31

### Added
- **教學註解與類別細分**：將特殊假名細分為「促音」、「長音」與「外來語組合」，並在分類標題下加入直覺的中文教學註解（如：長音 - 「拉長前一個音的發音」）。
- **Edge-to-Edge 沉浸式體驗**：重構 `KanaListPage` 佈局與 `ZenChipSelector` 內距邏輯，實現全寬流暢滾動（無邊距剪裁）。
- **UI 易讀性優化**：全面提升分類標題與說明的字體大小與字重，強化視覺層次感。

### Changed
- **UI/UX 佈局調整**：修復 `KanaListPage` 與 `ExamPage` 的 `SafeArea` 與呼吸感問題，解決標題與系統狀態列過於緊密的問題。
- **去投影化規範修復**：符合「日日」設計系統規範，移除 `ZenToast` 等組件中的硬編碼陰影與 Elevation。
- **資料模型擴充**：`KanaRepository` 支援更多現代片假名組合，並同步更新相關單元測試。

### Fixed
- **選取器剪裁問題**：修復 `ZenChipSelector` 在滾動時因頁面 Padding 導致的視覺截斷現象。

## [0.1.3] - 2026-01-31

### Changed
- 內部代碼優化與小規模 UI 修正（版本同步）。

## [0.1.2] - 2026-01-31

### Added
- **驗收出題優化**：實作智能干擾項 (Intelligent Distractors) 演算法，優先選取形似假名作為選項。
- **優雅的失敗 (Graceful Failure)**：測驗答錯時即時顯示假名助記故事，將挫折轉化為學習。
- **主題擴充**：`ZenTheme` 新增 `accent` 縹色，用於學習導引與重點提示。

### Changed
- **介面穩定性**：優化 `ExamPage` 佈局，解決小螢幕與長文字溢出問題。
- **測驗流暢度**：修正測驗動畫導致的效能與測試同步問題。

## [0.1.1] - 2026-01-31

### Added
- 實作「假名詳細資訊面板」(KanaDetailSheet)，支援助記小撇步與相似字對比
- 補完平假名 46 個基礎假名的「助記小撇步 (Mnemonics)」內容
- 新增五十音列表分類篩選器 (Category Selector)，支援清音、濁音、半濁音與拗音切換

### Changed
- 擴充 `Kana` 資料模型，支援 `mnemonic` 與 `similarKanaIds` 欄位
- 優化平假名列表頁面，點擊卡片改為優雅彈出詳細資訊，而非僅發音

### Verified
- 已補齊相關單元測試與 Widget 驗證測試，全系統測試通過率 100%

## [0.1.0] - 2026-01-31

### Added
- 補完完整五十音矩陣 (5x10)，包含や行與わ行的重複音填補
- 新增濁音、半濁音與拗音系列（共新增 50+ 個平/片假名）
- 實現假名全方位分類顯示：清音、鼻音、濁音、半濁音、拗音

### Changed
- 五十音列表 UI 重構：新增輕盈分類標題與 32px 禪意視覺間距
- 視覺調淡重複音：針對や行與わ行的重複位置進行「淡墨」處理 (20% 透明度)
- 測驗範圍優化：支援鼻音與拗音獨立選取，並過濾重複音題目與選項

## [0.0.10] - 2026-01-31

### Added
- 新增 `ZenToast` 元件：日系禪風錯誤提示 UI
- 新增 `KanaAudioController`：統一管理 TTS 播放狀態
- 新增 `TtsException`：自定義 TTS 錯誤類型

### Fixed
- 修復 TTS 初始化競態條件 (Race Condition)，解決發音可能變回英文的問題
- 改善 TTS 錯誤處理機制，不再靜默失敗

## [0.0.9] - 2026-01-30

### Added
- 實作 五十音 TTS 發音功能
- 新增 `TtsService` 處理語音合成邏輯
- 整合 `flutter_tts` 套件
- 點擊平假名卡片可發音
