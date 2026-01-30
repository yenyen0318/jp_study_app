# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
