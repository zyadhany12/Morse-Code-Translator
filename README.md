# Morse Code Translator — 8086 Assembly Edition

A bidirectional **Text-to-Morse** and **Morse-to-Text** translator written in 16-bit 8086 Assembly (`.MODEL SMALL`, real-mode DOS). It combines BIOS interrupts (`INT 10h`, `INT 16h`, `INT 21h`) with direct VGA text-memory writes (`0B800h`) to deliver a custom 80×25 16-color TUI, real-time keystroke validation, live translation statistics, and an on-screen LED playback simulator.

---

## Table of Contents

1. [Features](#features)
2. [UI Layout Mockups](#ui-layout-mockups)
3. [Memory Model & Data Layout](#memory-model--data-layout)
4. [Algorithms & Data Structures](#algorithms--data-structures)
5. [VGA Text Memory (`0B800h`) & Color Palette](#vga-text-memory-0b800h--color-palette)
6. [LED Simulation & Timing Calibration](#led-simulation--timing-calibration)
7. [Input Validation & Error Handling](#input-validation--error-handling)
8. [Supported Character Set](#supported-character-set)
9. [Procedure & Macro Reference](#procedure--macro-reference)
10. [System Interrupts Used](#system-interrupts-used)
11. [Build & Run Instructions](#build--run-instructions)
12. [Usage Walkthrough](#usage-walkthrough)
13. [Known Limitations](#known-limitations)

---

## Features

* **Bidirectional Translation:**
  * **Text → Morse:** Encodes up to 60 characters of letters, digits, and 18 punctuation symbols into International Morse Code (` ` between letters, `/` between words).
  * **Morse → Text:** Decodes up to 60 characters of `.`, `-`, ` `, and `/` back into uppercase text using a 256-byte heap-indexed binary tree.
* **Visual LED Playback:** Blinks a 6-cell green indicator block on Row 5, Column 37 to visually transmit the encoded Morse output with distinct durations for dots, dashes, inter-symbol gaps, letter spaces, and word spaces.
* **Live Statistics Bar:** Computes and displays **Characters**, **Words**, **Dots**, and **Dashes** for every translation in both modes.
* **Real-Time Input Validation:** Rejects unsupported characters on the fly, enforces buffer bounds, supports `Backspace` editing with live VRAM erasure, and auto-clears Row 24 error banners on the next valid keystroke.
* **Direct VRAM Rendering:** Writes characters and color attributes directly to segment `0B800h` for instant UI updates without cursor flicker.

---

## UI Layout Mockups

### Main Menu (80×25 VGA Mode `03h`)

```text
Row 01:                             MORSE CODE TRANSLATOR
Row 02:                             8086 ASSEMBLY EDITION
Row 03:     ────────────────────────────────────────────────────────────────────────
Row 05:     Select operation:
Row 07:     ┌──────────────────────────────────────────────────────────────────────┐
Row 08:     │ 1. Text to Morse Code                                                │
Row 09:     └──────────────────────────────────────────────────────────────────────┘
Row 11:     ┌──────────────────────────────────────────────────────────────────────┐
Row 12:     │ 2. Morse Code to Text                                                │
Row 13:     └──────────────────────────────────────────────────────────────────────┘
Row 15:     ┌──────────────────────────────────────────────────────────────────────┐
Row 16:     │ 3. Clear Screen                                                      │
Row 17:     └──────────────────────────────────────────────────────────────────────┘
Row 19:     ┌──────────────────────────────────────────────────────────────────────┐
Row 20:     │ 4. Exit                                                              │
Row 21:     └──────────────────────────────────────────────────────────────────────┘
Row 23:     Enter your choice: _
Row 24:     [Row 24 reserved for red error banners]
