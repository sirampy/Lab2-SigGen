#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"
const char* PROG_NAME = "Lab2: sin"; // could put all params in a namespace if i end up with a lot of them

int main(int argc, char **argv, char **env){
    int i; 
    int clk;

    Verilated::commandArgs(argc, argv);
    // init verilog instance
    Vsinegen* top = new Vsinegen();
    //init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("sinegen.vcd");

    // init vbuddy
    if (vbdOpen()!=1) return (-1);
    vbdHeader(PROG_NAME);
    vbdSetMode(1);

    // init simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->incr = vbdValue(); // for fun

    // run simulation 
    for (i = 0; i < 255*10; i++){

        top->incr = vbdValue();

        for (clk = 0; clk < 2; clk++){
            tfp->dump (2*i+clk);   //unit is in ps
            top->clk = !top->clk;
            top->eval ();
        }
        
        //  current cycle
        vbdPlot(int(top->dout), 0, 255);
        vbdCycle(i+1);

        // change signals during

        // exit on finish or stop
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) exit(0);  
    }

    vbdClose();
    tfp -> close();
    exit(0);
};