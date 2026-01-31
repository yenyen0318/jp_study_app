# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
