# 🚦 4-Way Traffic Light Controller — FSM in Verilog

A digital logic design project implementing a 4-way intersection traffic light controller using a **Finite State Machine (FSM)**, built and simulated in **Vivado**.

> 📌 This is a group project developed for the Digital Design course at Konya Food & Agriculture University.

---

## 📌 Project Overview

This project models a real-world 4-way traffic intersection where each direction cycles through **Red → Green → Yellow** states. The FSM ensures that only one direction has a green light at any given time, preventing collisions.

---

## ⚙️ How It Works

The controller is implemented as a **Moore FSM** where outputs depend solely on the current state.

**States:**
| State | North-South | East-West |
|-------|-------------|-----------|
| S0    | 🟢 Green    | 🔴 Red    |
| S1    | 🟡 Yellow   | 🔴 Red    |
| S2    | 🔴 Red      | 🟢 Green  |
| S3    | 🔴 Red      | 🟡 Yellow |

**State transitions** are driven by a clock signal with configurable timing for each phase.

---

## 🛠️ Tech Stack

- **Language:** Verilog HDL
- **Tool:** Xilinx Vivado (Simulation & Synthesis)
- **Concept:** Finite State Machine (FSM), Digital Logic Design

---

## 👥 Team & Contributions

This project was developed by a team of 4 students:

| Name | Contributions |
|------|--------------|
| **Mert Kaymak** | FSM design, Verilog coding |
| Onur Özbedel | Project structure |
| Ahmet Alperen Arslan | FSM design, Presentation & documentation |
| Yalçın Kağan Çakır | simulation & testbench |

---

## 🚀 Running the Simulation

1. Clone the repository:
   ```bash
   git clone https://github.com/mert-kaymak/traffic-light-fsm-verilog.git
   ```
2. Open the project in **Xilinx Vivado**
3. Add source files from the `/src` directory
4. Run **Behavioral Simulation**
5. Observe state transitions on the waveform viewer

---

## 📚 What I Learned

- Designing and implementing Moore FSMs in Verilog HDL
- Writing testbenches for simulation and verification
- Using Vivado for synthesis and timing analysis
- Translating real-world logic problems into digital circuit design

---

## 📄 Course

**Digital Design** — Konya Food & Agriculture University, 2025–2026
