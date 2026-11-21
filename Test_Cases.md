# Test Log — Morse Code Translator (8086 Assembly)

**Environment:** emu8086 (80×25 VGA Text Mode `03h`)  
**Source File:** `morse.asm`  
**Total Test Cases:** 10 | **Passed:** 10 | **Failed:** 0

---

## Test Summary

| ID | Mode | Scenario | Status | Screenshot |
| :---: | :--- | :--- | :---: | :--- |
| **TC-01** | Main Menu | Initial GUI render | **PASS** | `Main Menu.png` |
| **TC-02** | Main Menu | Out-of-range key rejection | **PASS** | `Main Menu Invalid Input.png` |
| **TC-03** | Text → Morse | Mode initialization | **PASS** | `Text to Morse Menu.png` |
| **TC-04** | Text → Morse | Valid multi-word encoding & LED playback | **PASS** | `Text to Morse Operation.png` |
| **TC-05** | Text → Morse | Unsupported character rejection | **PASS** | `Text to Morse Invalid Input.png` |
| **TC-06** | Text → Morse | 60-character buffer limit | **PASS** | `Text to Morse Buffer Overflow.png` |
| **TC-07** | Morse → Text | Mode initialization | **PASS** | `Morse to Text Menu.png` |
| **TC-08** | Morse → Text | Valid multi-word decoding | **PASS** | `Morse to Text Operation.png` |
| **TC-09** | Morse → Text | Invalid Morse sequence handling | **PASS** | `Morse to Text Input with Invalid Sequence.png` |
| **TC-10** | Morse → Text | 60-character buffer limit | **PASS** | `Morse to Text Buffer Overflow.png` |

*(All screenshots are located in the `Screenshots/` folder.)*

---

## Detailed Test Cases

### TC-01 — Main Menu: Initial GUI Render (`PASS`)
* **Input / Action:** Launch program in emu8086.
* **Expected:** Title, subtitle, horizontal divider, 4 framed menu boxes (`1`–`4`), and input prompt rendered cleanly.
* **Actual:** Rendered cleanly in 80×25 16-color VGA text mode.
* **Screenshot:** `Screenshots/Main Menu.png`

### TC-02 — Main Menu: Out-of-Range Key Rejection (`PASS`)
* **Input / Action:** Press a key outside `'1'`–`'4'`.
* **Expected:** Display `Error 2: Invalid key! Only options 1 to 4 are valid.` on Row 24 and stay on the menu.
* **Actual:** Red error banner displayed on Row 24; menu remained active.
* **Screenshot:** `Screenshots/Main Menu Invalid Input.png`

### TC-03 — Text → Morse: Mode Initialization (`PASS`)
* **Input / Action:** Press `1` from the Main Menu.
* **Expected:** Clear screen and render Text, Morse, and Statistics boxes with empty fields.
* **Actual:** Screen cleared and all three UI boxes rendered properly.
* **Screenshot:** `Screenshots/Text to Morse Menu.png`

### TC-04 — Text → Morse: Valid Multi-Word Encoding & LED Playback (`PASS`)
* **Input
