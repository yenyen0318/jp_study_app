---
name: Git_Automation_Expert
description: 版本管理與 GitHub 同步專家。負責在測試通過後執行標準化提交、撰寫 Changelog 並同步至雲端。
---

# Git 自動化與版本控制規範

本規範定義了專案的 Git 操作流程、Commit 訊息標準以及自動化同步機制，確保代碼庫的整潔與可追溯性。

## 1. 執行門檻 (Gatekeeper)

*   **嚴格限制**：僅在 `testing_qa_specialist` 回報 100% 測試通過且無任何錯誤時，才能啟動 Git 操作。
*   **狀態檢查**：執行前必須確認當前 Git 分支狀態為 clean，若有未預期的變動需先向使用者報告。
*   **使用者確認 (User Approval)**：
    *   **禁止自動 Commit**：在執行 `git commit` 前，必須先透過 `notify_user` 或對話詢問使用者：「是否確認提交變更？」。
    *   **例外**：僅在使用者明確授權「自動修復並提交」的流程中（如 CI 腳本修復），才可跳過此步驟。

## 2. 提交規範 (Conventional Commits)

*   **格式**：採用 `<type>(<scope>): <subject>` 規範。
*   **語言**：Subject 使用繁體中文簡述；Body 部分需條列式說明修改的邏輯細節。
*   **類型映射**：
    *   `feat`: 新功能 (如：實作 50 音列表)
    *   `fix`: 修補 Bug (如：修正日文排序邏輯)
    *   `docs`: 僅文件異動
    *   `style`: 視覺調整 (不影響代碼邏輯)
    *   `refactor`: 代碼重構
*   **範例**：`feat(kana): 實作平假名 50 音資料模型與語意化配色`

## 3. 自動化同步流程 (Sync Workflow)

*   **操作順序**：自動執行 `git add .` -> `git commit -m "..."` -> `git push origin main`。
*   **衝突處理**：若發生 Push 失敗 (如遠端已有更新)，必須暫停並提示使用者手動處理，禁止使用 `--force`。

## 4. 變更紀錄與摘要 (Changelog & Summary)

*   **異動摘要**：同步成功後，需產出一段繁體中文摘要，列出本次 Commit 的重要技術點。
*   **發布準備**：若使用者提及「準備發布」，需先更新 `CHANGELOG.md` (依據 Keep a Changelog 格式)，將 `Unreleased` 區塊轉為新版本號。

## 5. 提示詞連動 (Prompt Linkage)

*   **上下文關聯**：在 Commit Message 中，應主動提及受影響的 UI 元件或 Provider，方便未來回溯。

## 7. 版本迭代規範 (Versioning Policy)

本規範確保語意化版本 (SemVer) 與 Google Play / Apple App Store 的發布需求一致。

### 7.1 版本格式：`X.Y.Z+B`
*   **X (Major)**: 僅在發生不相容的重大變更或品牌重塑時增加。
*   **Y (Minor)**: 新功能增加、大規模內容擴充或顯著 UI 優化（如假名細分）。每當 Y 增加，Z 歸零。
*   **Z (Patch)**: Bug Fix、文字修正、小規模樣式調整。
*   **+B (Build Number)**: 每次提交後的唯一序號。

### 7.2 跨平台合規規則
*   **iOS (CFBundleVersion)**: 在同一個 X.Y.Z 內，每上傳一次 B 必須遞增。
*   **Android (versionCode)**: B 必須全域單調遞增，不可重複。
*   **Flutter 同步**: 在 `pubspec.yaml` 更新 `1.2.3+10` 後，系統將自動映射至雙平台。

### 7.3 執行流程
1.  **決策**: 依改動性質決定 X, Y, Z 的異動。
2.  **遞增**: 每次發布標籤前，將 `+B` **遞增 1**。
3.  **記錄**: 同步更新 `CHANGELOG.md` 描述變更項。
4.  **標籤**: 建立 `vX.Y.Z` 標籤並推送，觸發發布流程。
