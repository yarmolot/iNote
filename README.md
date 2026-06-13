# iNote — EncryptedNotes Smart Contract

> Your notes. Encrypted. On-chain. Provably private.

## Contract

| | |
|---|---|
| **Address** | `0xbA124dBF9024A8826BBc65AD86E807b1264b284D` |
| **Network** | Base Mainnet (Chain ID: 8453) |
| **Compiler** | solc 0.8.34 |
| **License** | MIT |

## Verification

| Platform | Status | Link |
|---|---|---|
| Sourcify | ✅ Exact Match | [View](https://repo.sourcify.dev/8453/0xbA124dBF9024A8826BBc65AD86E807b1264b284D) |
| BaseScan | ✅ Verified | [View](https://basescan.org/address/0xbA124dBF9024A8826BBc65AD86E807b1264b284D#code) |

## How it works

1. User connects wallet and signs a deterministic message
2. Key = SHA-256(wallet signature) — derived client-side, never leaves browser
3. Note is encrypted with AES-GCM in browser
4. Only ciphertext is sent on-chain via `createNote(bytes data)`
5. No admin, no upgrades, no ETH — pure data storage

## Security

- No owner / admin keys
- No ETH storage, no token transfers
- No external calls, no reentrancy risk
- Immutable — no proxy, no upgrades
- < 35 lines of Solidity

## App

🔗 [inote.cfd](https://inote.cfd)
