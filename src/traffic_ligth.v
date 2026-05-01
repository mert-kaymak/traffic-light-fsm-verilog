`timescale 1ns / 1ps

module traffic_light(
    input wire clk,
    input wire rst,
    input wire enable,

    // Outputs
    output wire light_1_red, light_1_yellow, light_1_green,
    output wire light_2_red, light_2_yellow, light_2_green,
    output wire light_3_red, light_3_yellow, light_3_green,
    output wire light_4_red, light_4_yellow, light_4_green
);

    // --- 1. WIRES FOR FLIP-FLOPS ---
    reg q0, q1, q2, q3, q4; // Timer bits
    reg s0, s1;             // Road Selector bits

    // Next State Logic Wires
    wire d_q0, d_q1, d_q2, d_q3, d_q4;
    wire d_s0, d_s1;

    // Toggle Logic (Carry Chain)
    wire t1, t2, t3, t4;
    wire timer_done;

    // Phase Flags
    wire is_red_yellow;
    wire is_green;
    wire is_yellow;

    // Active Road Flags
    wire road_1_active, road_2_active, road_3_active, road_4_active;


    // --- 2. TIMER LOGIC (0 to 23) ---
    // Detect 23 (10111) to reset
    assign timer_done = q4 & (~q3) & q2 & q1 & q0;

    // Toggle Calculations (XOR logic mimicking a counter)
    assign t1 = q0;
    assign t2 = q1 & t1;
    assign t3 = q2 & t2;
    assign t4 = q3 & t3;

    // Next State D-Inputs
    assign d_q0 = (~q0) & (~timer_done);
    assign d_q1 = (q1 ^ t1) & (~timer_done);
    assign d_q2 = (q2 ^ t2) & (~timer_done);
    assign d_q3 = (q3 ^ t3) & (~timer_done);
    assign d_q4 = (q4 ^ t4) & (~timer_done);


    // --- 3. ROAD SELECTOR LOGIC (0 to 3) ---
    // Increment only when timer finishes
    assign d_s0 = s0 ^ timer_done;
    assign d_s1 = s1 ^ (s0 & timer_done);


    // --- 4. FLIP-FLOP BLOCK ---
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q0 <= 0; q1 <= 0; q2 <= 0; q3 <= 0; q4 <= 0;
            s0 <= 0; s1 <= 0;
        end else if (enable) begin
            q0 <= d_q0; q1 <= d_q1; q2 <= d_q2; q3 <= d_q3; q4 <= d_q4;
            s0 <= d_s0; s1 <= d_s1;
        end
    end


    // --- 5. PHASE DECODING ---
    
    // Count 0 (00000): Red + Yellow Phase (1 sec)
    assign is_red_yellow = ~(q4 | q3 | q2 | q1 | q0);

    // Count 21-23: Yellow Phase (3 sec)
    // Logic: q4 AND q2 AND (q1 OR q0) -> matches 21(10101), 22(10110), 23(10111)
    assign is_yellow = q4 & q2 & (q1 | q0);

    // Count 1-20: Green Phase (20 sec)
    assign is_green = ~(is_red_yellow | is_yellow);


    // --- 6. OUTPUT LOGIC (The Fix) ---
    
    // Helper wires to know which road is currently "Active"
    assign road_1_active = (~s1) & (~s0);
    assign road_2_active = (~s1) & s0;
    assign road_3_active = s1 & (~s0);
    assign road_4_active = s1 & s0;

    // ROAD 1
    assign light_1_green  = road_1_active & is_green;
    assign light_1_yellow = road_1_active & (is_yellow | is_red_yellow);
    // FIX: Red is ON if road is inactive OR if it's the active road in Red+Yellow phase
    assign light_1_red    = (~road_1_active) | (road_1_active & is_red_yellow);

    // ROAD 2
    assign light_2_green  = road_2_active & is_green;
    assign light_2_yellow = road_2_active & (is_yellow | is_red_yellow);
    assign light_2_red    = (~road_2_active) | (road_2_active & is_red_yellow);

    // ROAD 3
    assign light_3_green  = road_3_active & is_green;
    assign light_3_yellow = road_3_active & (is_yellow | is_red_yellow);
    assign light_3_red    = (~road_3_active) | (road_3_active & is_red_yellow);

    // ROAD 4
    assign light_4_green  = road_4_active & is_green;
    assign light_4_yellow = road_4_active & (is_yellow | is_red_yellow);
    assign light_4_red    = (~road_4_active) | (road_4_active & is_red_yellow);

endmodule