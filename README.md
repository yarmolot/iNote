Вот обновлённый README.md с новыми данными контракта:

text
# iNote — EncryptedNotes Smart Contract

> Your notes. Encrypted. On-chain. Provably private.

## Contract

| | |
|---|---|
| **Name** | `EncryptedNotes` (envelope edition) |
| **Address** | `0x0266C94220E298dB7aD68A822a4458fdE055E783` |
| **Network** | Base Mainnet (Chain ID: 8453) |
| **Compiler** | solc 0.8.34 |
| **License** | MIT |

## Verification

| Platform | Status | Link |
|---|---|---|
| Sourcify | ✅ Exact Match | [View](https://repo.sourcify.dev/8453/0x0266C94220E298dB7aD68A822a4458fdE055E783) |
| BaseScan | ✅ Verified | [View](https://basescan.org/address/0x0266C94220E298dB7aD68A822a4458fdE055E783#code) |

## Deployment

| | |
|---|---|
| **Deployer** | `0xbe92b3B788F0e02dFFBaB9F8238cf96350694877` |
| **Transaction** | `0xf3f9e03e60d32dfd771f64417e921eea157a41e08e4e93b3c8dffa84bc167291` |
| **Block** | 47285169 |
| **Verified At** | 2026-06-13 14:08:19 UTC |

## How it works

1. User connects wallet — a **Vault** is initialized on first use
2. A **master key** is generated client-side and never sent to the contract
3. The master key is wrapped (AES-GCM) and stored on-chain as an **envelope**
4. Each note is encrypted with the master key in the browser
5. Only ciphertext `iv(12) + AES-GCM(ciphertext+tag)` is sent on-chain
6. All crypto happens client-side — the contract stores bytes, not secrets

## Key Mode

The contract supports two wrapping strategies for the master key:

| Mode | Description | Use case |
|---|---|---|
| `Signature` (1) | Wrapping key derived from an EOA wallet signature | MetaMask and standard EOA wallets |
| `Passphrase` (2) | Wrapping key derived from a user password | Smart wallets without deterministic ECDSA |

> **Note:** The envelope is public on-chain. A weak passphrase can be brute-forced from calldata history even after updating it.

## Contract Features

| Feature | Description |
|---|---|
| `initVault` | One-time vault creation (mode + envelope) |
| `initVaultAndCreateNote` | Create vault + first note in one transaction |
| `updateEnvelope` | Re-wrap the master key (mode or password change) |
| `createNote` | Store an encrypted note |
| `setHidden` | Toggle cosmetic visibility flag (reversible) |
| `deleteNote` | Wipe ciphertext from current state (gas refund) |
| `getNotes` | Paginated note retrieval (max 100 per call) |
| `getVault` | Read vault metadata and envelope |

## Privacy Model

The contract is transparent by design:

- ✅ Note **content** is encrypted — only ciphertext is stored
- ⚠️ Note **existence**, author, size and timestamp are **public** — this is intentional
- ⚠️ `deleteNote` wipes data from **current state** only — calldata history is **permanent**
- ✅ The contract does not know wallet type and does not perform any crypto

## Security

- No owner / admin keys — fully permissionless
- No ETH storage, no token transfers — zero financial risk
- No external calls — no reentrancy risk
- Immutable — no proxy, no upgrade mechanism
- Custom errors instead of string reverts — gas efficient
- Pagination cap: max 100 notes per on-chain read (`MAX_PAGE`)

## Constants

| Constant | Value | Description |
|---|---|---|
| `MAX_NOTE_BYTES` | 8192 | Max encrypted note size |
| `MAX_ENVELOPE_BYTES` | 512 | Max vault envelope size |
| `MAX_PAGE` | 100 | Max notes per paginated query |

## App

🔗 [inote.cfd](https://inote.cfd)
