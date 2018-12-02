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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "E:/2018Fall/Computer Organization/CPU/CPU/ImmediateMux.vhd";
extern char *IEEE_P_3499444699;

char *ieee_p_3499444699_sub_854811550_3536714472(char *, char *, char *, char *, int );
char *ieee_p_3499444699_sub_871414444_3536714472(char *, char *, char *, char *, int );


static void work_a_2250428819_3212880686_p_0(char *t0)
{
    char t21[16];
    char t26[16];
    char *t1;
    char *t2;
    char *t3;
    int t4;
    char *t5;
    char *t6;
    int t7;
    char *t8;
    char *t9;
    int t10;
    char *t11;
    char *t12;
    int t13;
    char *t14;
    char *t15;
    int t16;
    char *t17;
    char *t18;
    unsigned char t19;
    unsigned char t20;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    char *t27;
    char *t28;
    int t29;
    unsigned int t30;
    char *t31;
    unsigned char t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;

LAB0:    xsi_set_current_line(46, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t1 = (t0 + 4948);
    t4 = xsi_mem_cmp(t1, t2, 3U);
    if (t4 == 1)
        goto LAB3;

LAB9:    t5 = (t0 + 4951);
    t7 = xsi_mem_cmp(t5, t2, 3U);
    if (t7 == 1)
        goto LAB4;

LAB10:    t8 = (t0 + 4954);
    t10 = xsi_mem_cmp(t8, t2, 3U);
    if (t10 == 1)
        goto LAB5;

LAB11:    t11 = (t0 + 4957);
    t13 = xsi_mem_cmp(t11, t2, 3U);
    if (t13 == 1)
        goto LAB6;

LAB12:    t14 = (t0 + 4960);
    t16 = xsi_mem_cmp(t14, t2, 3U);
    if (t16 == 1)
        goto LAB7;

LAB13:
LAB8:    xsi_set_current_line(78, ng0);
    t1 = (t0 + 4963);
    t3 = (t0 + 3072);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 16U);
    xsi_driver_first_trans_fast_port(t3);

LAB2:    t1 = (t0 + 2992);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(48, ng0);
    t17 = (t0 + 1192U);
    t18 = *((char **)t17);
    t19 = *((unsigned char *)t18);
    t20 = (t19 == (unsigned char)3);
    if (t20 != 0)
        goto LAB15;

LAB17:    xsi_set_current_line(51, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t23 = (15 - 10);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t1 = (t2 + t25);
    t3 = (t26 + 0U);
    t5 = (t3 + 0U);
    *((int *)t5) = 10;
    t5 = (t3 + 4U);
    *((int *)t5) = 0;
    t5 = (t3 + 8U);
    *((int *)t5) = -1;
    t4 = (0 - 10);
    t30 = (t4 * -1);
    t30 = (t30 + 1);
    t5 = (t3 + 12U);
    *((unsigned int *)t5) = t30;
    t5 = ieee_p_3499444699_sub_854811550_3536714472(IEEE_P_3499444699, t21, t1, t26, 16);
    t6 = (t21 + 12U);
    t30 = *((unsigned int *)t6);
    t30 = (t30 * 1U);
    t19 = (16U != t30);
    if (t19 == 1)
        goto LAB20;

LAB21:    t8 = (t0 + 3072);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    memcpy(t14, t5, 16U);
    xsi_driver_first_trans_fast_port(t8);

LAB16:    goto LAB2;

LAB4:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t19 = *((unsigned char *)t2);
    t20 = (t19 == (unsigned char)3);
    if (t20 != 0)
        goto LAB22;

LAB24:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t23 = (15 - 7);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t1 = (t2 + t25);
    t3 = (t26 + 0U);
    t5 = (t3 + 0U);
    *((int *)t5) = 7;
    t5 = (t3 + 4U);
    *((int *)t5) = 0;
    t5 = (t3 + 8U);
    *((int *)t5) = -1;
    t4 = (0 - 7);
    t30 = (t4 * -1);
    t30 = (t30 + 1);
    t5 = (t3 + 12U);
    *((unsigned int *)t5) = t30;
    t5 = ieee_p_3499444699_sub_854811550_3536714472(IEEE_P_3499444699, t21, t1, t26, 16);
    t6 = (t21 + 12U);
    t30 = *((unsigned int *)t6);
    t30 = (t30 * 1U);
    t19 = (16U != t30);
    if (t19 == 1)
        goto LAB27;

LAB28:    t8 = (t0 + 3072);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    memcpy(t14, t5, 16U);
    xsi_driver_first_trans_fast_port(t8);

LAB23:    goto LAB2;

LAB5:    xsi_set_current_line(60, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t19 = *((unsigned char *)t2);
    t20 = (t19 == (unsigned char)3);
    if (t20 != 0)
        goto LAB29;

LAB31:    xsi_set_current_line(63, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t23 = (15 - 4);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t1 = (t2 + t25);
    t3 = (t26 + 0U);
    t5 = (t3 + 0U);
    *((int *)t5) = 4;
    t5 = (t3 + 4U);
    *((int *)t5) = 0;
    t5 = (t3 + 8U);
    *((int *)t5) = -1;
    t4 = (0 - 4);
    t30 = (t4 * -1);
    t30 = (t30 + 1);
    t5 = (t3 + 12U);
    *((unsigned int *)t5) = t30;
    t5 = ieee_p_3499444699_sub_854811550_3536714472(IEEE_P_3499444699, t21, t1, t26, 16);
    t6 = (t21 + 12U);
    t30 = *((unsigned int *)t6);
    t30 = (t30 * 1U);
    t19 = (16U != t30);
    if (t19 == 1)
        goto LAB34;

LAB35:    t8 = (t0 + 3072);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    memcpy(t14, t5, 16U);
    xsi_driver_first_trans_fast_port(t8);

LAB30:    goto LAB2;

LAB6:    xsi_set_current_line(66, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t19 = *((unsigned char *)t2);
    t20 = (t19 == (unsigned char)3);
    if (t20 != 0)
        goto LAB36;

LAB38:    xsi_set_current_line(69, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t23 = (15 - 4);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t1 = (t2 + t25);
    t3 = (t26 + 0U);
    t5 = (t3 + 0U);
    *((int *)t5) = 4;
    t5 = (t3 + 4U);
    *((int *)t5) = 2;
    t5 = (t3 + 8U);
    *((int *)t5) = -1;
    t4 = (2 - 4);
    t30 = (t4 * -1);
    t30 = (t30 + 1);
    t5 = (t3 + 12U);
    *((unsigned int *)t5) = t30;
    t5 = ieee_p_3499444699_sub_854811550_3536714472(IEEE_P_3499444699, t21, t1, t26, 16);
    t6 = (t21 + 12U);
    t30 = *((unsigned int *)t6);
    t30 = (t30 * 1U);
    t19 = (16U != t30);
    if (t19 == 1)
        goto LAB41;

LAB42:    t8 = (t0 + 3072);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    memcpy(t14, t5, 16U);
    xsi_driver_first_trans_fast_port(t8);

LAB37:    goto LAB2;

LAB7:    xsi_set_current_line(72, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t19 = *((unsigned char *)t2);
    t20 = (t19 == (unsigned char)3);
    if (t20 != 0)
        goto LAB43;

LAB45:    xsi_set_current_line(75, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t23 = (15 - 3);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t1 = (t2 + t25);
    t3 = (t26 + 0U);
    t5 = (t3 + 0U);
    *((int *)t5) = 3;
    t5 = (t3 + 4U);
    *((int *)t5) = 0;
    t5 = (t3 + 8U);
    *((int *)t5) = -1;
    t4 = (0 - 3);
    t30 = (t4 * -1);
    t30 = (t30 + 1);
    t5 = (t3 + 12U);
    *((unsigned int *)t5) = t30;
    t5 = ieee_p_3499444699_sub_854811550_3536714472(IEEE_P_3499444699, t21, t1, t26, 16);
    t6 = (t21 + 12U);
    t30 = *((unsigned int *)t6);
    t30 = (t30 * 1U);
    t19 = (16U != t30);
    if (t19 == 1)
        goto LAB48;

LAB49:    t8 = (t0 + 3072);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    memcpy(t14, t5, 16U);
    xsi_driver_first_trans_fast_port(t8);

LAB44:    goto LAB2;

LAB14:;
LAB15:    xsi_set_current_line(49, ng0);
    t17 = (t0 + 1032U);
    t22 = *((char **)t17);
    t23 = (15 - 10);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t17 = (t22 + t25);
    t27 = (t26 + 0U);
    t28 = (t27 + 0U);
    *((int *)t28) = 10;
    t28 = (t27 + 4U);
    *((int *)t28) = 0;
    t28 = (t27 + 8U);
    *((int *)t28) = -1;
    t29 = (0 - 10);
    t30 = (t29 * -1);
    t30 = (t30 + 1);
    t28 = (t27 + 12U);
    *((unsigned int *)t28) = t30;
    t28 = ieee_p_3499444699_sub_871414444_3536714472(IEEE_P_3499444699, t21, t17, t26, 16);
    t31 = (t21 + 12U);
    t30 = *((unsigned int *)t31);
    t30 = (t30 * 1U);
    t32 = (16U != t30);
    if (t32 == 1)
        goto LAB18;

LAB19:    t33 = (t0 + 3072);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    memcpy(t37, t28, 16U);
    xsi_driver_first_trans_fast_port(t33);
    goto LAB16;

LAB18:    xsi_size_not_matching(16U, t30, 0);
    goto LAB19;

LAB20:    xsi_size_not_matching(16U, t30, 0);
    goto LAB21;

LAB22:    xsi_set_current_line(55, ng0);
    t1 = (t0 + 1032U);
    t3 = *((char **)t1);
    t23 = (15 - 7);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t1 = (t3 + t25);
    t5 = (t26 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 7;
    t6 = (t5 + 4U);
    *((int *)t6) = 0;
    t6 = (t5 + 8U);
    *((int *)t6) = -1;
    t4 = (0 - 7);
    t30 = (t4 * -1);
    t30 = (t30 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t30;
    t6 = ieee_p_3499444699_sub_871414444_3536714472(IEEE_P_3499444699, t21, t1, t26, 16);
    t8 = (t21 + 12U);
    t30 = *((unsigned int *)t8);
    t30 = (t30 * 1U);
    t32 = (16U != t30);
    if (t32 == 1)
        goto LAB25;

LAB26:    t9 = (t0 + 3072);
    t11 = (t9 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t6, 16U);
    xsi_driver_first_trans_fast_port(t9);
    goto LAB23;

LAB25:    xsi_size_not_matching(16U, t30, 0);
    goto LAB26;

LAB27:    xsi_size_not_matching(16U, t30, 0);
    goto LAB28;

LAB29:    xsi_set_current_line(61, ng0);
    t1 = (t0 + 1032U);
    t3 = *((char **)t1);
    t23 = (15 - 4);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t1 = (t3 + t25);
    t5 = (t26 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 4;
    t6 = (t5 + 4U);
    *((int *)t6) = 0;
    t6 = (t5 + 8U);
    *((int *)t6) = -1;
    t4 = (0 - 4);
    t30 = (t4 * -1);
    t30 = (t30 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t30;
    t6 = ieee_p_3499444699_sub_871414444_3536714472(IEEE_P_3499444699, t21, t1, t26, 16);
    t8 = (t21 + 12U);
    t30 = *((unsigned int *)t8);
    t30 = (t30 * 1U);
    t32 = (16U != t30);
    if (t32 == 1)
        goto LAB32;

LAB33:    t9 = (t0 + 3072);
    t11 = (t9 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t6, 16U);
    xsi_driver_first_trans_fast_port(t9);
    goto LAB30;

LAB32:    xsi_size_not_matching(16U, t30, 0);
    goto LAB33;

LAB34:    xsi_size_not_matching(16U, t30, 0);
    goto LAB35;

LAB36:    xsi_set_current_line(67, ng0);
    t1 = (t0 + 1032U);
    t3 = *((char **)t1);
    t23 = (15 - 4);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t1 = (t3 + t25);
    t5 = (t26 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 4;
    t6 = (t5 + 4U);
    *((int *)t6) = 2;
    t6 = (t5 + 8U);
    *((int *)t6) = -1;
    t4 = (2 - 4);
    t30 = (t4 * -1);
    t30 = (t30 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t30;
    t6 = ieee_p_3499444699_sub_871414444_3536714472(IEEE_P_3499444699, t21, t1, t26, 16);
    t8 = (t21 + 12U);
    t30 = *((unsigned int *)t8);
    t30 = (t30 * 1U);
    t32 = (16U != t30);
    if (t32 == 1)
        goto LAB39;

LAB40:    t9 = (t0 + 3072);
    t11 = (t9 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t6, 16U);
    xsi_driver_first_trans_fast_port(t9);
    goto LAB37;

LAB39:    xsi_size_not_matching(16U, t30, 0);
    goto LAB40;

LAB41:    xsi_size_not_matching(16U, t30, 0);
    goto LAB42;

LAB43:    xsi_set_current_line(73, ng0);
    t1 = (t0 + 1032U);
    t3 = *((char **)t1);
    t23 = (15 - 3);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t1 = (t3 + t25);
    t5 = (t26 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 3;
    t6 = (t5 + 4U);
    *((int *)t6) = 0;
    t6 = (t5 + 8U);
    *((int *)t6) = -1;
    t4 = (0 - 3);
    t30 = (t4 * -1);
    t30 = (t30 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t30;
    t6 = ieee_p_3499444699_sub_871414444_3536714472(IEEE_P_3499444699, t21, t1, t26, 16);
    t8 = (t21 + 12U);
    t30 = *((unsigned int *)t8);
    t30 = (t30 * 1U);
    t32 = (16U != t30);
    if (t32 == 1)
        goto LAB46;

LAB47:    t9 = (t0 + 3072);
    t11 = (t9 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t6, 16U);
    xsi_driver_first_trans_fast_port(t9);
    goto LAB44;

LAB46:    xsi_size_not_matching(16U, t30, 0);
    goto LAB47;

LAB48:    xsi_size_not_matching(16U, t30, 0);
    goto LAB49;

}


extern void work_a_2250428819_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2250428819_3212880686_p_0};
	xsi_register_didat("work_a_2250428819_3212880686", "isim/TMTest_isim_beh.exe.sim/work/a_2250428819_3212880686.didat");
	xsi_register_executes(pe);
}
