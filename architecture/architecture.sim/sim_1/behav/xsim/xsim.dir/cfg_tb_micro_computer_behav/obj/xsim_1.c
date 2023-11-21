/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_161(char*, char *);
IKI_DLLESPEC extern void execute_162(char*, char *);
IKI_DLLESPEC extern void execute_163(char*, char *);
IKI_DLLESPEC extern void execute_18(char*, char *);
IKI_DLLESPEC extern void execute_19(char*, char *);
IKI_DLLESPEC extern void execute_20(char*, char *);
IKI_DLLESPEC extern void execute_21(char*, char *);
IKI_DLLESPEC extern void execute_22(char*, char *);
IKI_DLLESPEC extern void execute_23(char*, char *);
IKI_DLLESPEC extern void execute_24(char*, char *);
IKI_DLLESPEC extern void execute_159(char*, char *);
IKI_DLLESPEC extern void execute_160(char*, char *);
IKI_DLLESPEC extern void execute_61(char*, char *);
IKI_DLLESPEC extern void execute_63(char*, char *);
IKI_DLLESPEC extern void execute_64(char*, char *);
IKI_DLLESPEC extern void execute_66(char*, char *);
IKI_DLLESPEC extern void execute_67(char*, char *);
IKI_DLLESPEC extern void execute_68(char*, char *);
IKI_DLLESPEC extern void execute_70(char*, char *);
IKI_DLLESPEC extern void execute_71(char*, char *);
IKI_DLLESPEC extern void execute_72(char*, char *);
IKI_DLLESPEC extern void execute_73(char*, char *);
IKI_DLLESPEC extern void execute_74(char*, char *);
IKI_DLLESPEC extern void execute_76(char*, char *);
IKI_DLLESPEC extern void execute_77(char*, char *);
IKI_DLLESPEC extern void execute_78(char*, char *);
IKI_DLLESPEC extern void execute_79(char*, char *);
IKI_DLLESPEC extern void execute_81(char*, char *);
IKI_DLLESPEC extern void execute_91(char*, char *);
IKI_DLLESPEC extern void execute_84(char*, char *);
IKI_DLLESPEC extern void execute_86(char*, char *);
IKI_DLLESPEC extern void execute_88(char*, char *);
IKI_DLLESPEC extern void execute_89(char*, char *);
IKI_DLLESPEC extern void execute_90(char*, char *);
IKI_DLLESPEC extern void execute_93(char*, char *);
IKI_DLLESPEC extern void execute_102(char*, char *);
IKI_DLLESPEC extern void execute_103(char*, char *);
IKI_DLLESPEC extern void execute_105(char*, char *);
IKI_DLLESPEC extern void execute_106(char*, char *);
IKI_DLLESPEC extern void execute_108(char*, char *);
IKI_DLLESPEC extern void execute_109(char*, char *);
IKI_DLLESPEC extern void execute_125(char*, char *);
IKI_DLLESPEC extern void execute_136(char*, char *);
IKI_DLLESPEC extern void execute_141(char*, char *);
IKI_DLLESPEC extern void execute_155(char*, char *);
IKI_DLLESPEC extern void execute_158(char*, char *);
IKI_DLLESPEC extern void execute_111(char*, char *);
IKI_DLLESPEC extern void execute_112(char*, char *);
IKI_DLLESPEC extern void execute_113(char*, char *);
IKI_DLLESPEC extern void execute_115(char*, char *);
IKI_DLLESPEC extern void execute_116(char*, char *);
IKI_DLLESPEC extern void execute_118(char*, char *);
IKI_DLLESPEC extern void execute_124(char*, char *);
IKI_DLLESPEC extern void execute_129(char*, char *);
IKI_DLLESPEC extern void execute_130(char*, char *);
IKI_DLLESPEC extern void execute_131(char*, char *);
IKI_DLLESPEC extern void execute_138(char*, char *);
IKI_DLLESPEC extern void execute_145(char*, char *);
IKI_DLLESPEC extern void execute_146(char*, char *);
IKI_DLLESPEC extern void execute_148(char*, char *);
IKI_DLLESPEC extern void execute_149(char*, char *);
IKI_DLLESPEC extern void execute_150(char*, char *);
IKI_DLLESPEC extern void execute_151(char*, char *);
IKI_DLLESPEC extern void execute_152(char*, char *);
IKI_DLLESPEC extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_11(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_27(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_31(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_47(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_65(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[71] = {(funcp)execute_161, (funcp)execute_162, (funcp)execute_163, (funcp)execute_18, (funcp)execute_19, (funcp)execute_20, (funcp)execute_21, (funcp)execute_22, (funcp)execute_23, (funcp)execute_24, (funcp)execute_159, (funcp)execute_160, (funcp)execute_61, (funcp)execute_63, (funcp)execute_64, (funcp)execute_66, (funcp)execute_67, (funcp)execute_68, (funcp)execute_70, (funcp)execute_71, (funcp)execute_72, (funcp)execute_73, (funcp)execute_74, (funcp)execute_76, (funcp)execute_77, (funcp)execute_78, (funcp)execute_79, (funcp)execute_81, (funcp)execute_91, (funcp)execute_84, (funcp)execute_86, (funcp)execute_88, (funcp)execute_89, (funcp)execute_90, (funcp)execute_93, (funcp)execute_102, (funcp)execute_103, (funcp)execute_105, (funcp)execute_106, (funcp)execute_108, (funcp)execute_109, (funcp)execute_125, (funcp)execute_136, (funcp)execute_141, (funcp)execute_155, (funcp)execute_158, (funcp)execute_111, (funcp)execute_112, (funcp)execute_113, (funcp)execute_115, (funcp)execute_116, (funcp)execute_118, (funcp)execute_124, (funcp)execute_129, (funcp)execute_130, (funcp)execute_131, (funcp)execute_138, (funcp)execute_145, (funcp)execute_146, (funcp)execute_148, (funcp)execute_149, (funcp)execute_150, (funcp)execute_151, (funcp)execute_152, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_11, (funcp)transaction_27, (funcp)transaction_31, (funcp)transaction_47, (funcp)transaction_65};
const int NumRelocateId= 71;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/cfg_tb_micro_computer_behav/xsim.reloc",  (void **)funcTab, 71);
	iki_vhdl_file_variable_register(dp + 94752);
	iki_vhdl_file_variable_register(dp + 94808);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/cfg_tb_micro_computer_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/cfg_tb_micro_computer_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/cfg_tb_micro_computer_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/cfg_tb_micro_computer_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/cfg_tb_micro_computer_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
