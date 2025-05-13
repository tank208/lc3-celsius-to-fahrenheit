# LC-3 Celsius to Fahrenheit Converter

**Author:** Will Hall  
**Course:** CS155 — Computer Organization and Assembly Language  
**Final Project — Spring 2025**

---

## 📌 Project Description

This LC-3 assembly program converts a two-digit Celsius temperature (00–99) into Fahrenheit using the formula:

```
F = (C × 9 / 5) + 32
```

The program:
- Prompts the user to input two ASCII digits
- Converts those digits into an integer Celsius value
- Applies fixed-point arithmetic using integer instructions only
- Outputs the resulting Fahrenheit value in clean, 3-digit decimal format

---

## 🧠 Features Demonstrated

- Subroutine usage with `JSR` and `RET`
- Manual ASCII-to-integer conversion
- Fixed-point integer multiplication and loop-based division
- Controlled output formatting using TRAP routines
- Stack pointer initialization (`R6`)
- Register discipline and clean, modular program structure
- All code written using instructions from the textbook (Patt & Patel)

---

## 🚀 How to Run

This program is designed to run in the **Java-based LC-3 Simulator**, provided here:

👉 [https://highered.mheducation.com/sites/0072467509/student_view0/lc-3_simulator.html](https://highered.mheducation.com/sites/0072467509/student_view0/lc-3_simulator.html)

1. Open the LC-3 Simulator
2. Load the file: `celsius_to_fahrenheit_final_commented_with_subs.asm`
3. Assemble the program (`Assemble → Assemble All`)
4. Set PC to `x3000` if not already set
5. Run the program (`Simulate → Run`)
6. Input two digits when prompted (e.g., `3` and `0` for 30°C)
7. The program will output the Fahrenheit result

---

## ⚙️ Special Requirements

- Must be run in the **Java LC-3 Simulator**
- Only works with numeric input (`00` to `99`) — no input validation is provided
- Output is always in 3-digit format (e.g., `032`, `086`, `111`)

---

## 📚 What I Learned

This project involved debugging and understanding:
- How to simulate math operations without floating-point support
- Why register preservation is critical
- How trap routines interact with display formatting
- The LC-3 instruction lifecycle and memory safety
- How to structure a clean, modular assembly program under real constraints

---

## ✅ Final Notes

This project was written and debugged over two months. Every line of logic was hand-built, corrected, and verified through repeated testing. It is stable, accurate, and designed to reflect mastery of the LC-3 as taught in this course.

