---
description: 標準化內容/文字修正流程 (Standard Content Fix Flow)
---

# 標準化內容/文字修正流程

此 Workflow 專門用於修正 App 中的日文數據錯誤、翻譯問題或文字排版異常。此流程比完整程式碼修復流程更輕量，但強調語言正確性的驗證。

## 1. 內容查核 (Content Verification)
> 參照 Skill: `japanese_core_generator_expert`

- [ ] **確認正確性**：
    - 若是日文內容錯誤：請查閱辭典或 JLPT 官方資料，確認正確的寫法、讀音與聲調。
    - 若是翻譯錯誤：確認繁體中文用詞是否符合台灣慣用語 (依據 Skill 規則 2)。
- [ ] **確認資料結構**：
    - 檢查對應的 JSON 或 Dart 資料檔，確認 `furigana`, `romaji`, `segments` 欄位是否需同步更新 (依據 Skill 規則 4)。

## 2. 實作修正 (Implementation)
> 參照 Skill: `japanese_core_generator_expert`

- [ ] **修改資料**：直接修改資料源文件 (JSON/Dart)。
- [ ] **檢查完整性**：若修改的是系列資料 (如 50 音)，確認是否影響相關聯的資料 (如：清音改了，濁音對應規則是否受影響？)。

## 3. 視覺驗收 (Visual Review)
> 參照 Skill: `ui_design_system`

- [ ] **渲染檢查**：
    - 啟動 App 至對應頁面。
    - 確認 `Ruby Text` (振假名) 渲染是否破版。
    - 確認字體 `height: 1.6` 設定是否讓文字垂直居中且不被裁切。

## 4. 提交與更新 (Commit & Update)
> 參照 Skill: `git_automation_expert`

- [ ] **Git 提交**：
    - 使用 `fix(content): message` 或 `docs(content): message` 格式。
    - 例如：`fix(content): correct typo in hiragana te (#124)`。
- [ ] **更新快取**：若 App 有本地數據庫或快取機制，確認是否需要清除重建。
