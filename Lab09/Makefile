TOP := SingleCycleProcTest_v
OUT := ProcTest
WAVE := singlecycle.vcd
SRCS := \
	ALU.v \
	DataMemory.v \
	InstructionMemory.v \
	RegisterFile.v \
	SignExtender.v \
	SingleCycleControl.v \
	SingleCycleProc.v \
	SingleCycleProcTest.v
IVERILOG_FLAGS := -Wall

.PHONY: all run wave clean

all: $(OUT)

$(OUT): $(SRCS)
	@echo "Compiling $(OUT)..."
	iverilog $(IVERILOG_FLAGS) -o $@ $^

run: $(OUT)
	@echo "Running simulation..."
	vvp $(OUT)

wave: run
	@if [ -f $(WAVE) ]; then \
		echo "Opening $(WAVE) in GTKWave..."; \
		gtkwave $(WAVE) & \
	else \
		echo "No VCD file ($(WAVE)) found. Did the testbench call \$dumpvars?"; \
	fi

clean:
	rm -f $(OUT) $(WAVE)