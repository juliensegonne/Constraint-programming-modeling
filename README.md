# Constraint Programming Modeling

## Description

This work involves solving various combinatorial problems using constraint programming with MiniZinc. Each problem requires modeling constraints and finding optimal solutions while meeting specific criteria.

It focuses on four distinct problems of increasing difficulty.

---

## Modeled Problems

### 1. **4-Digit Code**
Find an even number composed of 4 distinct digits that satisfy specific criteria:
- No digit is 0.
- Constraints on digit positions.
- The sum of the digits > 15.
- Minimize the product of the last 3 digits.

> Goal: Use at least one global constraint and find the optimal solution with the Gecode solver in under 2 minutes.

---

### 2. **A Picky Theater Troupe**
Assign roles and costumes to actors while avoiding:
- Role conflicts between neighboring actors.
- Costume conflicts.

> Goal: Model the problem with global constraints and obtain a valid solution in under 2 minutes for each configuration.

---

### 3. **A (Too) Cutting-Edge Factory**
Schedule tasks in a factory while respecting:
- A specific energy limit.
- No more than two tasks starting simultaneously.
- Goal: Minimize the total project time (makespan).

> Goal: Use at least two global constraints and find an optimal solution in under 2 minutes with the Gecode solver.

---

### 4. **The Grand International Tour**
Plan an optimal itinerary to visit several cities while respecting:
- Time windows for each city.
- Visiting each city exactly once.
- Goal: Minimize the total tour time.

> Goal: Implement global and redundant constraints to accelerate resolution with the Chuffed solver in under 2 minutes.

---

## Tools and Requirements

- **MiniZinc** version 2.8.7.
- Solvers: Gecode, Chuffed.
- Provided files: `.mzn` (models), `.mzc` (solution verifiers), `.dzn` (instances).

---

## Instructions

1. **Install MiniZinc:**
   - Download and install MiniZinc from [minizinc.org](https://www.minizinc.org/index.html).

2. **Run the Models:**
   - Load the `.mzn` model and `.dzn` instance into MiniZinc.
   - Execute the model with a solver (Gecode or Chuffed) to obtain the solution.

3. **Verify the Solution:**
   - Open the corresponding `.mzc` file to validate the solution.

4. **Performance Criteria:**
   - Each problem must be solved in under 2 minutes.
   - Solutions must be correct and respect all constraints.

---

## File Structure

- **Problems:**
  - `problem0.mzn`, `problem1.mzn`, `problem2.mzn`, `problem3.mzn`.

- **Instances:**
  - `problem0.dzn`, `problem1.dzn`, `problem2.dzn`, `problem3.dzn`.

- **Verifiers:**
  - `problem0.mzc`, `problem1.mzc`, `problem2.mzc`, `problem3.mzc`.

---

## Authors
Project completed as part of the INF8175 course at Polytechnique Montréal.
