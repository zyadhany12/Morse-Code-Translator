# Test Log — Morse Code Translator (8086 Assembly)

**Environment:** emu8086 (80×25 VGA Text Mode `03h`)  
**Source File:** `morse.asm`  
**Total Test Cases:** 10 | **Passed:** 10 | **Failed:** 0

---

## Test Summary Table

| Test ID | Category | Test Scenario | Input / Action | Expected Result | Actual Result | Status | Screenshot |
| :---: | :--- | :--- | :--- | :--- | :--- | :---: | :--- |
| **TC-01** | Main Menu | Initial GUI render | Launch program | Title, subtitle, divider, 4 menu boxes (`1`–`4`), and prompt rendered cleanly | Rendered cleanly in 80×25 16-color VGA mode | **PASS** | `Screenshots/Main Menu.png` |
| **TC-02** | Main Menu | Out-of-range key rejection | Press key outside `'1'`–`'4'` | Display `Error 2: Invalid key! Only options 1 to 4 are valid.` on Row 24 and remain on menu | Error banner displayed in red on Row 24; menu stayed active | **PASS** | `Screenshots/Main Menu Invalid Input.png` |
| **TC-03** | Text → Morse | Mode initialization | Press `1` from Main Menu | Clear screen and render Text, Morse, and Statistics boxes with empty fields | Screen cleared and all three UI boxes rendered properly | **PASS** | `Screenshots/Text to Morse Menu.png` |
| **TC-04** | Text → Morse | Valid multi-word encoding & LED playback | `Hello World` + `Enter` | Morse: `.... . .-.. .-.. ---/ .-- --- .-. .-.. -..`<br>Stats: `Chars: 10`, `Words: 2`, `Dots: 19`, `Dashes: 13`<br>Green LED block blinks on Row 5 | Exact Morse output and statistics displayed; green LED block visibly lit during playback | **PASS** | `Screenshots/Text to Morse Operation.png` |
| **TC-05** | Text → Morse | Unsupported character rejection | Type unmapped ASCII key (e.g., `#`, `*`, `%`) | Reject key from buffer and display `Error: Unsupported character!` on Row 24 | Character blocked; red error banner displayed on Row 24 | **PASS** | `Screenshots/Text to Morse Invalid Input.png` |
| **TC-06** | Text → Morse | 60-character buffer limit | Type 60 characters (`asfihwviowvhweviwevepofjqefoqefopjofjqpqqqqqqqqqqqqqqqqqqqq`) + extra key | Block further input beyond 60 chars and display `Error: Input full (max 60 characters)!` | Input capped at 60 chars; red error banner displayed on Row 24 without box overflow | **PASS** | `Screenshots/Text to Morse Buffer Overflow.png` |
| **TC-07** | Morse → Text | Mode initialization | Press `2` from Main Menu | Clear screen and render Morse, Text, and Statistics boxes with cursor in Morse field | Screen cleared, boxes rendered, and cursor positioned at `Morse:` input start | **PASS** | `Screenshots/Morse to Text Menu.png` |
| **TC-08** | Morse → Text | Valid multi-word decoding | `.... . .-.. .-.. --- / .-- --- .-. .-.. -..` + `Enter` | Text: `HELLO WORLD`<br>Stats: `Chars: 10`, `Words: 2`, `Dots: 19`, `Dashes: 13`<br>Display repeat/menu prompt | Exact decoded string, statistics, and Row 23 prompt displayed | **PASS** | `Screenshots/Morse to Text Operation.png` |
| **TC-09** | Morse → Text | Invalid Morse sequence handling | `..- .- ........` + `Enter` | Decode valid tokens (`U`, `A`), replace invalid 8-dot sequence with `*` (`UA*`), stats `Chars: 3, Words: 1, Dots: 11, Dashes: 2`, and show `[invalid char]` on Row 22 | Output `UA*`, exact stats, and red `[invalid char]` warning displayed on Row 22 | **PASS** | `Screenshots/Morse to Text Input with Invalid Sequence.png` |
| **TC-10** | Morse → Text | 60-character buffer limit | Type 60 Morse characters (`.- .- ...`) + extra key | Block further input beyond 60 chars and display `Error 3: Input full (max 60)! Press Enter to decode.` | Input capped at 60 chars; red error banner displayed on Row 24 | **PASS** | `Screenshots/Morse to Text Buffer Overflow.png` |

---

## Detailed Test Observations

* **Case Folding & Bidirectional Consistency (TC-04 & TC-08):** Mixed-case input `Hello World` in Text-to-Morse produced the exact same dot/dash counts (`19` dots, `13` dashes) and character/word counts (`10` chars, `2` words) as decoding `.... . .-.. .-.. --- / .-- --- .-. .-.. -..` back to `HELLO WORLD` in Morse-to-Text.
* **Binary Tree Bounds Protection (TC-09):** The 8-dot sequence `........` exceeded the populated depth of `MORSE_TREE`, was safely clamped to index `255` (`0`), emitted `*` in place of the invalid character, and raised `BAD_MORSE` to print `[invalid char]` without corrupting memory or halting valid surrounding letters (`UA`).
* **Buffer Overflow Protection (TC-06 & TC-10):** Both input routines strictly enforced the 60-character boundary, preventing VRAM writes from spilling past the right box border (`Col 75`) or overflowing `TEXT_INPUT_BUF` / `MORSE_INPUT_BUF`.
* **Visual LED Playback (TC-04):** The 6-cell green indicator (`0A0h`) rendered cleanly at Row 5, Column 37 during Text-to-Morse playback and cleared cleanly back to black (`00h`) upon completion.
