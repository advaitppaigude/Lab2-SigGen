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
    vbdHeader("2.2 sinegen");

    sinegen->clk = 1;
    sinegen->delta = 0;
    sinegen->en = 1;
    sinegen->rst = 0;

    for (i=0; i < 1000000; i++) {

        sinegen->rst = (i < 2);
        sinegen->en = vbdFlag();

        for (clk = 0; clk < 2; clk++) {
            sinegen->clk = !sinegen->clk;
            sinegen->eval();
            tfp->dump (2*i + clk);
        }

        sinegen->delta = vbdValue();
        vbdPlot(int(sinegen->dout1), 0, 255);
        vbdPlot(int(sinegen->dout2), 1, 255);
        vbdCycle(i);
        
        if (Verilated::gotFinish() || (vbdGetkey() == 'q')) exit(0);
    }

    tfp->close();
    exit(0);
}

