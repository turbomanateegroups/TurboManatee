# Turbo Manatee (TUMA) — Official Smart Contract Repository

This repository contains the **verified smart contract source code** and official **Proof of Ownership** for the **Turbo Manatee (TUMA)** token on the **BNB Smart Chain (BEP20)**.

---

## ⚙️ Contract Overview

| Field | Detail |
|-------|--------|
| **Token Name** | Turbo Manatee |
| **Symbol** | TUMA |
| **Type** | BEP20 / ERC20 Compatible |
| **Total Supply** | 100,000,000 TUMA (fixed) |
| **Decimals** | 18 |
| **Contract Address** | [`0x52d105dF96887f1B69EF93b55A53A12597485D79`](https://bscscan.com/token/0x52d105dF96887f1B69EF93b55A53A12597485D79) |
| **Compiler** | Solidity 0.8.24 (Optimizer enabled, 200 runs) |
| **License** | MIT |
| **Network** | BNB Smart Chain (Mainnet - Chain ID 56) |
| **Verification** | ✅ Verified on BscScan |

---

## 🔍 Source File

| File | Description |
|------|--------------|
| [`Turbo Manatee.sol`](./Turbo%20Manatee.sol) | Official verified contract source code |
| [`Proof_of_Ownership_TurboManatee.pdf`](./Proof_of_Ownership_TurboManatee.pdf) | Signed letter verifying ownership of the deployed contract |

---

## 🧩 Key Features

- **Fixed Total Supply:** 100,000,000 TUMA minted once to the deployer wallet upon deployment.  
- **No Tax, No Reflection:** 1:1 transfer logic with no fee mechanics.  
- **Pause/Unpause Control:** Optional transfer pausing for emergency situations.  
- **Blacklist Module (optional):** Can restrict malicious addresses; includes a permanent disable switch for transparency.  
- **Batch Airdrop:** Efficient token distribution to multiple addresses in one transaction.  
- **Rescue Functions:** Recover ERC20 tokens or BNB accidentally sent to the contract.  
- **Ownership Transfer / Multi-Sig Ready:** Owner can transfer contract ownership to a multi-signature wallet or renounce ownership permanently.  

---

## 🧱 Deployment Information

| Parameter | Detail |
|------------|--------|
| **Deployer Address (Owner)** | The wallet that deployed and initially received total supply. |
| **Ownership Status** | Active (not yet renounced — planned transfer to multi-sig) |
| **Paused State** | Unpaused (tokens are transferable) |
| **Liquidity Pool Plan** | Initial LP: 10,000,000 TUMA + 5,000 USDT on PancakeSwap v3 |
| **Lockup Plan** | Team wallet locked 6–12 months (20% of supply) |
| **Airdrop Plan** | 25% reserved for community incentives and promotions |

---

## 🧾 Compliance & Transparency

- Contract verified publicly on **[BscScan](https://bscscan.com/token/0x52d105dF96887f1B69EF93b55A53A12597485D79)**.  
- Source code follows **MIT open-source license** for transparency.  
- Official Proof of Ownership file is included (`Proof_of_Ownership_TurboManatee.pdf`).  
- Future versions (TurboManateeV3) will permanently disable the blacklist and pausable functions for maximum decentralization.  

---

## 📚 Related Repositories

| Repository | Purpose |
|-------------|----------|
| [TurboManatee_docs](https://github.com/turbomanateegroups/TurboManatee_docs) | Official PDFs & whitepapers |
| [tuma-brand-assets](https://github.com/turbomanateegroups/tuma-brand-assets) | Logos and visual branding |
| [TUMA-TrustWallet-Assets](https://github.com/turbomanateegroups/TUMA-TrustWallet-Assets) | TrustWallet listing submission |

---

##  License

This repository and the source code are released under the [MIT License](https://opensource.org/licenses/MIT).  
Copyright © 2025 Turbo Manatee Team.  

---

## 📧 Contact

**Turbo Manatee Team**  
🌐 [Website](https://turbomanatee.com)  
🐦 [X (Twitter)](https://twitter.com/Turbo_Manatee)  
💬 [Telegram](https://t.me/Turbo_Manatee)  
📩 turbomanateegroups@gmail.com
