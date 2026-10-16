#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);

    Vsinegen* sinegen = new Vsinegen;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    sinegen->trace(tfp,99);
    tfp->open("sinegen.vcd");

    if (vbdOpen() != 1) return -1;
    vbdHeader("2.1 sinegen");

    sinegen->clk = 1;
    sinegen->incr = 1;
    sinegen->en = 1;
    sinegen->rst = 0;

    for (i=0; i < 1000000; i++) {

        sinegen->en = vbdFlag();

        for (clk = 0; clk < 2; clk++) {
            tfp->dump (2*i + clk);
            sinegen->clk = !sinegen->clk;
            sinegen->eval();
        }

        sinegen->incr = vbdValue();
        vbdPlot(int(sinegen->dout), 0, 255);
        vbdCycle(i);
        
        if (Verilated::gotFinish() || (vbdGetkey() == 'q')) exit(0);
    }

    tfp->close();
    exit(0);
}

