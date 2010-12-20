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
static const char *ng0 = "C:/Users/Thomes/Desktop/UART/UART VHDL/TRANSMITT.vhd";



static void work_a_0985334029_2321707663_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    int t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t15;
    unsigned char t16;
    unsigned char t17;
    unsigned char t18;
    char *t19;
    int t20;
    int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;

LAB0:    xsi_set_current_line(62, ng0);
    t2 = (t0 + 868U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(67, ng0);
    t2 = (t0 + 868U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t4 = (t1 == (unsigned char)3);
    if (t4 != 0)
        goto LAB8;

LAB10:
LAB9:    xsi_set_current_line(118, ng0);
    t2 = (t0 + 868U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 3272);
    t6 = (t2 + 32U);
    t9 = *((char **)t6);
    t11 = (t9 + 40U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = t1;
    xsi_driver_first_trans_fast(t2);
    t2 = (t0 + 3068);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(64, ng0);
    t2 = (t0 + 1960U);
    t9 = *((char **)t2);
    t10 = *((int *)t9);
    t2 = (t0 + 3128);
    t11 = (t2 + 32U);
    t12 = *((char **)t11);
    t13 = (t12 + 40U);
    t14 = *((char **)t13);
    *((int *)t14) = t10;
    xsi_driver_first_trans_fast(t2);
    goto LAB3;

LAB5:    t2 = (t0 + 1788U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)2);
    t1 = t8;
    goto LAB7;

LAB8:    xsi_set_current_line(70, ng0);
    t2 = (t0 + 592U);
    t6 = *((char **)t2);
    t5 = *((unsigned char *)t6);
    t7 = (t5 == (unsigned char)2);
    if (t7 != 0)
        goto LAB11;

LAB13:    t2 = (t0 + 684U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB16;

LAB17:    t1 = (unsigned char)0;

LAB18:    if (t1 != 0)
        goto LAB14;

LAB15:
LAB12:    goto LAB9;

LAB11:    xsi_set_current_line(72, ng0);
    t2 = (t0 + 3164);
    t9 = (t2 + 32U);
    t11 = *((char **)t9);
    t12 = (t11 + 40U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 2028U);
    t3 = *((char **)t2);
    t10 = *((int *)t3);
    t2 = (t0 + 3128);
    t6 = (t2 + 32U);
    t9 = *((char **)t6);
    t11 = (t9 + 40U);
    t12 = *((char **)t11);
    *((int *)t12) = t10;
    xsi_driver_first_trans_fast(t2);
    goto LAB12;

LAB14:    xsi_set_current_line(77, ng0);
    t6 = (t0 + 776U);
    t9 = *((char **)t6);
    t15 = *((unsigned char *)t9);
    t16 = (t15 == (unsigned char)3);
    if (t16 == 1)
        goto LAB22;

LAB23:    t8 = (unsigned char)0;

LAB24:    if (t8 != 0)
        goto LAB19;

LAB21:
LAB20:    xsi_set_current_line(115, ng0);
    t2 = (t0 + 776U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 3236);
    t6 = (t2 + 32U);
    t9 = *((char **)t6);
    t11 = (t9 + 40U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = t1;
    xsi_driver_first_trans_fast(t2);
    goto LAB12;

LAB16:    t2 = (t0 + 660U);
    t7 = xsi_signal_has_event(t2);
    t1 = t7;
    goto LAB18;

LAB19:    xsi_set_current_line(79, ng0);
    t6 = (t0 + 3200);
    t12 = (t6 + 32U);
    t13 = *((char **)t12);
    t14 = (t13 + 40U);
    t19 = *((char **)t14);
    *((unsigned char *)t19) = (unsigned char)3;
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(80, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t10 = *((int *)t3);
    t2 = (t0 + 1960U);
    t6 = *((char **)t2);
    t20 = *((int *)t6);
    if (t10 == t20)
        goto LAB26;

LAB32:    if (t10 == 8)
        goto LAB27;

LAB33:    if (t10 == 10)
        goto LAB28;

LAB34:    if (t10 == 11)
        goto LAB29;

LAB35:    t2 = (t0 + 2028U);
    t9 = *((char **)t2);
    t21 = *((int *)t9);
    if (t10 == t21)
        goto LAB30;

LAB36:
LAB31:    xsi_set_current_line(110, ng0);
    t2 = (t0 + 1144U);
    t3 = *((char **)t2);
    t2 = (t0 + 1512U);
    t6 = *((char **)t2);
    t10 = *((int *)t6);
    t20 = (t10 - 7);
    t22 = (t20 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t10);
    t23 = (1U * t22);
    t24 = (0 + t23);
    t2 = (t3 + t24);
    t1 = *((unsigned char *)t2);
    t9 = (t0 + 3164);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    t13 = (t12 + 40U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = t1;
    xsi_driver_first_trans_fast(t9);
    xsi_set_current_line(111, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t10 = *((int *)t3);
    t20 = (t10 + 1);
    t2 = (t0 + 3128);
    t6 = (t2 + 32U);
    t9 = *((char **)t6);
    t11 = (t9 + 40U);
    t12 = *((char **)t11);
    *((int *)t12) = t20;
    xsi_driver_first_trans_fast(t2);

LAB25:    goto LAB20;

LAB22:    t6 = (t0 + 1604U);
    t11 = *((char **)t6);
    t17 = *((unsigned char *)t11);
    t18 = (t17 == (unsigned char)2);
    t8 = t18;
    goto LAB24;

LAB26:    xsi_set_current_line(83, ng0);
    t2 = (t0 + 3164);
    t11 = (t2 + 32U);
    t12 = *((char **)t11);
    t13 = (t12 + 40U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(84, ng0);
    t2 = (t0 + 3128);
    t3 = (t2 + 32U);
    t6 = *((char **)t3);
    t9 = (t6 + 40U);
    t11 = *((char **)t9);
    *((int *)t11) = 0;
    xsi_driver_first_trans_fast(t2);
    goto LAB25;

LAB27:    xsi_set_current_line(87, ng0);
    t2 = (t0 + 1052U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 3164);
    t6 = (t2 + 32U);
    t9 = *((char **)t6);
    t11 = (t9 + 40U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = t1;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(88, ng0);
    t2 = (t0 + 3128);
    t3 = (t2 + 32U);
    t6 = *((char **)t3);
    t9 = (t6 + 40U);
    t11 = *((char **)t9);
    *((int *)t11) = 10;
    xsi_driver_first_trans_fast(t2);
    goto LAB25;

LAB28:    xsi_set_current_line(92, ng0);
    t2 = (t0 + 3164);
    t3 = (t2 + 32U);
    t6 = *((char **)t3);
    t9 = (t6 + 40U);
    t11 = *((char **)t9);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(93, ng0);
    t2 = (t0 + 960U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t4 = (t1 == (unsigned char)3);
    if (t4 != 0)
        goto LAB38;

LAB40:    t2 = (t0 + 960U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t4 = (t1 == (unsigned char)2);
    if (t4 != 0)
        goto LAB41;

LAB42:
LAB39:    goto LAB25;

LAB29:    xsi_set_current_line(103, ng0);
    t2 = (t0 + 3164);
    t3 = (t2 + 32U);
    t6 = *((char **)t3);
    t9 = (t6 + 40U);
    t11 = *((char **)t9);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(104, ng0);
    t2 = (t0 + 2028U);
    t3 = *((char **)t2);
    t10 = *((int *)t3);
    t2 = (t0 + 3128);
    t6 = (t2 + 32U);
    t9 = *((char **)t6);
    t11 = (t9 + 40U);
    t12 = *((char **)t11);
    *((int *)t12) = t10;
    xsi_driver_first_trans_fast(t2);
    goto LAB25;

LAB30:    xsi_set_current_line(107, ng0);
    t2 = (t0 + 3200);
    t3 = (t2 + 32U);
    t6 = *((char **)t3);
    t9 = (t6 + 40U);
    t11 = *((char **)t9);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB25;

LAB37:;
LAB38:    xsi_set_current_line(95, ng0);
    t2 = (t0 + 3128);
    t6 = (t2 + 32U);
    t9 = *((char **)t6);
    t11 = (t9 + 40U);
    t12 = *((char **)t11);
    *((int *)t12) = 11;
    xsi_driver_first_trans_fast(t2);
    goto LAB39;

LAB41:    xsi_set_current_line(98, ng0);
    t2 = (t0 + 2028U);
    t6 = *((char **)t2);
    t10 = *((int *)t6);
    t2 = (t0 + 3128);
    t9 = (t2 + 32U);
    t11 = *((char **)t9);
    t12 = (t11 + 40U);
    t13 = *((char **)t12);
    *((int *)t13) = t10;
    xsi_driver_first_trans_fast(t2);
    goto LAB39;

}

static void work_a_0985334029_2321707663_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(122, ng0);

LAB3:    t1 = (t0 + 1420U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 3308);
    t4 = (t1 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 3076);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0985334029_2321707663_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(123, ng0);

LAB3:    t1 = (t0 + 1696U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 3344);
    t4 = (t1 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 3084);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0985334029_2321707663_init()
{
	static char *pe[] = {(void *)work_a_0985334029_2321707663_p_0,(void *)work_a_0985334029_2321707663_p_1,(void *)work_a_0985334029_2321707663_p_2};
	xsi_register_didat("work_a_0985334029_2321707663", "isim/E_TRANSMITT_isim_beh.exe.sim/work/a_0985334029_2321707663.didat");
	xsi_register_executes(pe);
}
