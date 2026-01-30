# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
- 實作 50 音 TTS 發音功能
- 新增 `TtsService` 處理語音合成邏輯
- 整合 `flutter_tts` 套件
- 點擊平假名卡片可發音
