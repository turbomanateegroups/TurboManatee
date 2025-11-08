# Turbo Manatee (TUMA) — 官方智能合約倉庫

本資料夾為 **Turbo Manatee (TUMA)** 在 **BNB Smart Chain (BEP20)** 主網上部署的  
**官方智能合約原始碼與所有權證明文件**。

---

## ⚙️ 合約基本資訊

| 欄位 | 說明 |
|------|------|
| **代幣名稱** | Turbo Manatee |
| **代號** | TUMA |
| **標準協議** | BEP20 / ERC20 相容 |
| **總供應量** | 100,000,000 TUMA（固定總量） |
| **小數位數** | 18 |
| **合約地址** | [`0x52d105dF96887f1B69EF93b55A53A12597485D79`](https://bscscan.com/token/0x52d105dF96887f1B69EF93b55A53A12597485D79) |
| **編譯器版本** | Solidity 0.8.24（啟用最佳化，200 次運行） |
| **授權條款** | MIT License |
| **鏈別** | BNB Smart Chain（主網 ID 56） |
| **驗證狀態** | ✅ 已通過 BscScan 驗證 |

---

## 🧩 合約檔案

| 檔案名稱 | 用途 |
|-----------|------|
| [`Turbo Manatee.sol`](./Turbo%20Manatee.sol) | 官方合約原始碼（已驗證版本） |
| [`Proof_of_Ownership_TurboManatee.pdf`](./Proof_of_Ownership_TurboManatee.pdf) | 合約所有權正式證明文件 |

---

## 🔍 功能特色

- 🪙 **固定總供應量**：100,000,000 TUMA，一次性鑄造至部署者錢包。  
- 💸 **零手續費設計**：不含稅收、反射機制或任何轉帳費用。  
- 🛑 **可暫停交易機制**：在緊急情況下可暫時凍結轉帳。  
- ⚫ **黑名單模組（可永久停用）**：僅用於合規防護，可永久關閉以確保去中心化。  
- 🎁 **批量空投功能**：支援同時分發給多個錢包地址。  
- 💾 **救援函式**：允許取回誤轉入的 BNB 或 ERC20 代幣。  
- 🔐 **所有權轉移／多簽化設計**：可轉移給多簽錢包或永久放棄所有權（`renounceOwnership()`）。  

---

## 🧱 部署資訊

| 項目 | 詳細說明 |
|------|----------|
| **部署者地址（Owner）** | 初始持有 100% 代幣總量（發行時即鑄造） |
| **所有權狀態** | 尚未放棄（計畫轉移至多簽錢包） |
| **交易狀態** | 正常啟用中（未暫停） |
| **流動池計畫** | PancakeSwap v3：10,000,000 TUMA + 5,000 USDT |
| **鎖倉規劃** | 團隊持幣（20%）預計鎖倉 6–12 個月 |
| **空投推廣** | 25% 配發於社群活動與推廣計畫 |

---

## 🧾 合規與透明化聲明

- 智能合約已於 **[BscScan 官方驗證頁面](https://bscscan.com/token/0x52d105dF96887f1B69EF93b55A53A12597485D79)** 公開驗證。  
- 原始碼遵循 **MIT 開源授權**，所有內容完全透明。  
- 本資料夾包含官方簽署之 **合約所有權證明文件 (Proof of Ownership)**。  
- 未來版本（TurboManatee V3）將移除可控功能（黑名單、暫停），以提升完全去中心化程度。  

---

## 📚 相關儲存庫

| 儲存庫名稱 | 用途說明 |
|-------------|----------|
| [TurboManatee_docs](https://github.com/turbomanateegroups/TurboManatee_docs) | 官方白皮書、代幣分配與證明文件 |
| [tuma-brand-assets](https://github.com/turbomanateegroups/tuma-brand-assets) | 品牌標誌與視覺素材 |
| [TUMA-TrustWallet-Assets](https://github.com/turbomanateegroups/TUMA-TrustWallet-Assets) | Trust Wallet 提交資產資料夾 |

---

## 授權條款

本合約原始碼及所有文件依據 [MIT License](https://opensource.org/licenses/MIT) 開放授權。  
© 2025 Turbo Manatee Team. All rights reserved.

---

## 📧 聯絡方式

**Turbo Manatee 官方團隊**  
🌐 [官方網站](https://turbomanatee.com)  
🐦 [X（Twitter）](https://twitter.com/Turbo_Manatee)  
💬 [Telegram](https://t.me/Turbo_Manatee)  
📩 turbomanateegroups@gmail.com
