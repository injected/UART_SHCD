/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x36e8438f */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Thomes/Desktop/UART/UART VHDL/GENERATE_PARITYBIT.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1690584930_2592010699(char *, unsigned char );


static void work_a_3265257115_2356295106_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    int t9;
    int t10;
    char *t11;
    char *t12;
    int t13;
    int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    unsigned char t19;
    unsigned char t20;
    char *t21;
    char *t22;
    unsigned char t23;
    unsigned char t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;

LAB0:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 776U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(69, ng0);
    t2 = (t0 + 2196);
    t3 = (t2 + 32U);
    t7 = *((char **)t3);
    t8 = (t7 + 40U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);

LAB3:    t2 = (t0 + 2144);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(56, ng0);
    t7 = (t0 + 3953);
    *((int *)t7) = 7;
    t8 = (t0 + 3957);
    *((int *)t8) = 0;
    t9 = 7;
    t10 = 0;

LAB8:    if (t9 >= t10)
        goto LAB9;

LAB11:    goto LAB3;

LAB5:    t2 = (t0 + 752U);
    t6 = xsi_signal_has_event(t2);
    t1 = t6;
    goto LAB7;

LAB9:    xsi_set_current_line(57, ng0);
    t11 = (t0 + 868U);
    t12 = *((char **)t11);
    t11 = (t0 + 3953);
    t13 = *((int *)t11);
    t14 = (t13 - 7);
    t15 = (t14 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, *((int *)t11));
    t16 = (1U * t15);
    t17 = (0 + t16);
    t18 = (t12 + t17);
    t19 = *((unsigned char *)t18);
    t20 = (t19 == (unsigned char)3);
    if (t20 != 0)
        goto LAB12;

LAB14:
LAB13:
LAB10:    t2 = (t0 + 3953);
    t9 = *((int *)t2);
    t3 = (t0 + 3957);
    t10 = *((int *)t3);
    if (t9 == t10)
        goto LAB11;

LAB15:    t13 = (t9 + -1);
    t9 = t13;
    t7 = (t0 + 3953);
    *((int *)t7) = t9;
    goto LAB8;

LAB12:    xsi_set_current_line(58, ng0);
    t21 = (t0 + 1052U);
    t22 = *((char **)t21);
    t23 = *((unsigned char *)t22);
    t24 = ieee_p_2592010699_sub_1690584930_2592010699(IEEE_P_2592010699, t23);
    t21 = (t0 + 2196);
    t25 = (t21 + 32U);
    t26 = *((char **)t25);
    t27 = (t26 + 40U);
    t28 = *((char **)t27);
    *((unsigned char *)t28) = t24;
    xsi_driver_first_trans_fast(t21);
    goto LAB13;

}

static void work_a_3265257115_2356295106_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(74, ng0);

LAB3:    t1 = (t0 + 1052U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 2232);
    t4 = (t1 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 2152);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_3265257115_2356295106_init()
{
	static char *pe[] = {(void *)work_a_3265257115_2356295106_p_0,(void *)work_a_3265257115_2356295106_p_1};
	xsi_register_didat("work_a_3265257115_2356295106", "isim/E_GENERATE_PARITYBIT_isim_beh.exe.sim/work/a_3265257115_2356295106.didat");
	xsi_register_executes(pe);
}
