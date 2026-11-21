# Morse Code Translator (8086 Assembly)

A bidirectional **Text-to-Morse** and **Morse-to-Text** translator written in 16-bit 8086 Assembly (`.MODEL SMALL`) for emu8086. The application pairs BIOS video and keyboard interrupts with direct VGA text-memory writes (`0B800h`) to provide a 16-color text interface, real-time keystroke validation, live translation statistics, and an on-screen LED playback indicator.

---

## Features

* **Text-to-Morse Encoding:** Converts up to 60 characters of alphanumeric text and punctuation into International Morse Code (` ` between letters, `/` between words).
* **Morse-to-Text Decoding:** Translates up to 60 characters of Morse input (`.`, `-`, ` `, `/`) into uppercase text using a heap-indexed binary tree, flagging invalid sequences with `*`.
* **Visual LED Playback:** Simulates an on-screen LED indicator that blinks the encoded Morse sequence in Text-to-Morse mode with distinct durations for dots, dashes, inter-symbol gaps, letter spaces, and word spaces.
* **Live Statistics:** Calculates and displays total **Characters**, **Words**, **Dots**, and **Dashes** for every translation.
* **Real-Time Input Validation:** Enforces character whitelists, 60-character buffer limits, backspace editing, and non-empty submission with auto-clearing error messages.
* **Direct VRAM Rendering:** Writes characters and attributes directly to VGA memory (`0B800h`) for fast, flicker-free screen updates.

---

## Technical Architecture

### Memory Model & Buffers
Built under `.MODEL SMALL` (single 64 KB code segment, single 64 KB data segment) with a 256-byte stack (`.STACK 100h`).

| Buffer / Table | Size | Purpose |
| :--- | :--- | :--- |
| `MORSE_CODE` | 256 bytes (`128 DW`) | Direct-mapped ASCII (0–127) to near-pointer lookup table for O(1) encoding |
| `MORSE_TREE` | 256 bytes (`256 DB`) | 1-indexed complete binary tree for O(L) Morse decoding |
| `TEXT_INPUT_BUF` | 61 bytes | Null-terminated text input (max 60 characters) |
| `MORSE_OUTPUT_BUF` | 512 bytes | Null-terminated encoded Morse output |
| `MORSE_INPUT_BUF` | 61 bytes | Null-terminated Morse input (max 60 characters) |
| `TEXT_OUTPUT_BUF` | 61 bytes | Null-terminated decoded text output |

### Encoding (`TRANSLATE_TEXT_BUFFER`)
* Lowercase letters (`a`–`z`) are normalized to uppercase (`SUB AL, 20h`) and indexed into `MORSE_CODE` via `Index = ASCII × 2` (`SHL BX, 1`).
* Unmapped ASCII entries store `0`, enabling constant-time rejection during both typing (`READ_TEXT_INPUT`) and translation.
* `IN_WORD_FLAG` collapses leading, trailing, and consecutive spaces so word separators never emit `//` or a trailing `/`.

### Decoding (`TRANSLATE_MORSE_BUFFER`)
* Traverses `MORSE_TREE` starting at root index `1`:
  * **Dot (`.`):** Left child (`BX = BX × 2` via `SHL BX, 1`).
  * **Dash (`-`):** Right child (`BX = BX × 2 + 1` via `SHL BX, 1` + `INC BX`).
* Any traversal exceeding index `255` is clamped to `255` (value `0`) to prevent out-of-bounds reads. Unmapped nodes resolve to `*` and set `BAD_MORSE = 1` to display an inline `[invalid char]` notice.

### Direct VGA Rendering & Display Clamping
* Uses Standard VGA Mode `03h` (80×25, 16 colors) addressed at `0B800h` with `Byte Offset = (Row × 160) + (Column × 2)`.
* Because `MORSE_OUTPUT_BUF` can hold up to 511 characters while the output field fits 62 characters, `DISPLAY_T2M_RESULT` temporarily null-terminates index `62` during rendering and restores the original byte afterward so `VISUALIZE_MORSE` still plays the complete message.
* All major procedures preserve caller state via `SAVE_STATE` / `LOAD_STATE` macros (`AX, BX, CX, DX, SI, DI, ES`).

