# Morse Code Translator — 8086 Assembly Edition

A bidirectional Text-to-Morse and Morse-to-Text translator written in 16-bit 8086 Assembly (`.MODEL SMALL`). It features a custom 80×25 16-color text user interface rendered directly to VGA video memory (`0B800h`), real-time input validation, live translation statistics, and a visual LED playback simulator.

---

## Features

* **Text to Morse Code:** Translates up to 60 characters of alphanumeric text and punctuation into International Morse Code (`/` separates words, space separates letters).
* **Morse Code to Text:** Decodes up to 60 characters of Morse input (`.`, `-`, space, `/`) back into text, flagging unrecognized sequences with `*` and an inline warning.
* **Visual LED Playback:** Simulates an on-screen LED indicator (a 6-cell green block on Row 5) that blinks out the translated Morse sequence in Text-to-Morse mode with distinct timings for dots, dashes, and spacing.
* **Live Statistics Dashboard:** Tracks and displays **Characters**, **Words**, **Dots**, and **Dashes** for every translation.
* **Real-Time Input Validation:** Enforces character whitelists, 60-character input limits, backspace editing, and non-empty submission, displaying contextual error messages on Row 24 that automatically clear on the next valid keystroke.
* **Direct VRAM Rendering:** Uses memory-mapped writes to segment `0B800h` alongside BIOS `INT 10h` calls for fast, flicker-free UI rendering.

---

## Architecture & Data Structures

### 1. Text-to-Morse: O(1) Direct-Mapped Lookup Table (`MORSE_CODE`)
Each ASCII character (`0–127`) maps directly to a 16-bit word pointer in `MORSE_CODE` via `Index = ASCII × 2` (`SHL BX, 1`).
* Lowercase letters (`a`–`z`) are normalized to uppercase (`SUB AL, 20h`) before lookup, though lowercase entries are also populated in the table.
* Unmapped characters hold `0`, allowing instant validation during typing (`READ_TEXT_INPUT`) and translation (`TRANSLATE_TEXT_BUFFER`).
* Multiple consecutive spaces or trailing spaces are collapsed using `IN_WORD_FLAG` so they never produce `//` or a dangling `/`.

### 2. Morse-to-Text: O(L) Heap-Indexed Binary Tree (`MORSE_TREE