---

## LED Playback Timing

`VISUALIZE_MORSE` toggles a 6-character solid block between light green (`0A0h`) and black (`00h`) using the nested-loop `DELAY` routine (`BX` outer multiplier, `CX = 2` inner loop):

| Signal / Pause | LED State | `BX` Multiplier |
| :--- | :--- | :---: |
| Dot (`.`) | ON (Green) | `3` |
| Dash (`-`) | ON (Green) | `15` |
| Inter-symbol gap | OFF (Black) | `10` |
| Letter space (` `) | OFF (Black) | `15` |
| Word space (`/`) | OFF (Black) | `20` |

> **Calibration Note:** The inner loop count (`MOV CX, 2`) is tuned for **emu8086** execution speed.

---

## Supported Character Set

* **Letters:** `A`–`Z` (case-insensitive input; decoded as uppercase)
* **Digits:** `0`–`9`
* **Punctuation & Symbols:** `!` `"` `$` `&` `'` `(` `)` `+` `,` `-` `.` `/` `:` `;` `=` `?` `@` `_`

All other ASCII characters are blocked at input time in Text-to-Morse mode.

---

## Core Procedures

| Procedure | Responsibility |
| :--- | :--- |
| `MAIN` | Initializes `DS`, sets VGA Mode `03h`, and dispatches Main Menu options (`1`–`4`). |
| `DRAW_MAIN_GUI` / `DRAW_MENU_BOX` | Draws headers, dividers, and framed UI boxes using `INT 10h` and VRAM writes. |
| `READ_AND_VALIDATE_KEY` | Reads a keystroke via `INT 16h` and restricts menu selection to `'1'`–`'4'`. |
| `TEXT_TO_MORSE_SCREEN` | Runs the Text-to-Morse workflow (UI, input, encoding, stats, LED playback, repeat prompt). |
| `READ_TEXT_INPUT` | Captures up to 60 valid characters with real-time VRAM echo and backspace support. |
| `TRANSLATE_TEXT_BUFFER` | Encodes `TEXT_INPUT_BUF` into `MORSE_OUTPUT_BUF` and updates statistics. |
| `DISPLAY_T2M_RESULT` | Renders the clamped Morse output string and all four stat counters. |
| `MORSE_TO_TEXT_SCREEN` | Runs the Morse-to-Text workflow (UI, input, decoding, stats, repeat prompt). |
| `READ_MORSE_INPUT` | Captures up to 60 characters restricted to `.`, `-`, ` `, and `/`. |
| `TRANSLATE_MORSE_BUFFER` | Decodes `MORSE_INPUT_BUF` via `MORSE_TREE` and updates statistics. |
| `DISPLAY_M2C_RESULTS` | Renders decoded text, stat counters, and the invalid-sequence warning if triggered. |
| `VISUALIZE_MORSE` | Drives LED blinking via `DRAW_GREEN_BLOCK`, `DRAW_BLACK_BLOCK`, and `DELAY`. |
| `PRINT_COLOR_STR` / `PRINT_NUMBER` | Direct VRAM string writer and stack-based unsigned base-10 integer printer. |
| `CLEAR_FULL_SCREEN` / `CLEAR_ERR_IF_NEEDED` | Clears the full screen or error row via `INT 10h` (`AH=06h`). |

---

## System Interrupts

| Interrupt | Function | Usage |
| :--- | :--- | :--- |
| `INT 10h` | `AH = 00h` | Set 80×25 16-color VGA text mode (`AL = 03h`) |
| `INT 10h` | `AH = 02h` | Set hardware cursor position |
| `INT 10h` | `AH = 06h` | Clear full screen, fill UI boxes, clear error banner |
| `INT 10h` | `AH = 09h` | Write repeated character/attribute (borders, dividers, LED block) |
| `INT 16h` | `AH = 00h` | Blocking keyboard read into `AL` |
| `INT 21h` | `AH = 4Ch` | Clean DOS program termination (`AL = 00h`) |

---

## Getting Started

### emu8086 
1. Open the `.asm` source file in **emu8086**.
2. Click **Emulate** (`F5`).
3. Click **Run** to launch the application.
